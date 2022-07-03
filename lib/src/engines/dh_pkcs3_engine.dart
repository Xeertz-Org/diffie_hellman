import 'package:diffie_hellman/src/dh_groups.dart';
import 'package:diffie_hellman/src/engines/dh_engine.dart';
import 'package:diffie_hellman/src/models/dh_key_pair.dart';
import 'package:diffie_hellman/src/models/dh_parameter_spec.dart';
import 'package:diffie_hellman/src/rng/dh_fortuna_prng.dart';
import 'package:flutter/cupertino.dart';

class DhPkcs3Engine implements DhEngine {
  final DhParameterSpec _parameterSpec;

  late final BigInt _publicKey;
  late final BigInt _privateKey;
  late final BigInt _secretKey;

  DhParameterSpec get parameterSpec => _parameterSpec;

  @override
  BigInt get publicKey => _publicKey;

  @override
  BigInt get privateKey => _privateKey;

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

  DhPkcs3Engine({
    required DhParameterSpec parameterSpec,
  }) : _parameterSpec = parameterSpec;

  @override
  BigInt computeSecretKey(BigInt otherPublicKey) {
    return otherPublicKey.modPow(
      _privateKey,
      _parameterSpec.p,
    );
  }

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
    return DhFortunaPrng.generateDhPrivateValue(_parameterSpec.length);
  }

  @override
  @protected
  BigInt generatePublicKey(BigInt privateKey) {
    return BigInt.from(_parameterSpec.g,).modPow(
      privateKey,
      _parameterSpec.p,
    );
  }
}
