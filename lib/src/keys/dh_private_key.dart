import 'package:diffie_hellman/src/keys/codec/dh_private_key_codec.dart';
import 'package:diffie_hellman/src/keys/dh_key.dart';

class DhPrivateKey extends DhKey {
  DhPrivateKey(super.value, {required super.parameter})
    : super(codec: DhPrivateKeyCodec());

  /// Constructs a [DhPrivateKey] instance using a PEM string.
  /// The [parameter] is derived from the decoded key
  factory DhPrivateKey.fromPem(String pem) =>
      DhKey.fromPem(pem, codec: DhPrivateKeyCodec()) as DhPrivateKey;
}
