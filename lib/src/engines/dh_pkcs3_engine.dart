import 'package:diffie_hellman/src/engines/dh_engine.dart';
import 'package:diffie_hellman/src/engines/models/dh_key_pair.dart';
import 'package:diffie_hellman/src/spec/dh_group.dart';
import 'package:diffie_hellman/src/spec/dh_parameter_spec.dart';
import 'package:diffie_hellman/src/utils/dh_random_generator.dart';
import 'package:meta/meta.dart';

/// Concrete implementation of [DhEngine].
/// Use the constructor DhPkcs3Engine.fromGroup() with a specific group ID
/// for predefined engine objects based on https://www.ietf.org/rfc/rfc3526.txt
class DhPkcs3Engine implements DhEngine {
  /// The Diffie-Hellman parameters used by this engine
  final DhParameterSpec parameterSpec;

  DhKeyPair? _keyPair;
  BigInt? _secretKey;

  /// Must call generateKeyPair() method before accessing this value
  @override
  BigInt? get publicKey => _keyPair?.publicKey;

  /// Must call generateKeyPair() method before accessing this value
  @override
  BigInt? get privateKey => _keyPair?.privateKey;

  @override
  DhKeyPair? get keyPair => _keyPair;

  // Must call computeSecretKey() method before accessing this value
  @override
  BigInt? get secretKey => _secretKey;

  DhPkcs3Engine._({
    required this.parameterSpec,
    DhKeyPair? keyPair,
  }) : _keyPair = keyPair;

  /// Constructs a [DhPkcs3Engine] instance using a group ID.
  ///
  /// The [group] parameter specifies the Diffie-Hellman group to use.
  /// The [privateKeyLength] parameter specifies the length of the private key.
  /// If not provided, the default value of 256 is used.
  factory DhPkcs3Engine.fromGroup(
    DhGroup group, {
    int privateKeyLength = DhParameterSpec.defaultPrivateKeyLength,
  }) =>
      DhPkcs3Engine._(parameterSpec: group.getParameterSpec(privateKeyLength));

  /// Constructs a [DhPkcs3Engine] instance using a [DhKeyPair].
  ///
  /// The [keyPair] parameter specifies the Diffie-Hellman key pair to use.
  /// The [privateKeyLength] parameter specifies the length of the private key.
  /// If not provided, the default value of 256 is used.
  factory DhPkcs3Engine.fromKeyPair(
    DhKeyPair keyPair, {
    int privateKeyLength = DhParameterSpec.defaultPrivateKeyLength,
  }) =>
      DhPkcs3Engine._(
        parameterSpec: keyPair.parameterSpec,
        keyPair: keyPair,
      );

  /// Compute the secret key using the other party public key
  @override
  BigInt computeSecretKey(BigInt otherPublicKey) {
    if (_keyPair == null) {
      throw StateError(
          'Key pair not generated. Call generateKeyPair() method first');
    }
    return otherPublicKey.modPow(
      privateKey!,
      parameterSpec.p,
    );
  }

  /// Generate [publicKey] and [privateKey] based on the [parameterSpec] of this engine
  ///
  /// If the platform cannot provide a cryptographically secure source of random numbers, an [UnsupportedError] is thrown.
  @override
  DhKeyPair generateKeyPair() {
    BigInt privateKey = generatePrivateKey();
    return _keyPair = DhKeyPair(
      parameterSpec: parameterSpec,
      publicKey: generatePublicKey(privateKey),
      privateKey: privateKey,
    );
  }

  @override
  @protected
  BigInt generatePrivateKey() =>
      DhRandomGenerator.generatePrivateValue(parameterSpec.length);

  @override
  @protected
  BigInt generatePublicKey(BigInt privateKey) => BigInt.from(
        parameterSpec.g,
      ).modPow(
        privateKey,
        parameterSpec.p,
      );
}
