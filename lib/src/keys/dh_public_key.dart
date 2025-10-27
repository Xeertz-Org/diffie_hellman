import 'package:diffie_hellman/src/keys/codec/dh_public_key_codec.dart';
import 'package:diffie_hellman/src/keys/dh_key.dart';

class DhPublicKey extends DhKey {
  DhPublicKey(super.value, {required super.parameter})
    : super(codec: DhPublicKeyCodec());

  /// Constructs a [DhPublicKey] instance using a PEM string.
  /// The [parameter] is derived from the decoded key
  factory DhPublicKey.fromPem(String pem) =>
      DhKey.fromPem(pem, codec: DhPublicKeyCodec()) as DhPublicKey;
}
