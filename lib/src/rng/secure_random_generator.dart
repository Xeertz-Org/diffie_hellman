import 'dart:math';

class SecureRandomGenerator {
  static BigInt generateDhPrivateValue(int bitLength) {
    Random rnd = Random.secure();

    BigInt lowerBound = BigInt.two.pow(bitLength - 1);
    late BigInt generated;

    bool loopCondition = true;
    while (loopCondition) {
      generated = BigInt.from(rnd.nextInt(bitLength));
      if (generated.compareTo(lowerBound) >= 0 &&
          generated.compareTo(BigInt.two * lowerBound) < 0) {
        loopCondition = false;
      }
    }

    return generated;
  }
}
