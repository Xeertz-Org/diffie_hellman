import 'dart:math';

import 'package:diffie_hellman/src/utils/extensions.dart';

abstract class DhRandomGenerator {
  static BigInt generatePrivateValueWithLength(int length) {
    Random random = Random.secure();

    BigInt lowerBound = BigInt.two.pow(length - 1);
    BigInt upperBound = BigInt.two * lowerBound;
    BigInt generated;

    do {
      generated = random.nextBigInt(length);
    } while (generated < lowerBound || generated >= upperBound);

    return generated;
  }

  static BigInt generatePrivateValueFromP(BigInt p) {
    Random random = Random.secure();

    BigInt lowerBound = BigInt.zero;
    BigInt upperBound = p - BigInt.one;
    BigInt generated;

    do {
      generated = random.nextBigInt(upperBound.bitLength);
    } while (generated <= lowerBound || generated >= upperBound);

    return generated;
  }
}
