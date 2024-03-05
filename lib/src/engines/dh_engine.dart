import 'package:diffie_hellman/src/keys/dh_key.dart';
import 'package:diffie_hellman/src/keys/dh_private_key.dart';
import 'package:diffie_hellman/src/keys/dh_public_key.dart';
import 'package:meta/meta.dart';

abstract class DhEngine {
  DhPublicKey? get publicKey;

  DhPrivateKey? get privateKey;

  DhKeyPair? get keyPair;

  BigInt? get secretKey;

  DhKeyPair generateKeyPair();

  BigInt computeSecretKey(BigInt otherPublicValue);

  @protected
  DhPrivateKey generatePrivateKey();

  @protected
  DhPublicKey generatePublicKey(BigInt privateValue);
}
