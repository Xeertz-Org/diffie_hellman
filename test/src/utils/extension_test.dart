import 'dart:math';
import 'dart:typed_data';

import 'package:diffie_hellman/src/utils/extensions.dart';
import 'package:test/test.dart';

void main() {
  Random random = Random();
  group('Test RandomExtension', () {
    test('nextBigInt(5000)', () {
      int bitLength = 4097;
      expect(
        () => random.nextBigInt(bitLength),
        throwsA(isA<ArgumentError>()),
      );
    });
    test('nextBigInt(4096)', () {
      int bitLength = 4096;
      final bigInt = random.nextBigInt(bitLength);
      expect(bigInt.bitLength, inInclusiveRange(bitLength - 8, bitLength));
    });
    test('nextBigInt(2048)', () {
      int bitLength = 2048;
      final bigInt = random.nextBigInt(bitLength);
      expect(bigInt.bitLength, inInclusiveRange(bitLength - 8, bitLength));
    });
    test('nextBigInt(1024)', () {
      int bitLength = 1024;
      final bigInt = random.nextBigInt(bitLength);
      expect(bigInt.bitLength, inInclusiveRange(bitLength - 8, bitLength));
    });
    test('nextBigInt(512)', () {
      int bitLength = 512;
      final bigInt = random.nextBigInt(bitLength);
      expect(bigInt.bitLength, inInclusiveRange(bitLength - 8, bitLength));
    });
    test('nextBigInt(256)', () {
      int bitLength = 256;
      final bigInt = random.nextBigInt(bitLength);
      expect(bigInt.bitLength, inInclusiveRange(bitLength - 8, bitLength));
    });
  });

  group('Test Uint8ListExtension', () {
    test('toBigInt', () {
      final bytes =
          Uint8List.fromList([0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07]);
      final bigInt = bytes.toBigInt();
      expect(bigInt, BigInt.from(0x01020304050607));
    });
  });
}
