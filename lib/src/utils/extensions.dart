import 'dart:math';
import 'dart:typed_data';

extension RandomExtension on Random {
  BigInt nextBigInt(int bitLength) {
    BytesBuilder builder = BytesBuilder();
    if (bitLength % 8 != 0) {
      throw ArgumentError('Invalid bitLength value - $bitLength');
    }
    int parts = bitLength ~/ 8;
    for (int i = 0; i < parts; i++) {
      builder.addByte(nextInt(256));
    }
    Uint8List bytes = builder.toBytes();
    return bytes.toBigInt();
  }
}

extension Uint8ListExtension on Uint8List {
  BigInt toBigInt() {
    BigInt result = BigInt.zero;

    for (int byte in this) {
      result = (result << 8) | BigInt.from(byte);
    }
    return result;
  }
}

extension BigIntExtension on BigInt {
  Uint8List toBigEndianBytes() {
    int bytesLength = (this.bitLength + 7) >> 3;
    ByteData byteData = ByteData(bytesLength);

    for (int i = 0; i < bytesLength; i++) {
      int byte =
          ((this >> (8 * (bytesLength - i - 1))) & BigInt.from(0xff)).toInt();

      byteData.setUint8(i, byte);
    }

    return byteData.buffer.asUint8List();
  }
}
