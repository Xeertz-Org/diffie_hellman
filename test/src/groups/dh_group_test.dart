import 'package:diffie_hellman/diffie_hellman.dart';
import 'package:diffie_hellman/src/groups/dh_groups.dart';
import 'package:test/test.dart';

void main() {
  group('Test getParameterSpec', () {
    test('DhGroup.g1 (with length)', () {
      expect(
        DhGroup.g1.getParameter(privateValueLength: 1024),
        DhParameter(
          p: BigInt.parse(
            g1Prime,
            radix: 16,
          ),
          g: 2,
          length: 1024,
        ),
      );
    });
    test('DhGroup.g1', () {
      expect(
        DhGroup.g1.getParameter(),
        DhParameter(
          p: BigInt.parse(
            g1Prime,
            radix: 16,
          ),
          g: 2,
          length: 2048,
        ),
      );
    });
    test('DhGroup.g2', () {
      expect(
        DhGroup.g2.getParameter(),
        DhParameter(
          p: BigInt.parse(
            g2Prime,
            radix: 16,
          ),
          g: 2,
          length: 2048,
        ),
      );
    });
    test('DhGroup.g5', () {
      expect(
        DhGroup.g5.getParameter(),
        DhParameter(
          p: BigInt.parse(
            g5Prime,
            radix: 16,
          ),
          g: 2,
          length: 2048,
        ),
      );
    });
    test('DhGroup.g14', () {
      expect(
        DhGroup.g14.getParameter(),
        DhParameter(
          p: BigInt.parse(
            g14Prime,
            radix: 16,
          ),
          g: 2,
          length: 2048,
        ),
      );
    });
    test('DhGroup.g15', () {
      expect(
        DhGroup.g15.getParameter(),
        DhParameter(
          p: BigInt.parse(
            g15Prime,
            radix: 16,
          ),
          g: 2,
          length: 2048,
        ),
      );
    });
    test('DhGroup.g16', () {
      expect(
        DhGroup.g16.getParameter(),
        DhParameter(
          p: BigInt.parse(
            g16Prime,
            radix: 16,
          ),
          g: 2,
          length: 2048,
        ),
      );
    });
    test('DhGroup.g17', () {
      expect(
        DhGroup.g17.getParameter(),
        DhParameter(
          p: BigInt.parse(
            g17Prime,
            radix: 16,
          ),
          g: 2,
          length: 2048,
        ),
      );
    });
    test('DhGroup.g18', () {
      expect(
        DhGroup.g18.getParameter(),
        DhParameter(
          p: BigInt.parse(
            g18Prime,
            radix: 16,
          ),
          g: 2,
          length: 2048,
        ),
      );
    });
  });
}
