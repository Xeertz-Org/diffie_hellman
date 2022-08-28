import 'dart:math';
import 'dart:typed_data';

class SecureRandomGenerator {
  static BigInt generateDhPrivateValue(int bitLength) {
    Random rnd;

    try {
      rnd = Random.secure();
    } on UnsupportedError {
      throw UnsupportedPlatformException(
          'This platform cannot provide a cryptographically secure source of random numbers');
    }

    BigInt lowerBound = BigInt.two.pow(bitLength - 1);
    late BigInt generated;

    bool loopCondition = true;
    while (loopCondition) {
      generated = rnd.nextBigInt(bitLength);
      if (generated.compareTo(lowerBound) >= 0 &&
          generated.compareTo(BigInt.two * lowerBound) < 0) {
        loopCondition = false;
      }
    }

    return generated;
  }
}

extension RandomExtension on Random {
  BigInt nextBigInt(int bitLength) {
    BytesBuilder builder = BytesBuilder();
    if(bitLength % 8 != 0) {
      throw('Invalid bitLength value - $bitLength');
    }
    double parts = bitLength / 8;
    for (var i = 0; i < parts.toInt(); ++i) {
      builder.addByte(nextInt(256));
    }
    Uint8List bytes = builder.toBytes();
    return bytes.toBigInt();
  }
}

extension Uint8ListExtension on Uint8List {
  BigInt toBigInt() {
    BigInt result = BigInt.zero;

    for (final byte in this) {
      // reading in big-endian, so we essentially concat the new byte to the end
      result = (result << 8) | BigInt.from(byte & 0xff);
    }
    return result;
  }
}

class UnsupportedPlatformException {
  final String message;

  UnsupportedPlatformException(this.message);
}
