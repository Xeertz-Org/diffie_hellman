import 'package:diffie_hellman/diffie_hellman.dart';

void main() {
  DhPkcs3Engine dhEngine = DhPkcs3Engine.fromGroup(DhGroup.g5);
  DhPkcs3Engine otherDhEngine = DhPkcs3Engine.fromGroup(DhGroup.g5);

  DhKeyPair keyPair = dhEngine.generateKeyPair();
  DhKeyPair otherKeyPair = otherDhEngine.generateKeyPair();

  print('Public key: ${keyPair.publicKey.value}');
  print('Private key: ${keyPair.privateKey.value}');
  print('Other public key: ${otherKeyPair.publicKey.value}');
  print('Other private key: ${otherKeyPair.privateKey.value}');

  print(
    'Secret key: ${dhEngine.computeSecretKey(otherKeyPair.publicKey.value)}',
  );
  print(
    'Other secret key: ${otherDhEngine.computeSecretKey(keyPair.publicKey.value)}',
  );

  print('Public key PEM: ${keyPair.publicKey.toPem()}');
  print('Other public key PEM: ${otherKeyPair.publicKey.toPem()}');

  print('Private key PEM: ${keyPair.privateKey.toPem()}');
  print('Other private key PEM: ${otherKeyPair.privateKey.toPem()}');
}
