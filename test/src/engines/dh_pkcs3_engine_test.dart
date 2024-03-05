import 'package:diffie_hellman/diffie_hellman.dart';
import 'package:test/test.dart';

void main() {
  group('Test constructors', () {
    test('fromKeyPair', () {
      DhParameter parameter = DhParameter(
        p: BigInt.parse(
          '1705981236470358725694168947912340905184016456649447827905035366'
          '423517535309908785587707055879384617579501090023314190176825'
          '906194053926198680818787330824514093789425038991297310899347'
          '879603007390591295367927989200428479181392167186038274353771'
          '051467944239198579360702639880632257276543722599876705523832'
          '383110847754263857714814930133028553636527166334698763092635'
          '309746869886837672874917937355659269162487244401397961380983'
          '492065819046040513532179748873242190063094003226840334898050'
          '065909470313763757295606726586211667148768695097521928028357'
          '150201410623989347868579314525119658923402674799093063288032'
          '9238408161847',
        ),
        g: BigInt.two,
      );
      DhKeyPair keyPair = DhKeyPair(
        publicKey: DhPublicKey.fromPem(
          '-----BEGIN PUBLIC KEY-----'
          'MIICJDCCARcGCSqGSIb3DQEDATCCAQgCggEBAIcjxlcFdybmHMukoDlQbpv7gnXQ58Lf'
          'KITR+nZQbuRXeJCXHDm1sB40IrvRNzU1fGwlCjHpmdcV6NUEiD2T39xVFxX8p8+I80EK'
          'xopImraK2+Q9AKJKFOwyF7akwhggdRLg9lQ3oVLEhJdRRjRvX88gT77kiYOWnjVdWSs7'
          '/94dJrWDLxRKSbdt3C2T7eaoaFjb6AgzL/LPLtl1Z4u9zprCgVBLDXaLl8P+4PCYhHLB'
          'aHDLO3xptDI3g/rD4dFmAve60hw6lcQe8DwUrepJATa3WGreRM3GmlzaHjia8y7lmPi/'
          'n8StPoThQwo+l5wL4OuJoj+AKSKuFNdSi0rVajcCAQIDggEFAAKCAQB+ZF2EgwIZWZkd'
          'RDzrIv3lRlBg/v1AYaYytjDzeL6G3NxvcB9uXBtsHJu9E9K0TRs2B0zYCX1v9yhAwM9r'
          'YGOqnjflqAVMhodtjLURCvamslEbnoCg3Gm8uYPu6KkTvDpjPGedKOjQNWAgJQREi1Wv'
          '+ZgTSR4TnzIFmPsxaWgifIV9Eo+mnHtMk9BynX5c4eh3FUwSAcilT4UbMHHDzNwYDda3'
          'gu3CQKDun+nF3nFYWg1iRZHr/6pjOgngIMPX4YSzpezbk3EXGe2qYKDBOxWoepIHnWt3'
          'e+8gWxPdyXB6oB3P/7+xrIXw4myJ0I2o8j78sq4hKXA0LQq1y2m8yrJ9'
          '-----END PUBLIC KEY-----',
        ),
        privateKey: DhPrivateKey.fromPem(
          '-----BEGIN PRIVATE KEY-----'
          'MIICJgIBADCCARcGCSqGSIb3DQEDATCCAQgCggEBAIcjxlcFdybmHMukoDlQbpv7gnXQ'
          '58LfKITR+nZQbuRXeJCXHDm1sB40IrvRNzU1fGwlCjHpmdcV6NUEiD2T39xVFxX8p8+I'
          '80EKxopImraK2+Q9AKJKFOwyF7akwhggdRLg9lQ3oVLEhJdRRjRvX88gT77kiYOWnjVd'
          'WSs7/94dJrWDLxRKSbdt3C2T7eaoaFjb6AgzL/LPLtl1Z4u9zprCgVBLDXaLl8P+4PCY'
          'hHLBaHDLO3xptDI3g/rD4dFmAve60hw6lcQe8DwUrepJATa3WGreRM3GmlzaHjia8y7l'
          'mPi/n8StPoThQwo+l5wL4OuJoj+AKSKuFNdSi0rVajcCAQIEggEEAoIBAEjucSf/Cfbj'
          'eH3DcsQFyPbCj3O1ZjErOPVfafN2sABD6S9/vvM3PDD5C+W+V5/hDPhSom7SoVWxa5Os'
          'ohJWkomtg1Lf44r+SYq1rSYflUXBtzovuP6+8po1BJuwQ2Xlgu73pzVUpbs7eadMSG/U'
          '4PytlhOzbni3Hs9jNFMQKYEk6oTx9MgAwuxRjAY1vJ+xFAlIdKpT0HWmqOeELT3Ud/kR'
          'FaNOvulYLzMBuc3yeAlX5rAgfKRm43kILvgiZrNwh31QEPfwyRH0KsiwNU1lA404BsZY'
          'j3BrXtiwEO9dgxMuhMKz4xzpjL6rJxTAukJ0G2CzLCT9t47H9RgA9tz/0ig='
          '-----END PRIVATE KEY-----',
        ),
      );
      DhPkcs3Engine engine = DhPkcs3Engine.fromKeyPair(keyPair);

      expect(engine.parameter, parameter);
      expect(engine.keyPair, keyPair);
      expect(engine.publicKey, keyPair.publicKey);
      expect(engine.privateKey, keyPair.privateKey);
      expect(engine.secretKey, isNull);
    });
    test('fromGroup', () {
      DhParameter parameterSpec = DhGroup.g14.parameter;
      DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g14);

      expect(engine.parameter, parameterSpec);
      expect(engine.keyPair, isNull);
      expect(engine.publicKey, isNull);
      expect(engine.privateKey, isNull);
      expect(engine.secretKey, isNull);
    });
  });

  test('Test computeSecretKey - no keyPair', () {
    DhParameter parameterSpec = DhGroup.g18.parameter;
    DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g18);

    expect(
      () => engine.computeSecretKey(BigInt.zero),
      throwsA(isA<StateError>()),
    );

    expect(engine.parameter, parameterSpec);
    expect(engine.keyPair, isNull);
    expect(engine.keyPair?.parameter, isNull);
    expect(engine.publicKey, isNull);
    expect(engine.privateKey, isNull);
    expect(engine.secretKey, isNull);
  });

  test('Test generateKeyPair', () {
    DhParameter parameter = DhGroup.g18.parameter;
    DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g18);

    DhKeyPair keyPair = engine.generateKeyPair();

    expect(engine.parameter, parameter);
    expect(engine.keyPair, keyPair);
    expect(engine.keyPair?.parameter, parameter);
    expect(engine.publicKey, isNotNull);
    expect(engine.privateKey, isNotNull);
    expect(engine.publicKey!.value.bitLength,
        inInclusiveRange(parameter.p.bitLength - 5, parameter.p.bitLength));
    expect(engine.privateKey!.value.bitLength, DhGroup.g18.parameter.l);
    expect(engine.secretKey, isNull);
  });

  group('Test computeSecretKey', () {
    test('wrong setup', () {
      DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g1);
      DhPkcs3Engine otherEngine = DhPkcs3Engine.fromGroup(DhGroup.g2);

      DhKeyPair keyPair = engine.generateKeyPair();
      DhKeyPair otherKeyPair = otherEngine.generateKeyPair();
      BigInt secretKey = engine.computeSecretKey(otherKeyPair.publicKey.value);
      BigInt otherSecretKey =
          otherEngine.computeSecretKey(keyPair.publicKey.value);
      expect(secretKey, isNot(equals(otherSecretKey)));
    });
    test('success', () {
      DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(DhGroup.g18);
      DhPkcs3Engine otherEngine = DhPkcs3Engine.fromGroup(DhGroup.g18);

      DhKeyPair keyPair = engine.generateKeyPair();
      DhKeyPair otherKeyPair = otherEngine.generateKeyPair();
      BigInt secretKey = engine.computeSecretKey(otherKeyPair.publicKey.value);
      BigInt otherSecretKey =
          otherEngine.computeSecretKey(keyPair.publicKey.value);
      expect(secretKey, otherSecretKey);
      expect(
          secretKey.bitLength,
          inInclusiveRange(keyPair.parameter.p.bitLength - 10,
              keyPair.parameter.p.bitLength));
    });
  });
}
