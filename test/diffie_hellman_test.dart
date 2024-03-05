import 'package:diffie_hellman/src/engines/dh_pkcs3_engine.dart';
import 'package:diffie_hellman/src/groups/dh_group.dart';
import 'package:diffie_hellman/src/keys/dh_key.dart';
import 'package:test/test.dart';

void main() {
  int iterations = 50;

  group('Benchmark', () {
    for (var group in DhGroup.values) {
      test('$group', () {
        DhPkcs3Engine engine = DhPkcs3Engine.fromGroup(group);
        DhPkcs3Engine otherEngine = DhPkcs3Engine.fromGroup(group);

        List<int> gTimes = [];
        List<int> cTimes = [];

        for (int i = 0; i < iterations; i++) {
          Stopwatch gStopwatch = Stopwatch()..start();

          engine.generateKeyPair();
          DhKeyPair otherKeyPair = otherEngine.generateKeyPair();

          gStopwatch.stop();

          Stopwatch cStopwatch = Stopwatch()..start();

          BigInt secretKey =
              engine.computeSecretKey(otherKeyPair.publicKey.value);

          cStopwatch.stop();

          expect(
            engine.publicKey!.value.bitLength,
            inInclusiveRange(
              engine.parameter.p.bitLength - 15,
              engine.parameter.p.bitLength,
            ),
          );
          expect(engine.privateKey!.value.bitLength, engine.parameter.l);
          expect(
            secretKey.bitLength,
            inInclusiveRange(
              engine.parameter.p.bitLength - 15,
              engine.parameter.p.bitLength,
            ),
          );

          gTimes.add(gStopwatch.elapsedMilliseconds);
          cTimes.add(cStopwatch.elapsedMilliseconds);
          gStopwatch.reset();
          cStopwatch.reset();
        }

        int totalGTime = gTimes.reduce((a, b) => a + b);
        double meanGTime = totalGTime / gTimes.length;

        int totalCTime = cTimes.reduce((a, b) => a + b);
        double meanCTime = totalCTime / cTimes.length;

        print('---------- Group: $group (l=${engine.parameter.l}) ----------');
        print('generateKeyPair() mean: $meanGTime ms');
        print('computeSecretKey() mean: $meanCTime ms');
        print('-----------------------------------------------');
        print('\n');
      });
    }
  });
}
