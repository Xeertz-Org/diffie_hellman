import 'package:diffie_hellman/diffie_hellman.dart';
import 'package:diffie_hellman/src/groups/dh_groups.dart';
import 'package:test/test.dart';

void main() {
  group('Test getParameter', () {
    test('DhGroup.g1', () {
      expect(
        DhGroup.g1.parameter,
        DhParameter(
          p: BigInt.parse(
            g1P,
            radix: 16,
          ),
          g: BigInt.two,
          l: 160,
        ),
      );
    });
    test('DhGroup.g2', () {
      expect(
        DhGroup.g2.parameter,
        DhParameter(
          p: BigInt.parse(
            g2P,
            radix: 16,
          ),
          g: BigInt.two,
          l: 160,
        ),
      );
    });
    test('DhGroup.g5', () {
      expect(
        DhGroup.g5.parameter,
        DhParameter(
          p: BigInt.parse(
            g5P,
            radix: 16,
          ),
          g: BigInt.two,
          l: 240,
        ),
      );
    });
    test('DhGroup.g14', () {
      expect(
        DhGroup.g14.parameter,
        DhParameter(
          p: BigInt.parse(
            g14P,
            radix: 16,
          ),
          g: BigInt.two,
          l: 320,
        ),
      );
    });
    test('DhGroup.g15', () {
      expect(
        DhGroup.g15.parameter,
        DhParameter(
          p: BigInt.parse(
            g15P,
            radix: 16,
          ),
          g: BigInt.two,
          l: 384,
        ),
      );
    });
    test('DhGroup.g16', () {
      expect(
        DhGroup.g16.parameter,
        DhParameter(
          p: BigInt.parse(
            g16P,
            radix: 16,
          ),
          g: BigInt.two,
          l: 480,
        ),
      );
    });
    test('DhGroup.g17', () {
      expect(
        DhGroup.g17.parameter,
        DhParameter(
          p: BigInt.parse(
            g17P,
            radix: 16,
          ),
          g: BigInt.two,
          l: 512,
        ),
      );
    });
    test('DhGroup.g18', () {
      expect(
        DhGroup.g18.parameter,
        DhParameter(
          p: BigInt.parse(
            g18P,
            radix: 16,
          ),
          g: BigInt.two,
          l: 640,
        ),
      );
    });
    test('DhGroup.g22', () {
      expect(
        DhGroup.g22.parameter,
        DhParameter(
          p: BigInt.parse(
            g22P,
            radix: 16,
          ),
          g: BigInt.parse(
            g22G,
            radix: 16,
          ),
          l: BigInt.parse(
            g22Q,
            radix: 16,
          ).bitLength,
        ),
      );
    });
    test('DhGroup.g23', () {
      expect(
        DhGroup.g23.parameter,
        DhParameter(
          p: BigInt.parse(
            g23P,
            radix: 16,
          ),
          g: BigInt.parse(
            g23G,
            radix: 16,
          ),
          l: BigInt.parse(
            g23Q,
            radix: 16,
          ).bitLength,
        ),
      );
    });
    test('DhGroup.g24', () {
      expect(
        DhGroup.g24.parameter,
        DhParameter(
          p: BigInt.parse(
            g24P,
            radix: 16,
          ),
          g: BigInt.parse(
            g24G,
            radix: 16,
          ),
          l: BigInt.parse(
            g24Q,
            radix: 16,
          ).bitLength,
        ),
      );
    });
  });
}
