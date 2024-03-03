import 'package:diffie_hellman/src/utils/dh_random_generator.dart';
import 'package:test/test.dart';

void main() {
  group('Test generateDhPrivateValue', () {
    test('bit length - 4096', () {
      int bitLength = 4096;
      BigInt lowerBound = BigInt.two.pow(bitLength - 1);
      BigInt upperBound = BigInt.two * lowerBound;
      BigInt privateValue = DhRandomGenerator.generatePrivateValue(bitLength);
      expect(privateValue, greaterThanOrEqualTo(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('bit length - 2048', () {
      int bitLength = 2048;
      BigInt lowerBound = BigInt.two.pow(bitLength - 1);
      BigInt upperBound = BigInt.two * lowerBound;
      BigInt privateValue = DhRandomGenerator.generatePrivateValue(bitLength);
      expect(privateValue, greaterThanOrEqualTo(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('bit length - 1024', () {
      int bitLength = 1024;
      BigInt lowerBound = BigInt.two.pow(bitLength - 1);
      BigInt upperBound = BigInt.two * lowerBound;
      BigInt privateValue = DhRandomGenerator.generatePrivateValue(bitLength);
      expect(privateValue, greaterThanOrEqualTo(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('bit length - 512', () {
      int bitLength = 512;
      BigInt lowerBound = BigInt.two.pow(bitLength - 1);
      BigInt upperBound = BigInt.two * lowerBound;
      BigInt privateValue = DhRandomGenerator.generatePrivateValue(bitLength);
      expect(privateValue, greaterThanOrEqualTo(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
    test('bit length - 256', () {
      int bitLength = 256;
      BigInt lowerBound = BigInt.two.pow(bitLength - 1);
      BigInt upperBound = BigInt.two * lowerBound;
      BigInt privateValue = DhRandomGenerator.generatePrivateValue(bitLength);
      expect(privateValue, greaterThanOrEqualTo(lowerBound));
      expect(privateValue, lessThan(upperBound));
    });
  });
}
