import 'package:diffie_hellman/diffie_hellman.dart';
import 'package:diffie_hellman/src/spec/codec/dh_parameter_codec.dart';
import 'package:test/test.dart';

void main() {
  DhParameterCodec codec = DhParameterCodec();
  group('Test decode', () {
    test('length is null', () {
      String pem = '-----BEGIN DH PARAMETERS-----'
          'MIGHAoGBAOZVzJ4E8766527Mp3FD71xEUYdmFan4tPcSuPO99H7n9xfAm7WytmRQgxNn2'
          'dz4X58FKLzVMY+x2rLyPOd8SLa3OB7tE+gKFMymswteN//lPbFeLWtyei787lGJNnjVDp'
          'qJFmo1nldMTDyl5Z+ueZJP5vGGs2ouvem/Cf5N5QRTAgEC'
          '-----END DH PARAMETERS-----';

      DhParameter parameter = codec.decode(pem);

      expect(
        parameter,
        isA<DhParameter>(),
      );
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
      String pem = '-----BEGIN DH PARAMETERS-----'
          'MIGHAoGBAOZVzJ4E8766527Mp3FD71xEUYdmFan4tPcSuPO99H7n9xfAm7WytmRQgxNn2'
          'dz4X58FKLzVMY+x2rLyPOd8SLa3OBsdfds7tE+gKFMymswteN//lPbFeLWtyei787lGJNnjVDp'
          'qJFmo1nldMTDyl5Z+ueZJP5vGGs2ousdsdvem/Cf5N5QRTAgEC'
          '-----END DH PARAMETERS-----';

      expect(
        () => codec.decode(pem),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('Test encode', () {
    test('length is 256', () {
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

      String pem = codec.encode(parameter);

      expect(
        pem,
        '-----BEGIN DH PARAMETERS-----'
        'MIGLAoGBAOZVzJ4E8766527Mp3FD71xEUYdmFan4tP'
        'cSuPO99H7n9xfAm7WytmRQgxNn2dz4X58FKLzVMY+x2rLyPOd8SLa3OB7tE+gKF'
        'MymswteN//lPbFeLWtyei787lGJNnjVDpqJFmo1nldMTDyl5Z+ueZ'
        'JP5vGGs2ouvem/Cf5N5QRTAgECAgIBAA=='
        '-----END DH PARAMETERS-----',
      );
    });
    test('length is null', () {
      DhParameter parameter = DhParameter(
        p: BigInt.parse(
            '16174684534979544089578127346063645214033836665911683110191438786'
            '88720767863273820410252501474817099496279161493180543004305959272'
            '8012986657471890730448667462206282342720723923088245217734370'
            '5925333516187409136597518853061525638160486071114568606481665'
            '999964483633719132036838469655517154312058275367764690003'),
        g: BigInt.two,
      );

      String pem = codec.encode(parameter);

      expect(
        pem,
        '-----BEGIN DH PARAMETERS-----'
        'MIGHAoGBAOZVzJ4E8766527Mp3FD71xEUYdmFan4tPcSuPO99H7n9xfAm7WytmRQgxNn2'
        'dz4X58FKLzVMY+x2rLyPOd8SLa3OB7tE+gKFMymswteN//lPbFeLWtyei787lGJNnjVDp'
        'qJFmo1nldMTDyl5Z+ueZJP5vGGs2ouvem/Cf5N5QRTAgEC'
        '-----END DH PARAMETERS-----',
      );
    });
  });
}
