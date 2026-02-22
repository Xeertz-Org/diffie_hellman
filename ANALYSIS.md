# Codebase Analysis Report — `diffie_hellman` v1.4.0

**Date:** 2026-02-22
**Scope:** Full repository audit — functional correctness, cryptographic soundness, SOLID/clean-code compliance, and strategic improvement roadmap.

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Functional Correctness Analysis](#2-functional-correctness-analysis)
3. [Cryptographic Soundness Review](#3-cryptographic-soundness-review)
4. [SOLID Principles Compliance](#4-solid-principles-compliance)
5. [Clean Code & General Design Review](#5-clean-code--general-design-review)
6. [Test Suite Assessment](#6-test-suite-assessment)
7. [Action Items for Full Compliance](#7-action-items-for-full-compliance)
8. [Strategic Improvement Roadmap](#8-strategic-improvement-roadmap)

---

## 1. Executive Summary

The library is a well-structured, focused Dart implementation of finite-field Diffie-Hellman key exchange (PKCS#3). The code is readable, reasonably modular, and has meaningful test coverage across all layers. However, the audit has identified **3 critical bugs**, **4 security gaps**, and **several SOLID/design-principle violations** that should be addressed before the library can be considered production-grade for cryptographic use.

**Severity distribution:**

| Severity | Count |
|----------|-------|
| Critical (functional bug) | 3 |
| High (security gap) | 4 |
| Medium (design violation) | 7 |
| Low (code quality) | 6 |

---

## 2. Functional Correctness Analysis

### 2.1 CRITICAL — `_secretKey` is never assigned

**File:** `lib/src/engines/dh_pkcs3_engine.dart:53-60`

```dart
BigInt computeSecretKey(BigInt otherPublicValue) {
  if (_keyPair == null) {
    throw StateError(...);
  }
  return otherPublicValue.modPow(privateKey!.value, parameter.p);
}
```

The method computes and **returns** the secret key but never stores it in `_secretKey`. The `secretKey` getter will **always** return `null`, making the field dead code. The engine's advertised statefulness contract (`BigInt? get secretKey`) is broken.

**Fix:** Either assign `_secretKey = result` before returning, or remove the `_secretKey` field and `secretKey` getter entirely in favor of a purely functional return-value approach.

---

### 2.2 CRITICAL — `DhKey.props` includes non-equatable codec instance

**File:** `lib/src/keys/dh_key.dart:21`

```dart
@override
List<Object> get props => [value, parameter, _codec];
```

`DhKeyCodec` does not extend `Equatable` nor override `==`. Each key constructor creates a **fresh** codec instance (e.g., `DhPrivateKeyCodec()`), so two `DhPrivateKey` objects with identical `value` and `parameter` will **not** be considered equal by Equatable. This breaks any round-trip equality assertion:

```dart
final key = DhPrivateKey(x, parameter: p);
final pem = key.toPem();
final restored = DhPrivateKey.fromPem(pem);
assert(key == restored); // FAILS — different codec instances
```

**Fix:** Remove `_codec` from `props`. Codec identity is an implementation detail and should not participate in value equality.

---

### 2.3 CRITICAL — PEM format non-compliant (no line wrapping, no newlines)

**File:** `lib/src/base/pem_codec.dart:24`

```dart
return '$beginDelimiter$base64$endDelimiter';
```

RFC 7468 (and the de-facto PEM standard) requires:
- A newline after the BEGIN delimiter
- Base64 content wrapped at 64 characters per line
- A newline before the END delimiter

The current output concatenates everything into a single line with no line breaks anywhere. While the library can round-trip its own output, PEM strings produced by this library **will not be parseable by OpenSSL or most other DH implementations**, and vice versa. For a library whose stated purpose is PKCS#3-based serialization, this is a significant interoperability defect.

**Fix:** Insert `\n` after the BEGIN delimiter, wrap base64 at 64-character lines, and insert `\n` before the END delimiter.

---

### 2.4 MEDIUM — `nextBigInt` rejects non-byte-aligned bit lengths

**File:** `lib/src/utils/extensions.dart:7-8`

```dart
if (bitLength % 8 != 0) {
  throw ArgumentError('Invalid bitLength value - $bitLength');
}
```

This means `generatePrivateValueWithLength` cannot be called with any `l` value that is not a multiple of 8. All predefined groups happen to satisfy this constraint, but the library accepts arbitrary `DhParameter` objects via `DhPkcs3Engine.fromParameter()`. A user providing a custom parameter with, for example, `l: 161` would get an unrecoverable `ArgumentError` at random-generation time.

**Fix:** Support arbitrary bit lengths by generating `ceil(bitLength / 8)` bytes and masking the top bits.

---

### 2.5 MEDIUM — Private key encoding deviates from PKCS#8

**File:** `lib/src/keys/codec/dh_private_key_codec.dart:24-26`

```dart
ASN1OctetString privateKeyOctetString = ASN1OctetString(
  key.value.toBigEndianBytes(),
);
```

Per RFC 5958 / PKCS#8, the `privateKey` OCTET STRING should contain the **DER-encoded** ASN.1 INTEGER of the private value, not the raw big-endian bytes:

```
PrivateKeyInfo ::= SEQUENCE {
  version                   Version,
  privateKeyAlgorithm       AlgorithmIdentifier,
  privateKey                OCTET STRING  -- contains DER(INTEGER)
}
```

The current encoding places raw bytes in the OCTET STRING, which means keys exported from this library cannot be loaded by OpenSSL (`openssl pkey -in key.pem`) and vice versa.

**Fix:** Wrap the private value as `ASN1Integer` inside the `ASN1OctetString`:
```dart
ASN1Sequence innerSeq = ASN1Sequence();
innerSeq.add(ASN1Integer(key.value));
ASN1OctetString octet = ASN1OctetString(innerSeq.encodedBytes);
```
Or more precisely, encode just the integer's DER bytes into the octet string.

---

### 2.6 LOW — `toBigEndianBytes()` produces empty list for `BigInt.zero`

**File:** `lib/src/utils/extensions.dart:32`

```dart
int bytesLength = (bitLength + 7) >> 3;
```

`BigInt.zero.bitLength` is `0`, producing `bytesLength = 0` and an empty `Uint8List`. While unlikely in normal DH operation, this is a correctness hazard if the extension is used elsewhere.

---

## 3. Cryptographic Soundness Review

### 3.1 HIGH — No public key validation

**File:** `lib/src/engines/dh_pkcs3_engine.dart:53`

```dart
BigInt computeSecretKey(BigInt otherPublicValue) {
  ...
  return otherPublicValue.modPow(privateKey!.value, parameter.p);
}
```

The method accepts **any** `BigInt` without validation. An attacker can supply:

| Malicious value | Resulting shared secret |
|----------------|------------------------|
| `0`            | `0`                    |
| `1`            | `1`                    |
| `p - 1`        | `1` or `p - 1`         |
| `p`            | `0`                    |

This enables trivial key recovery (the attacker knows the shared secret without knowing the private key). Per RFC 2631 Section 2.1.5, implementations **must** validate:
- `2 <= otherPublicValue <= p - 2`

For groups with known subgroup order `q` (g22, g23, g24), the additional check should be:
- `otherPublicValue^q mod p == 1`

**Fix:** Add validation at the top of `computeSecretKey`:
```dart
if (otherPublicValue < BigInt.two || otherPublicValue > parameter.p - BigInt.two) {
  throw ArgumentError('Public key out of safe range [2, p-2]');
}
```

---

### 3.2 HIGH — No private key range validation

**File:** `lib/src/keys/dh_private_key.dart:5`

The `DhPrivateKey` constructor accepts any `BigInt` value without checking that it falls within a cryptographically valid range. A private key of `0`, `1`, or `p-1` would produce degenerate public keys. The constructor should enforce `2 <= value <= p - 2` (or the more restrictive range dictated by the exponent length `l`).

---

### 3.3 HIGH — No parameter validation in `DhParameter`

**File:** `lib/src/spec/dh_parameter.dart:6`

The comment explicitly states: *"Note that this class does not perform any validation on specified parameters."*

For custom parameters supplied via `DhPkcs3Engine.fromParameter()`, there is no validation that:
- `p` is prime (or at minimum, odd and > 2)
- `g` is in range `[2, p-2]`
- `l` is positive and reasonable relative to `p`'s bit length

While full primality testing may be expensive, basic sanity checks (p is odd, g >= 2, l > 0) are cheap and prevent misuse.

---

### 3.4 HIGH — Weak groups (g1, g2) are offered without deprecation warnings

Group 1 (768-bit) was broken by academic teams in 2016. Group 2 (1024-bit) is considered below the security margin recommended by NIST (SP 800-57 Part 1 recommends minimum 2048-bit DH since 2015). The library offers these groups at parity with stronger groups, with no runtime warning, deprecation annotation, or documentation note discouraging their use.

**Fix:** Annotate `DhGroup.g1` and `DhGroup.g2` with `@Deprecated('...')` and document the security implications.

---

### 3.5 MEDIUM — No constant-time guarantee

`BigInt.modPow` in Dart's VM is not guaranteed to be constant-time. While this is a platform-level concern rather than a library-level one, it should be documented as a known limitation for environments where timing side-channels are a concern (e.g., server-side key exchange).

---

## 4. SOLID Principles Compliance

### 4.1 Single Responsibility Principle (SRP)

| Component | Assessment | Detail |
|-----------|-----------|--------|
| `PemCodec<T>` | **Pass** | Focused on PEM encode/decode |
| `DhParameter` | **Pass** | Value object for DH parameters |
| `DhKey` / `DhPublicKey` / `DhPrivateKey` | **Pass** | Value objects for keys |
| `DhPkcs3Engine` | **Partial violation** | Combines key generation, state management, and secret computation. The engine simultaneously acts as a factory (key generation), a stateful container (stores `_keyPair` and `_secretKey`), and a computation service (computes shared secrets). |
| `dh_groups.dart` | **Violation** | Mixes data definition (constants) with behavior (`getParameter()`). The free function `getParameter()` could be a static method on `DhGroup` or a dedicated factory class. The three top-level mutable `final` maps (`pMap`, `gMap`, `lMap`) are module-level shared state. |
| `DhRandomGenerator` | **Partial violation** | An `abstract class` used purely as a namespace for static methods. This is a misuse of the class keyword — should either be a proper injectable service or plain top-level functions. |

**Recommended changes:**
- Split `DhPkcs3Engine` into a `DhKeyGenerator` (key creation) and a `DhKeyAgreement` (secret computation) class, or adopt a stateless functional design where `computeSecretKey` accepts the private key as a parameter.
- Move the data maps in `dh_groups.dart` into the `DhGroup` enum body as `static final` fields.
- Convert `DhRandomGenerator` to either an injectable interface (for testability) or plain top-level functions.

---

### 4.2 Open/Closed Principle (OCP)

| Component | Assessment | Detail |
|-----------|-----------|--------|
| `PemCodec<T>` | **Pass** | Open for extension via subclassing |
| `DhEngine` | **Pass** | Abstract interface allows new implementations |
| `DhGroup` enum | **Violation** | Adding new groups requires modifying the enum, `dh_groups.dart` maps, and the constants. There is no way for a consumer to register a custom group without forking the library. |

**Recommended change:** Decouple the concept of "named group" from the enum. Allow `DhPkcs3Engine.fromParameter(DhParameter(...))` as the primary extensibility mechanism (which already exists), and consider making the enum merely a convenience catalog.

---

### 4.3 Liskov Substitution Principle (LSP)

| Component | Assessment | Detail |
|-----------|-----------|--------|
| `DhPublicKey extends DhKey` | **Pass** | |
| `DhPrivateKey extends DhKey` | **Pass** | |
| `DhPkcs3Engine implements DhEngine` | **Partial violation** | `DhEngine` declares `@protected` methods (`generatePrivateKey`, `generatePublicKey`) on an interface. In Dart, `@protected` is advisory, not enforced. However, it signals that these methods should only be called within the class hierarchy — yet they exist on the public interface type. Any consumer holding a `DhEngine` reference can call `generatePrivateKey()`. This leaks internal concerns into the public contract. |

**Recommended change:** Remove `generatePrivateKey` and `generatePublicKey` from the `DhEngine` interface. They are implementation details of `DhPkcs3Engine` and should be private or protected only within the concrete class.

---

### 4.4 Interface Segregation Principle (ISP)

| Component | Assessment | Detail |
|-----------|-----------|--------|
| `DhEngine` | **Violation** | The interface bundles: (a) state accessors (`publicKey`, `privateKey`, `keyPair`, `secretKey`), (b) key generation (`generateKeyPair`), (c) secret computation (`computeSecretKey`), and (d) internal generation methods (`generatePrivateKey`, `generatePublicKey`). A consumer that only needs to compute a shared secret from a pre-existing key pair is forced to depend on key-generation methods they don't use. |

**Recommended change:** Split into focused interfaces:
```dart
abstract class DhKeyGenerator {
  DhKeyPair generateKeyPair();
}

abstract class DhKeyAgreement {
  BigInt computeSecretKey(DhPrivateKey privateKey, BigInt otherPublicValue);
}
```

---

### 4.5 Dependency Inversion Principle (DIP)

| Component | Assessment | Detail |
|-----------|-----------|--------|
| `DhPkcs3Engine` → `DhRandomGenerator` | **Violation** | Hard-coded static call to `DhRandomGenerator.generatePrivateValueWithLength()`. Not injectable, not mockable, not testable in isolation. |
| `DhPrivateKey` → `DhPrivateKeyCodec` | **Violation** | Constructor instantiates `DhPrivateKeyCodec()` directly. Cannot substitute a different codec. |
| `DhParameter` → `DhParameterCodec` | **Violation** | Same pattern — codec is hard-wired in the constructor. |

**Recommended change:** Accept codec/random-generator as constructor parameters with sensible defaults:
```dart
DhPrivateKey(super.value, {
  required super.parameter,
  DhKeyCodec<DhPrivateKey>? codec,
}) : super(codec: codec ?? DhPrivateKeyCodec());
```

For random generation, inject a generator interface into the engine:
```dart
abstract class DhRandomSource {
  BigInt generatePrivateValue(DhParameter parameter);
}
```

---

## 5. Clean Code & General Design Review

### 5.1 Unnecessary mutability in `DhPkcs3Engine`

The engine stores `_keyPair` and `_secretKey` as mutable fields, creating a stateful object where ordering of method calls matters (`generateKeyPair()` before `computeSecretKey()`). This temporal coupling is error-prone and documented only via runtime exceptions.

**Alternative:** A stateless design where `computeSecretKey(DhPrivateKey, BigInt)` takes the private key explicitly, eliminating the need for stored state.

---

### 5.2 Redundant codec allocation

Every `DhPrivateKey`, `DhPublicKey`, and `DhParameter` construction allocates a fresh, stateless codec instance. Since codecs carry no state, these should be `const` instances or static singletons.

---

### 5.3 Unsafe cast in `fromPem` factories

**File:** `lib/src/keys/dh_private_key.dart:11`

```dart
factory DhPrivateKey.fromPem(String pem) =>
    DhKey.fromPem(pem, codec: DhPrivateKeyCodec()) as DhPrivateKey;
```

The `as DhPrivateKey` cast is technically safe because `DhPrivateKeyCodec.asn1Decode` returns `DhPrivateKey`, but this relies on an implicit contract between the codec and the key type. A generic type-safe approach would be preferable:

```dart
factory DhPrivateKey.fromPem(String pem) =>
    DhPrivateKeyCodec().decode(pem);
```

This removes both the unnecessary indirection through `DhKey.fromPem` and the downcast.

---

### 5.4 Test code duplication

**File:** `test/src/utils/dh_random_generator_test.dart`

The `generatePrivateValueFromP` tests repeat an identical pattern 8 times with only the group prime differing. This should use parameterized tests:

```dart
for (final entry in {'g1': g1P, 'g2': g2P, ...}.entries) {
  test('generatePrivateValueFromP - ${entry.key}', () {
    BigInt p = BigInt.parse(entry.value, radix: 16);
    BigInt privateValue = DhRandomGenerator.generatePrivateValueFromP(p);
    expect(privateValue, greaterThan(BigInt.zero));
    expect(privateValue, lessThan(p - BigInt.one));
  });
}
```

---

### 5.5 Top-level mutable maps in `dh_groups.dart`

`pMap`, `gMap`, and `lMap` are declared as `final Map<...>` — the references are final but the maps themselves are mutable. Any consumer with access to these library-internal maps could mutate them (e.g., `pMap[DhGroup.g1] = BigInt.zero`). They should be unmodifiable:

```dart
static final Map<DhGroup, BigInt> pMap = Map.unmodifiable({...});
```

Or, better yet, moved into the `DhGroup` enum as computed properties.

---

### 5.6 Missing `@override` annotations and doc comments

Several public API members lack documentation:
- `DhPrivateKey`, `DhPublicKey` classes have no class-level doc comments
- `DhKeyCodec`, `DhPrivateKeyCodec`, `DhPublicKeyCodec` have no class-level doc comments
- `DhRandomGenerator` methods lack doc comments explaining the range guarantees

---

## 6. Test Suite Assessment

### 6.1 Coverage strengths

- All core components have dedicated test files
- PEM round-trip serialization is tested for parameters and keys
- Engine lifecycle (construction, generation, computation) is tested
- Error paths (missing key pair, mismatched parameters, corrupt PEM) are tested
- Benchmark suite provides confidence across all groups

### 6.2 Coverage gaps

| Gap | Severity | Detail |
|-----|----------|--------|
| `secretKey` getter never tested after computation | High | The bug in 2.1 exists precisely because no test checks `engine.secretKey` after `computeSecretKey()` |
| No key equality round-trip test | High | No test creates a key, exports to PEM, re-imports, and asserts equality — the bug in 2.2 would be caught by this |
| No cross-implementation interop test | Medium | No test verifies that PEM output is parseable by OpenSSL or another DH library |
| No invalid public key test | Medium | No test verifies behavior when `computeSecretKey` receives `0`, `1`, `p-1`, or `p` |
| No custom (non-predefined) parameter test | Medium | `DhPkcs3Engine.fromParameter()` with a user-provided `DhParameter` is never tested |
| No negative test for `nextBigInt` with non-multiple-of-8 | Low | The `ArgumentError` path for non-byte-aligned bit lengths is not tested |
| Benchmark test in `diffie_hellman_test.dart` conflates benchmarking with correctness | Low | Performance measurement and correctness assertions are mixed in the same test suite |

---

## 7. Action Items for Full Compliance

Ordered by priority:

### P0 — Critical bugs

1. **Fix `_secretKey` assignment** — Either store the result in `computeSecretKey` or remove the dead field and getter.
2. **Remove `_codec` from `DhKey.props`** — Codec should not participate in value equality.
3. **Fix PEM line formatting** — Add newlines and 64-character line wrapping per RFC 7468.

### P1 — Security gaps

4. **Add public key validation in `computeSecretKey`** — Reject values outside `[2, p-2]`.
5. **Add subgroup order validation for g22/g23/g24** — Verify `pubKey^q mod p == 1`.
6. **Add basic parameter validation in `DhParameter`** — At minimum: `p > 2`, `p` is odd, `g >= 2`, `g < p`, `l > 0` (if provided).
7. **Deprecate `DhGroup.g1` and `DhGroup.g2`** — Mark with `@Deprecated` and document security concerns.

### P2 — PKCS#8 compliance

8. **Fix private key OCTET STRING encoding** — Wrap the private value as a DER-encoded INTEGER inside the OCTET STRING per RFC 5958.

### P3 — Design improvements

9. **Remove `@protected` methods from `DhEngine` interface** — Move to concrete class only.
10. **Support non-byte-aligned bit lengths in `nextBigInt`** — Generate `ceil(bitLength/8)` bytes and mask.
11. **Make group data maps unmodifiable** — Prevent runtime mutation.
12. **Add dependency injection for codec and random source** — Enable testing and extensibility.

### P4 — Code quality

13. **Reduce test duplication** — Use parameterized test patterns.
14. **Add missing doc comments** — All public API types and members.
15. **Singleton/const codecs** — Avoid unnecessary allocations.
16. **Add comprehensive test cases** — Cover gaps identified in Section 6.2.

---

## 8. Strategic Improvement Roadmap

### 8.1 ECDH Support

Dart's `pointycastle` package provides EC arithmetic, but wrapping it behind the same high-level API as this library would provide significant value. The proposal:

**Phase 1 — Abstract key agreement interface**

Introduce a protocol-agnostic abstraction:

```dart
abstract class KeyAgreement {
  KeyPair generateKeyPair();
  Uint8List computeSharedSecret(PrivateKey privateKey, PublicKey otherPublicKey);
}
```

With concrete implementations:
- `FfdhKeyAgreement` (current finite-field DH — PKCS#3)
- `EcdhKeyAgreement` (elliptic curve DH — named curves: P-256, P-384, P-521, X25519)

**Phase 2 — Named curve catalog**

Similar to `DhGroup`, provide an `EcCurve` enum:

```dart
enum EcCurve {
  p256,       // NIST P-256 / secp256r1
  p384,       // NIST P-384 / secp384r1
  p521,       // NIST P-521 / secp521r1
  x25519,     // Curve25519 (modern, recommended)
}
```

**Why this matters for users:** Dart's built-in `dart:io` provides ECDH only via platform TLS, not as a standalone primitive. Users who need ECDH key agreement outside of TLS (e.g., custom protocols, signal-style ratchets, encrypted messaging) currently have no focused Dart library for it. This library could fill that gap with a clean, consistent API.

### 8.2 Key Derivation Function (KDF) Integration

The raw shared secret from DH/ECDH should never be used directly as an encryption key. Providing optional built-in KDF support would prevent common misuse:

```dart
abstract class Kdf {
  Uint8List derive(Uint8List sharedSecret, {required int length, Uint8List? info});
}

class HkdfSha256 implements Kdf { ... }
```

The engine could offer a convenience method:

```dart
Uint8List deriveKey(BigInt otherPublicValue, {required Kdf kdf, required int length});
```

### 8.3 Secure Memory Handling

Private keys and shared secrets currently exist as standard Dart `BigInt` objects that persist in memory indefinitely. For security-sensitive applications, consider:

- A `SecureKey` wrapper that overwrites memory on disposal
- `Disposable` pattern for engines that clears `_keyPair` and `_secretKey`
- Documentation of this limitation for environments where memory safety matters

### 8.4 Serialization Format Support

Beyond PEM, consider supporting:
- **JWK (JSON Web Key)** — Widely used in web applications (RFC 7517)
- **Raw byte export** — For compact wire protocols
- **DER (binary)** — Without the PEM wrapper, for embedded systems

### 8.5 Cross-Platform Verification Suite

Add an integration test that:
1. Generates keys with this library
2. Exports them as PEM
3. Verifies them with a reference implementation (e.g., OpenSSL via `Process.run`)
4. Imports keys generated by OpenSSL and verifies interoperability

This would catch encoding/format issues like those identified in Sections 2.3 and 2.5.

### 8.6 Performance Optimization

For large groups (g17: 6144-bit, g18: 8192-bit), `BigInt.modPow` can be slow. Consider:
- Documented performance characteristics per group
- Optional platform-channel acceleration for mobile targets (using native crypto libraries)
- Lazy initialization of group parameters (currently all groups parse their hex primes at import time via `final` maps)

---

## Appendix A — File-by-File Summary

| File | Lines | Role | Issues |
|------|-------|------|--------|
| `lib/diffie_hellman.dart` | 6 | Barrel export | None |
| `lib/src/base/pem_codec.dart` | 43 | PEM encode/decode base | 2.3 (line format) |
| `lib/src/spec/dh_parameter.dart` | 32 | DH parameter value object | 3.3 (no validation) |
| `lib/src/spec/codec/dh_parameter_codec.dart` | 47 | Parameter PEM codec | None |
| `lib/src/keys/dh_key.dart` | 44 | Key base + KeyPair | 2.2 (props bug) |
| `lib/src/keys/dh_private_key.dart` | 12 | Private key | 5.3 (unsafe cast) |
| `lib/src/keys/dh_public_key.dart` | 12 | Public key | 5.3 (unsafe cast) |
| `lib/src/keys/codec/dh_key_codec.dart` | 12 | Key codec base | None |
| `lib/src/keys/codec/dh_private_key_codec.dart` | 63 | Private key PEM | 2.5 (PKCS#8 encoding) |
| `lib/src/keys/codec/dh_public_key_codec.dart` | 64 | Public key PEM | None |
| `lib/src/utils/dh_random_generator.dart` | 33 | RNG wrapper | None |
| `lib/src/utils/extensions.dart` | 44 | BigInt/byte extensions | 2.4, 2.6 |
| `lib/src/engines/dh_engine.dart` | 24 | Engine interface | 4.3, 4.4 (LSP/ISP) |
| `lib/src/engines/dh_pkcs3_engine.dart` | 89 | PKCS#3 engine impl | 2.1 (dead field), 3.1 (no validation) |
| `lib/src/groups/dh_group.dart` | 41 | Group enum | 3.4 (weak groups) |
| `lib/src/groups/dh_groups.dart` | 244 | Group constants | 5.5 (mutable maps) |

---

*End of analysis.*
