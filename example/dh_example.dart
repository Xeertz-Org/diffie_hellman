import 'package:diffie_hellman/src/engines/dh_pkcs3_engine.dart';
import 'package:diffie_hellman/src/models/dh_key_pair.dart';

void main() {
  DhPkcs3Engine dhEngine = DhPkcs3Engine.fromGroup(18);
  DhPkcs3Engine otherDhEngine = DhPkcs3Engine.fromGroup(18);

  DhKeyPair keyPair = dhEngine.generateKeyPair();
  DhKeyPair otherKeyPair = otherDhEngine.generateKeyPair();

  print('Public Key: ${keyPair.publicKey}');
  print('Private Key: ${keyPair.privateKey}');
  print('Other public Key: ${otherKeyPair.publicKey}');
  print('Other private Key: ${otherKeyPair.privateKey}');
}