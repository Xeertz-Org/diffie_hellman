import 'package:diffie_hellman/src/keys/codec/dh_key_codec.dart';
import 'package:diffie_hellman/src/keys/dh_private_key.dart';
import 'package:diffie_hellman/src/keys/dh_public_key.dart';
import 'package:diffie_hellman/src/spec/dh_parameter.dart';
import 'package:equatable/equatable.dart';

abstract class DhKey extends Equatable {
  final BigInt value;
  final DhParameter parameter;
  final DhKeyCodec _codec;

  const DhKey(
    this.value, {
    required this.parameter,
    required DhKeyCodec codec,
  }) : _codec = codec;

  factory DhKey.fromPem(
    String pem, {
    required DhKeyCodec codec,
  }) =>
      codec.decode(pem);

  String toPem() => _codec.encode(this);

  @override
  List<Object> get props => [
        value,
        parameter,
        _codec,
      ];
}

/// This class is a container for a key pair (a public key and a private key)
class DhKeyPair extends Equatable {
  final DhPublicKey publicKey;
  final DhPrivateKey privateKey;

  /// Constructs a [DhKeyPair] instance using a public key and a private key.
  /// If the public and private keys have different parameter specs, an [ArgumentError] is thrown.
  DhKeyPair({
    required this.publicKey,
    required this.privateKey,
  }) {
    if (publicKey.parameter != privateKey.parameter) {
      throw ArgumentError(
          'The public and private keys must have the same parameter spec');
    }
  }

  /// The Diffie-Hellman parameters used by this key pair
  DhParameter get parameter => publicKey.parameter;

  @override
  List<Object?> get props => [
        publicKey,
        privateKey,
      ];
}
