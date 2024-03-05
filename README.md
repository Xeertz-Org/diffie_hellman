# Dart Diffie-Hellman

Dart implementation of finite field Diffie-Hellman. Based on PKCS#3.

## Usage

```
DhPkcs3Engine dhEngine = DhPkcs3Engine.fromGroup(DhGroup.g5);
DhPkcs3Engine otherDhEngine = DhPkcs3Engine.fromGroup(DhGroup.g5);

DhKeyPair keyPair = dhEngine.generateKeyPair();
DhKeyPair otherKeyPair = otherDhEngine.generateKeyPair();

print('Public Key: ${keyPair.publicKey.value}');
print('Private Key: ${keyPair.privateKey.value}');
print('Other public Key: ${otherKeyPair.publicKey.value}');
print('Other private Key: ${otherKeyPair.privateKey.value}');

print(
'Secret Key: ${dhEngine.computeSecretKey(otherKeyPair.publicKey.value)}',
);
print(
'Other secret Key: ${otherDhEngine.computeSecretKey(keyPair.publicKey.value)}',
);
```

### **Engine configuration**

The engine can be configured in three ways:

### Predefined group

This factory constructor allows you to specify a Diffie-Hellman group to use. Each group has a predefined parameter
definition

```
DhPkcs3Engine dhEngine = DhPkcs3Engine.fromGroup(DhGroup.g18);
```

### Custom parameter

It's also possible to define a custom parameter definition (e.g. using the same from a group but with different values)

```
DhPkcs3Engine dhEngine = DhPkcs3Engine.fromParameter(DhGroup.g18.parameter.copyWith(l: 1024));
```

### Existing key pair

The engine can be created from an existing key pair

```
DhPrivateKey privateKey = DhPrivateKey.fromPem('...');
DhPublicKey publicKey = DhPublicKey.fromPem('...');

DhKeyPair keyPair = DhKeyPair(privateKey: privateKey, publicKey: publicKey);

DhPkcs3Engine dhEngine = DhPkcs3Engine.fromKeyPair(keyPair);
```

### **PEM serialization/deserialization**

Each key can be constructed from a PEM string

```
DhPrivateKey privateKey = DhPrivateKey.fromPem('...');
DhPublicKey publicKey = DhPublicKey.fromPem('...');
```

On the other hand, the keys can be serialized to a PEM string

```
String privateKeyPem = privateKey.toPem();
String publicKeyPem = publicKey.toPem();
```

The same applies to the DH parameters

```
DhParameter parameter = DhParameter.fromPem('...');
String parameterPem = parameter.toPem();
```

## DH Groups

| Group ID | Modulus length (p)                      | Exponent size (l) (in bits) | Strength (in bits) |
|----------|-----------------------------------------|-----------------------------|--------------------|
| 1        | 768-bit                                 | 160                         | -                  |
| 2        | 1024-bit                                | 160                         | 80                 |
| 5        | 1536-bit                                | 240                         | 120                |
| 14       | 2048-bit                                | 320                         | 160                |
| 15       | 3072-bit                                | 384                         | 190                |
| 16       | 4096-bit                                | 480                         | 240                |
| 17       | 6144-bit                                | 512                         | 250                |
| 18       | 8192-bit                                | 640                         | 320                |
| 22       | 1024-bit (160-bit Prime Order Subgroup) | 160                         | 80                 |
| 23       | 2048-bit (224-bit Prime Order Subgroup) | 224                         | 112                |
| 24       | 2048-bit (256-bit Prime Order Subgroup) | 256                         | 112                |

## References

- https://www.teletrust.de/fileadmin/files/oid/oid_pkcs-3v1-4.pdf
- https://www.ietf.org/rfc/rfc3526.txt
- https://datatracker.ietf.org/doc/html/rfc2409
- https://datatracker.ietf.org/doc/html/rfc5114