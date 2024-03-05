import 'package:diffie_hellman/src/groups/dh_groups.dart';
import 'package:diffie_hellman/src/utils/dh_random_generator.dart';
import 'package:test/test.dart';

void main() {
  group('Test generatePrivateValueFromP', () {
    test('Test generatePrivateValueFromP - g1', () {
      BigInt p = BigInt.parse(
        g1P,
        radix: 16,
      );
      BigInt privateValue = DhRandomGenerator.generatePrivateValueFromP(p);
      BigInt lowerBound = BigInt.zero;
      BigInt upperBound = p - BigInt.one;

      expect(privateValue, greaterThan(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('Test generatePrivateValueFromP - g2', () {
      BigInt p = BigInt.parse(
        g2P,
        radix: 16,
      );
      BigInt privateValue = DhRandomGenerator.generatePrivateValueFromP(p);
      BigInt lowerBound = BigInt.zero;
      BigInt upperBound = p - BigInt.one;

      expect(privateValue, greaterThan(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('Test generatePrivateValueFromP - g5', () {
      BigInt p = BigInt.parse(
        g5P,
        radix: 16,
      );
      BigInt privateValue = DhRandomGenerator.generatePrivateValueFromP(p);
      BigInt lowerBound = BigInt.zero;
      BigInt upperBound = p - BigInt.one;

      expect(privateValue, greaterThan(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('Test generatePrivateValueFromP - g14', () {
      BigInt p = BigInt.parse(
        g14P,
        radix: 16,
      );
      BigInt privateValue = DhRandomGenerator.generatePrivateValueFromP(p);
      BigInt lowerBound = BigInt.zero;
      BigInt upperBound = p - BigInt.one;

      expect(privateValue, greaterThan(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('Test generatePrivateValueFromP - g15', () {
      BigInt p = BigInt.parse(
        g15P,
        radix: 16,
      );
      BigInt privateValue = DhRandomGenerator.generatePrivateValueFromP(p);
      BigInt lowerBound = BigInt.zero;
      BigInt upperBound = p - BigInt.one;

      expect(privateValue, greaterThan(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('Test generatePrivateValueFromP - g16', () {
      BigInt p = BigInt.parse(
        g16P,
        radix: 16,
      );
      BigInt privateValue = DhRandomGenerator.generatePrivateValueFromP(p);
      BigInt lowerBound = BigInt.zero;
      BigInt upperBound = p - BigInt.one;

      expect(privateValue, greaterThan(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('Test generatePrivateValueFromP - g17', () {
      BigInt p = BigInt.parse(
        g17P,
        radix: 16,
      );
      BigInt privateValue = DhRandomGenerator.generatePrivateValueFromP(p);
      BigInt lowerBound = BigInt.zero;
      BigInt upperBound = p - BigInt.one;

      expect(privateValue, greaterThan(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('Test generatePrivateValueFromP - g18', () {
      BigInt p = BigInt.parse(
        g18P,
        radix: 16,
      );
      BigInt privateValue = DhRandomGenerator.generatePrivateValueFromP(p);
      BigInt lowerBound = BigInt.zero;
      BigInt upperBound = p - BigInt.one;

      expect(privateValue, greaterThan(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
  });
  group('Test generatePrivateValueWithLength', () {
    test('bit length - 4096', () {
      int bitLength = 4096;
      BigInt lowerBound = BigInt.two.pow(bitLength - 1);
      BigInt upperBound = BigInt.two * lowerBound;
      BigInt privateValue =
          DhRandomGenerator.generatePrivateValueWithLength(bitLength);
      expect(privateValue, greaterThanOrEqualTo(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('bit length - 2048', () {
      int bitLength = 2048;
      BigInt lowerBound = BigInt.two.pow(bitLength - 1);
      BigInt upperBound = BigInt.two * lowerBound;
      BigInt privateValue =
          DhRandomGenerator.generatePrivateValueWithLength(bitLength);
      expect(privateValue, greaterThanOrEqualTo(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('bit length - 1024', () {
      int bitLength = 1024;
      BigInt lowerBound = BigInt.two.pow(bitLength - 1);
      BigInt upperBound = BigInt.two * lowerBound;
      BigInt privateValue =
          DhRandomGenerator.generatePrivateValueWithLength(bitLength);
      expect(privateValue, greaterThanOrEqualTo(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('bit length - 512', () {
      int bitLength = 512;
      BigInt lowerBound = BigInt.two.pow(bitLength - 1);
      BigInt upperBound = BigInt.two * lowerBound;
      BigInt privateValue =
          DhRandomGenerator.generatePrivateValueWithLength(bitLength);
      expect(privateValue, greaterThanOrEqualTo(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('bit length - 256', () {
      int bitLength = 256;
      BigInt lowerBound = BigInt.two.pow(bitLength - 1);
      BigInt upperBound = BigInt.two * lowerBound;
      BigInt privateValue =
          DhRandomGenerator.generatePrivateValueWithLength(bitLength);
      expect(privateValue, greaterThanOrEqualTo(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
  });
}
