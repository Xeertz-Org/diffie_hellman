import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/src/platform_check/platform_check.dart';

class DhFortunaPrng {
  static BigInt generateDhPrivateValue(int bitLength) {
    SecureRandom rnd = SecureRandom('Fortuna')
      ..seed(
        KeyParameter(
          Platform.instance.platformEntropySource().getBytes(32),
        ),
      );

    BigInt lowerBound = BigInt.two.pow(bitLength - 1);
    late BigInt generated;

    bool loopCondition = true;
    while (loopCondition) {
      generated = rnd.nextBigInteger(bitLength);
      if (generated.compareTo(lowerBound) >= 0 &&
          generated.compareTo(BigInt.two * lowerBound) < 0) {
        loopCondition = false;
      }
    }

    return generated;
  }
}
