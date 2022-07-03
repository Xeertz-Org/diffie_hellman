# Dart Diffie-Hellman
Pure Dart implementation of modular DH groups

## Usage
`DhPkcs3Engine dhEngine = DhPkcs3Engine.fromGroup(18);
DhPkcs3Engine otherDhEngine = DhPkcs3Engine.fromGroup(18);
DhKeyPair keyPair = dhEngine.generateKeyPair();
DhKeyPair otherKeyPair = otherDhEngine.generateKeyPair();
print('Public Key: ${keyPair.publicKey}');
print('Private Key: ${keyPair.privateKey}');
print('Other public Key: ${otherKeyPair.publicKey}');
print('Other private Key: ${otherKeyPair.privateKey}');

otherDhEngine.computeSecretKey(keyPair.publicKey);

print('Secret Key: ${dhEngine.computeSecretKey(otherKeyPair.publicKey)}');
print(
'Other secret Key: ${otherDhEngine.computeSecretKey(otherKeyPair.publicKey)}');
`