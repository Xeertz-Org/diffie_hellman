## 1.1.0
**Breaking changes**
* Added wrapper class for keys. 
* Added PEM serialization/deserialization for keys and parameter
* Allowed null length in DhParameter

## 1.0.0
**Breaking changes**
* Bumped minimal Dart SDK version to 2.17.0
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



