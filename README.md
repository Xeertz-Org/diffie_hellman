# Dart Diffie-Hellman

A pure Dart implementation of finite field Diffie-Hellman. Based on PKCS#3.

## Getting Started 

To get started with this package, please check the [official documentation](https://xeertz.com/diffie-hellman)

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

## Issues and feedback
Please report any issue, bug or feature request in our [issue tracker](https://github.com/Xeertz-Org/diffie_hellman/issues)

## References

- https://www.teletrust.de/fileadmin/files/oid/oid_pkcs-3v1-4.pdf
- https://www.ietf.org/rfc/rfc3526.txt
- https://datatracker.ietf.org/doc/html/rfc2409
- https://datatracker.ietf.org/doc/html/rfc5114