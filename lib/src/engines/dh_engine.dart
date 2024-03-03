import 'package:diffie_hellman/src/engines/models/dh_key_pair.dart';
import 'package:meta/meta.dart';

abstract class DhEngine {
  BigInt? get publicKey;

  BigInt? get privateKey;

  DhKeyPair? get keyPair;

  BigInt? get secretKey;

  DhKeyPair generateKeyPair();

  BigInt computeSecretKey(BigInt otherPublicKey);

  @protected
  BigInt generatePrivateKey();

  @protected
  BigInt generatePublicKey(BigInt privateKey);
}
