import 'package:diffie_hellman/diffie_hellman.dart';
import 'package:test/test.dart';

void main() {
  group('Test constructors', () {
    test('fromKeyPair', () {
      DhParameterSpec parameterSpec = DhGroup.g14.getParameterSpec(256);
      DhKeyPair keyPair = DhKeyPair(
        parameterSpec: parameterSpec,
        publicKey: BigInt.zero,
        privateKey: BigInt.zero,
      );
      DhPkcs3Engine engine = DhPkcs3Engine.fromKeyPair(keyPair);

      expect(engine.parameterSpec, parameterSpec);
      expect(engine.keyPair, keyPair);
      expect(engine.publicKey, keyPair.publicKey);
      expect(engine.privateKey, keyPair.privateKey);
      expect(engine.secretKey, isNull);
    });
    test('fromGroup', () {
      DhParameterSpec parameterSpec = DhGroup.g14.getParameterSpec(256);
      DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g14);

      expect(engine.parameterSpec, parameterSpec);
      expect(engine.keyPair, isNull);
      expect(engine.publicKey, isNull);
      expect(engine.privateKey, isNull);
      expect(engine.secretKey, isNull);
    });
  });

  test('Test computeSecretKey - no keyPair', () {
    DhParameterSpec parameterSpec = DhGroup.g14.getParameterSpec(256);
    DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g14);

    expect(
      () => engine.computeSecretKey(BigInt.zero),
      throwsA(isA<StateError>()),
    );

    expect(engine.parameterSpec, parameterSpec);
    expect(engine.keyPair, isNull);
    expect(engine.keyPair?.parameterSpec, isNull);
    expect(engine.publicKey, isNull);
    expect(engine.privateKey, isNull);
    expect(engine.secretKey, isNull);
  });

  test('Test generateKeyPair', () {
    DhParameterSpec parameterSpec = DhGroup.g14.getParameterSpec(256);
    DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g14);

    DhKeyPair keyPair = engine.generateKeyPair();

    expect(engine.parameterSpec, parameterSpec);
    expect(engine.keyPair, keyPair);
    expect(engine.keyPair?.parameterSpec, parameterSpec);
    expect(engine.publicKey, isNotNull);
    expect(engine.privateKey, isNotNull);
    expect(engine.secretKey, isNull);
  });

  group('Test computeSecretKey', () {
    test('wrong setup', () {
      DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g1);
      DhPkcs3Engine otherEngine = DhPkcs3Engine.fromGroup(DhGroup.g2);

      DhKeyPair keyPair = engine.generateKeyPair();
      DhKeyPair otherKeyPair = otherEngine.generateKeyPair();
      BigInt secretKey = engine.computeSecretKey(otherKeyPair.publicKey);
      BigInt otherSecretKey = otherEngine.computeSecretKey(keyPair.publicKey);
      expect(secretKey, isNot(equals(otherSecretKey)));
    });
    test('DhGroup.g1', () {
      DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g1);
      DhPkcs3Engine otherEngine = DhPkcs3Engine.fromGroup(DhGroup.g1);

      for (int i = 0; i < 20; i++) {
        DhKeyPair keyPair = engine.generateKeyPair();
        DhKeyPair otherKeyPair = otherEngine.generateKeyPair();
        BigInt secretKey = engine.computeSecretKey(otherKeyPair.publicKey);
        BigInt otherSecretKey = otherEngine.computeSecretKey(keyPair.publicKey);
        expect(secretKey, otherSecretKey);
      }
    });
    test('DhGroup.g2', () {
      DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g2);
      DhPkcs3Engine otherEngine = DhPkcs3Engine.fromGroup(DhGroup.g2);

      for (int i = 0; i < 20; i++) {
        DhKeyPair keyPair = engine.generateKeyPair();
        DhKeyPair otherKeyPair = otherEngine.generateKeyPair();
        BigInt secretKey = engine.computeSecretKey(otherKeyPair.publicKey);
        BigInt otherSecretKey = otherEngine.computeSecretKey(keyPair.publicKey);
        expect(secretKey, otherSecretKey);
      }
    });
    test('DhGroup.g5', () {
      DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g5);
      DhPkcs3Engine otherEngine = DhPkcs3Engine.fromGroup(DhGroup.g5);

      for (int i = 0; i < 20; i++) {
        DhKeyPair keyPair = engine.generateKeyPair();
        DhKeyPair otherKeyPair = otherEngine.generateKeyPair();
        BigInt secretKey = engine.computeSecretKey(otherKeyPair.publicKey);
        BigInt otherSecretKey = otherEngine.computeSecretKey(keyPair.publicKey);
        expect(secretKey, otherSecretKey);
      }
    });
    test('DhGroup.g14', () {
      DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g14);
      DhPkcs3Engine otherEngine = DhPkcs3Engine.fromGroup(DhGroup.g14);

      for (int i = 0; i < 20; i++) {
        DhKeyPair keyPair = engine.generateKeyPair();
        DhKeyPair otherKeyPair = otherEngine.generateKeyPair();
        BigInt secretKey = engine.computeSecretKey(otherKeyPair.publicKey);
        BigInt otherSecretKey = otherEngine.computeSecretKey(keyPair.publicKey);
        expect(secretKey, otherSecretKey);
      }
    });
    test('DhGroup.g15', () {
      DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g15);
      DhPkcs3Engine otherEngine = DhPkcs3Engine.fromGroup(DhGroup.g15);

      for (int i = 0; i < 20; i++) {
        DhKeyPair keyPair = engine.generateKeyPair();
        DhKeyPair otherKeyPair = otherEngine.generateKeyPair();
        BigInt secretKey = engine.computeSecretKey(otherKeyPair.publicKey);
        BigInt otherSecretKey = otherEngine.computeSecretKey(keyPair.publicKey);
        expect(secretKey, otherSecretKey);
      }
    });
    test('DhGroup.g16', () {
      DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g16);
      DhPkcs3Engine otherEngine = DhPkcs3Engine.fromGroup(DhGroup.g16);

      for (int i = 0; i < 20; i++) {
        DhKeyPair keyPair = engine.generateKeyPair();
        DhKeyPair otherKeyPair = otherEngine.generateKeyPair();
        BigInt secretKey = engine.computeSecretKey(otherKeyPair.publicKey);
        BigInt otherSecretKey = otherEngine.computeSecretKey(keyPair.publicKey);
        expect(secretKey, otherSecretKey);
      }
    });
    test('DhGroup.g17', () {
      DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g17);
      DhPkcs3Engine otherEngine = DhPkcs3Engine.fromGroup(DhGroup.g17);

      for (int i = 0; i < 20; i++) {
        DhKeyPair keyPair = engine.generateKeyPair();
        DhKeyPair otherKeyPair = otherEngine.generateKeyPair();
        BigInt secretKey = engine.computeSecretKey(otherKeyPair.publicKey);
        BigInt otherSecretKey = otherEngine.computeSecretKey(keyPair.publicKey);
        expect(secretKey, otherSecretKey);
      }
    });
    test('DhGroup.g18', () {
      DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g18);
      DhPkcs3Engine otherEngine = DhPkcs3Engine.fromGroup(DhGroup.g18);

      for (int i = 0; i < 20; i++) {
        DhKeyPair keyPair = engine.generateKeyPair();
        DhKeyPair otherKeyPair = otherEngine.generateKeyPair();
        BigInt secretKey = engine.computeSecretKey(otherKeyPair.publicKey);
        BigInt otherSecretKey = otherEngine.computeSecretKey(keyPair.publicKey);
        expect(secretKey, otherSecretKey);
      }
    });
  });
}
