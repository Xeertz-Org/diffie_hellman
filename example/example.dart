import 'package:diffie_hellman/diffie_hellman.dart';

void main() {
  DhPkcs3Engine dhEngine = DhPkcs3Engine.fromGroup(DhGroup.g5);
  DhPkcs3Engine otherDhEngine = DhPkcs3Engine.fromGroup(DhGroup.g5);

  DhKeyPair keyPair = dhEngine.generateKeyPair();
  DhKeyPair otherKeyPair = otherDhEngine.generateKeyPair();

  print('Public Key: ${keyPair.publicKey}');
  print('Private Key: ${keyPair.privateKey}');
  print('Other public Key: ${otherKeyPair.publicKey}');
  print('Other private Key: ${otherKeyPair.privateKey}');

  print(
    'Secret Key: ${dhEngine.computeSecretKey(otherKeyPair.publicKey)}',
  );
  print(
    'Other secret Key: ${otherDhEngine.computeSecretKey(keyPair.publicKey)}',
  );
}
