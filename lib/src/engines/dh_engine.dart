import 'package:diffie_hellman/src/models/dh_key_pair.dart';
import 'package:flutter/foundation.dart';

abstract class DhEngine {

  BigInt get publicKey;

  BigInt get privateKey;

  BigInt get secretKey;

  DhKeyPair generateKeyPair();

  BigInt computeSecretKey(BigInt otherPublicKey);

  @protected
  BigInt generatePrivateKey();

  @protected
  BigInt generatePublicKey(BigInt privateKey);
}
