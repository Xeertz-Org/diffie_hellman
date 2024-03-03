import 'package:diffie_hellman/diffie_hellman.dart';
import 'package:diffie_hellman/src/spec/dh_parameter_constants.dart';
import 'package:test/test.dart';

void main() {
  group('Test fromId', () {
    test('DhGroup.g1', () {
      expect(DhGroup.fromId(1), DhGroup.g1);
    });
    test('DhGroup.g2', () {
      expect(DhGroup.fromId(2), DhGroup.g2);
    });
    test('DhGroup.g5', () {
      expect(DhGroup.fromId(5), DhGroup.g5);
    });
    test('DhGroup.g14', () {
      expect(DhGroup.fromId(14), DhGroup.g14);
    });
    test('DhGroup.g15', () {
      expect(DhGroup.fromId(15), DhGroup.g15);
    });
    test('DhGroup.g16', () {
      expect(DhGroup.fromId(16), DhGroup.g16);
    });
    test('DhGroup.g17', () {
      expect(DhGroup.fromId(17), DhGroup.g17);
    });
    test('DhGroup.g18', () {
      expect(DhGroup.fromId(18), DhGroup.g18);
    });
  });

  group('Test id', () {
    test('DhGroup.g1', () {
      expect(DhGroup.g1.id, 1);
    });
    test('DhGroup.g2', () {
      expect(DhGroup.g2.id, 2);
    });
    test('DhGroup.g5', () {
      expect(DhGroup.g5.id, 5);
    });
    test('DhGroup.g14', () {
      expect(DhGroup.g14.id, 14);
    });
    test('DhGroup.g15', () {
      expect(DhGroup.g15.id, 15);
    });
    test('DhGroup.g16', () {
      expect(DhGroup.g16.id, 16);
    });
    test('DhGroup.g17', () {
      expect(DhGroup.g17.id, 17);
    });
    test('DhGroup.g18', () {
      expect(DhGroup.g18.id, 18);
    });
  });

  group('Test getParameterSpec', () {
    test('DhGroup.g1', () {
      expect(
        DhGroup.g1.getParameterSpec(512),
        DhParameterSpec(
          groupId: 1,
          p: BigInt.parse(
            g1Prime,
            radix: 16,
          ),
          g: 2,
          length: 512,
        ),
      );
    });
    test('DhGroup.g2', () {
      expect(
        DhGroup.g2.getParameterSpec(512),
        DhParameterSpec(
          groupId: 2,
          p: BigInt.parse(
            g2Prime,
            radix: 16,
          ),
          g: 2,
          length: 512,
        ),
      );
    });
    test('DhGroup.g5', () {
      expect(
        DhGroup.g5.getParameterSpec(512),
        DhParameterSpec(
          groupId: 5,
          p: BigInt.parse(
            g5Prime,
            radix: 16,
          ),
          g: 2,
          length: 512,
        ),
      );
    });
    test('DhGroup.g14', () {
      expect(
        DhGroup.g14.getParameterSpec(512),
        DhParameterSpec(
          groupId: 14,
          p: BigInt.parse(
            g14Prime,
            radix: 16,
          ),
          g: 2,
          length: 512,
        ),
      );
    });
    test('DhGroup.g15', () {
      expect(
        DhGroup.g15.getParameterSpec(512),
        DhParameterSpec(
          groupId: 15,
          p: BigInt.parse(
            g15Prime,
            radix: 16,
          ),
          g: 2,
          length: 512,
        ),
      );
    });
    test('DhGroup.g16', () {
      expect(
        DhGroup.g16.getParameterSpec(512),
        DhParameterSpec(
          groupId: 16,
          p: BigInt.parse(
            g16Prime,
            radix: 16,
          ),
          g: 2,
          length: 512,
        ),
      );
    });
    test('DhGroup.g17', () {
      expect(
        DhGroup.g17.getParameterSpec(512),
        DhParameterSpec(
          groupId: 17,
          p: BigInt.parse(
            g17Prime,
            radix: 16,
          ),
          g: 2,
          length: 512,
        ),
      );
    });
    test('DhGroup.g18', () {
      expect(
        DhGroup.g18.getParameterSpec(512),
        DhParameterSpec(
          groupId: 18,
          p: BigInt.parse(
            g18Prime,
            radix: 16,
          ),
          g: 2,
          length: 512,
        ),
      );
    });
  });
}
