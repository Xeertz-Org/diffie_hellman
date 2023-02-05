import 'package:diffie_hellman/src/engines/dh_pkcs3_engine.dart';
import 'package:diffie_hellman/src/models/dh_key_pair.dart';
import 'package:flutter/cupertino.dart';

void main() {
  DhPkcs3Engine dhEngine = DhPkcs3Engine.fromGroup(18);
  DhPkcs3Engine otherDhEngine = DhPkcs3Engine.fromGroup(18);

  DhKeyPair keyPair = dhEngine.generateKeyPair();
  DhKeyPair otherKeyPair = otherDhEngine.generateKeyPair();

  debugPrint('Public Key: ${keyPair.publicKey}');
  debugPrint('Private Key: ${keyPair.privateKey}');
  debugPrint('Other public Key: ${otherKeyPair.publicKey}');
  debugPrint('Other private Key: ${otherKeyPair.privateKey}');
}
