# Dart Diffie-Hellman

Dart implementation of finite field Diffie-Hellman. Based on PKCS#3.

## Usage

```
DhPkcs3Engine dhEngine = DhPkcs3Engine.fromGroup(DhGroup.g5);
DhPkcs3Engine otherDhEngine = DhPkcs3Engine.fromGroup(DhGroup.g5);

DhKeyPair keyPair = dhEngine.generateKeyPair();
DhKeyPair otherKeyPair = otherDhEngine.generateKeyPair();

print('Public Key: ${keyPair.publicKey.value}');
print('Private Key: ${keyPair.privateKey.value}');
print('Other public Key: ${otherKeyPair.publicKey.value}');
print('Other private Key: ${otherKeyPair.privateKey.value}');

print(
'Secret Key: ${dhEngine.computeSecretKey(otherKeyPair.publicKey.value)}',
);
print(
'Other secret Key: ${otherDhEngine.computeSecretKey(keyPair.publicKey.value)}',
);
```

### PEM serialization/deserialization

Each key can be constructed from a PEM string

```
DhPrivateKey privateKey = DhPrivateKey.fromPem('...');
DhPublicKey publicKey = DhPublicKey.fromPem('...');
```

On the other hand, the keys can be serialized to a PEM string

```
String privateKeyPem = privateKey.toPem();
String publicKeyPem = publicKey.toPem();
```

The same applies to the DH parameters

```
DhParameters parameters = DhParameters.fromPem('...');
String parametersPem = parameters.toPem();
```

## DH Groups

| Group ID | Modulus length | Strength range (in bits) |
|----------|----------------|--------------------------|
| 1        | 768-bit        | -                        |
| 2        | 1024-bit       | -                        |
| 5        | 1536-bit       | 90-120                   |
| 14       | 2048-bit       | 110-160                  |
| 15       | 3072-bit       | 130-210                  |
| 16       | 4096-bit       | 150-240                  |
| 17       | 6144-bit       | 170-270                  |
| 18       | 8192-bit       | 190-310                  |

## References

- https://www.teletrust.de/fileadmin/files/oid/oid_pkcs-3v1-4.pdf
- https://www.ietf.org/rfc/rfc3526.txt