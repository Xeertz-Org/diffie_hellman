# Dart Diffie-Hellman
Pure Dart implementation of modular DH groups. Based on PKCS#3.

## Usage
```
DhPkcs3Engine dhEngine = DhPkcs3Engine.fromGroup(18);
DhPkcs3Engine otherDhEngine = DhPkcs3Engine.fromGroup(18);

DhKeyPair keyPair = dhEngine.generateKeyPair();
DhKeyPair otherKeyPair = otherDhEngine.generateKeyPair();

print('Public Key: ${keyPair.publicKey}');
print('Private Key: ${keyPair.privateKey}');
print('Other public Key: ${otherKeyPair.publicKey}');
print('Other private Key: ${otherKeyPair.privateKey}');


print('Secret Key: ${dhEngine.computeSecretKey(otherKeyPair.publicKey)}');
print('Other secret Key: ${otherDhEngine.computeSecretKey(keyPair.publicKey)}');
```

## DH Groups

| Group ID | Modulus length | Strength range (in bits) |
|----------|----------------|--------------------------|
| 1        | 768-bit        | -                        |
| 2        | 1024-bit       | -                        |
| 5        | 1536-bit       | 90-120                   |
| 14       | 2048-bit       | 110-160                  |
| 15       | 3072-bit       | 130-210                  |
| 16       | 4096-bit       | 150-240                  |
| 17       | 6144-bit       | 170-270                  |
| 18       | 8192-bit       | 190-310                  |

## References
- https://www.teletrust.de/fileadmin/files/oid/oid_pkcs-3v1-4.pdf
- https://www.ietf.org/rfc/rfc3526.txt


1 (66, 65), (65, 64), (64, 68), (65, 64), (64, 64)
2 (114, 114), (111, 110), (109, 114), (111, 109), (114, 114)
5 (248, 243), (250, 252), (251, 253), (267, 263), (268, 272)
14 (474, 481), (488, 467), (481, 475), (490, 470), (465, 469)
15 (1015, 1033), (999, 946), (984, 1016), (1020, 1028), (1032, 984)
16 (1736, 1712), (1733, 1674), (1702, 1736), (1724, 1712), (1718, 1745)
17 (3952, 3966), (3927, 3891), (4039, 3878), (3857, 3907), (3831, 3933)
18 (6809, 6917), (6911, 6760), (6619, 6778), (6726, 6692), (7047, 7010)