## 1.2.0
**Breaking changes**
* Bumped minimum Dart SDK version to 3.4.0
* Updated dependencies

## 1.1.3
**Breaking changes**
* Predefined values for DhGroup parameter
* Added fromParameter() factory to DhPkcs3Engine
* Added copyWith() to DhParameter
* Added 1024-bit MODP group with 224-bit Prime Order Subgroup (DhGroup.g22)
* Added 2048-bit MODP group with 224-bit Prime Order Subgroup (DhGroup.g23)
* Added 2048-bit MODP group with 256-bit Prime Order Subgroup (DhGroup.g24)

## 1.1.0
**Breaking changes**
* Added wrapper class for keys. 
* Added PEM serialization/deserialization for keys and parameter
* Allowed null length in DhParameter

## 1.0.0
**Breaking changes**
* Bumped minimum Dart SDK version to 2.17.0
* Added DhGroup enum instead of int groupId
* Added DhPkcs3Engine.fromKeyPair() factory
* Allowed key pair regeneration in DhPkcs3Engine

## 0.1.2
* Changed private utility method `toBigInt()`

## 0.1.1
* Updated pubspec.yaml

## 0.1.0
* Removed PointyCastle dependency. Now the secure random generator uses Random.secure() from dart.math

## 0.0.3
* Added docs

## 0.0.1
* Initial commit



