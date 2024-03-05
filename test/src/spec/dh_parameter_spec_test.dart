import 'package:diffie_hellman/src/spec/dh_parameter.dart';
import 'package:test/test.dart';

void main() {
  test('Test getters - null length', () {
    DhParameter dhParameterSpec = DhParameter(
      p: BigInt.two,
      g: BigInt.two,
    );
    expect(
      dhParameterSpec.p,
      BigInt.two,
    );
    expect(dhParameterSpec.g, BigInt.two);
    expect(dhParameterSpec.l, null);
  });
  test('Test getters - length', () {
    DhParameter dhParameterSpec = DhParameter(
      p: BigInt.two,
      g: BigInt.two,
      l: 256,
    );
    expect(
      dhParameterSpec.p,
      BigInt.two,
    );
    expect(dhParameterSpec.g, BigInt.two);
    expect(dhParameterSpec.l, 256);
  });

  group('Test fromPem', () {
    test('success', () {
      DhParameter parameter = DhParameter.fromPem(
          '-----BEGIN DH PARAMETERS-----'
          'MIGHAoGBAOZVzJ4E8766527Mp3FD71xEUYdmFan4tPcSuPO99H7n9xfAm7WytmRQgxNn2'
          'dz4X58FKLzVMY+x2rLyPOd8SLa3OB7tE+gKFMymswteN//lPbFeLWtyei787lGJNnjVDp'
          'qJFmo1nldMTDyl5Z+ueZJP5vGGs2ouvem/Cf5N5QRTAgEC'
          '-----END DH PARAMETERS-----');

      expect(
        parameter.p,
        BigInt.parse(
            '16174684534979544089578127346063645214033836665911683110191438786'
            '88720767863273820410252501474817099496279161493180543004305959272'
            '8012986657471890730448667462206282342720723923088245217734370'
            '5925333516187409136597518853061525638160486071114568606481665'
            '999964483633719132036838469655517154312058275367764690003'),
      );
      expect(parameter.p.bitLength, 1024);
      expect(parameter.g, BigInt.two);
      expect(parameter.l, isNull);
    });

    test('error', () {
      expect(
          () => DhParameter.fromPem('-----BEGIN DH PARAMETERS-----'
              'MIGHAoGBAOZVzJ4E8766527Mp3FD71xEUYdmFan4tPcSuPO99H7n9xfAm7WytmRQgxNn2'
              'dz4X58FKLzVMY+x2rLyPOd8SLa3OB7tE+gKFMymswteN//lPbFeLWtyei787lGJNnjVDp'
              'qJFmo1nldMTDyl5Z+ueZJP5vGGs2ouvem/Cf5N5QRTdsfsdfAgEC'
              '-----END DH PARAMETERS-----'),
          throwsA(isA<FormatException>()));
    });
  });

  test('Test toPem', () {
    DhParameter parameter = DhParameter(
      p: BigInt.parse(
          '16174684534979544089578127346063645214033836665911683110191438786'
          '88720767863273820410252501474817099496279161493180543004305959272'
          '8012986657471890730448667462206282342720723923088245217734370'
          '5925333516187409136597518853061525638160486071114568606481665'
          '999964483633719132036838469655517154312058275367764690003'),
      g: BigInt.two,
      l: 256,
    );

    expect(
      parameter.toPem(),
      '-----BEGIN DH PARAMETERS-----'
      'MIGLAoGBAOZVzJ4E8766527Mp3FD71xEUYdmFan4tP'
      'cSuPO99H7n9xfAm7WytmRQgxNn2dz4X58FKLzVMY+x2rLyPOd8SLa3OB7tE+gKF'
      'MymswteN//lPbFeLWtyei787lGJNnjVDpqJFmo1nldMTDyl5Z+ueZ'
      'JP5vGGs2ouvem/Cf5N5QRTAgECAgIBAA=='
      '-----END DH PARAMETERS-----',
    );
  });
}
