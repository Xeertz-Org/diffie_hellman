import 'package:diffie_hellman/src/dh_groups.dart';
import 'package:diffie_hellman/src/engines/dh_engine.dart';
import 'package:diffie_hellman/src/models/dh_key_pair.dart';
import 'package:diffie_hellman/src/models/dh_parameter_spec.dart';
import 'package:diffie_hellman/src/rng/secure_random_generator.dart';
import 'package:flutter/cupertino.dart';

/// Concrete implementation of [DhEngine].
/// Use the constructor DhPkcs3Engine.fromGroup() with a specific group ID
/// for predefined engine objects based on https://www.ietf.org/rfc/rfc3526.txt
class DhPkcs3Engine implements DhEngine {
  final DhParameterSpec _parameterSpec;

  late final BigInt _publicKey;
  late final BigInt _privateKey;
  late final BigInt _secretKey;

  /// Diffie-Hellman parameters used by this engine
  DhParameterSpec get parameterSpec => _parameterSpec;

  // Set public Key
  set setPublicKey(BigInt publicKey) => _publicKey = publicKey;

  // Set private Key
  set setPrivateKey(BigInt private) => _privateKey = private;

  /// Must call generateKeyPair() method before accessing this value
  @override
  BigInt get publicKey => _publicKey;

  /// Must call generateKeyPair() method before accessing this value
  @override
  BigInt get privateKey => _privateKey;

  // Must call computeSecretKey() method before accessing this value
  @override
  BigInt get secretKey => _secretKey;

  factory DhPkcs3Engine.fromGroup(int groupId,
      {int privateKeyLength = DhParameterSpec.defaultPrivateKeyLength}) {
    return DhPkcs3Engine(
      parameterSpec: DhGroups.getDhParametersFromGroup(
        groupId,
        privateKeyLength: privateKeyLength,
      ),
    );
  }

  /// Construct an engine with the desired [DhParameterSpec]
  DhPkcs3Engine({
    required DhParameterSpec parameterSpec,
  }) : _parameterSpec = parameterSpec;

  /// Compute the secret key using the other party public key
  @override
  BigInt computeSecretKey(BigInt otherPublicKey) {
    return otherPublicKey.modPow(
      _privateKey,
      _parameterSpec.p,
    );
  }

  /// Generate [publicKey] and [privateKey] based on the [parameterSpec] of this engine
  @override
  DhKeyPair generateKeyPair() {
    _privateKey = generatePrivateKey();
    _publicKey = generatePublicKey(privateKey);
    return DhKeyPair(
      publicKey: _publicKey,
      privateKey: _privateKey,
    );
  }

  @override
  @protected
  BigInt generatePrivateKey() {
    return SecureRandomGenerator.generateDhPrivateValue(_parameterSpec.length);
  }

  @override
  @protected
  BigInt generatePublicKey(BigInt privateKey) {
    return BigInt.from(
      _parameterSpec.g,
    ).modPow(
      privateKey,
      _parameterSpec.p,
    );
  }
}
