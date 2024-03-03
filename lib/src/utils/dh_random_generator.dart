import 'dart:math';

import 'package:diffie_hellman/src/utils/extensions.dart';

abstract class DhRandomGenerator {
  static BigInt generatePrivateValue(int bitLength) {
    Random random = Random.secure();

    BigInt lowerBound = BigInt.two.pow(bitLength - 1);
    BigInt upperBound = BigInt.two * lowerBound;
    BigInt generated;

    do {
      generated = random.nextBigInt(bitLength);
    } while (generated < lowerBound || generated >= upperBound);

    return generated;
  }
}
