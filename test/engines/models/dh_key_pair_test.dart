import 'package:diffie_hellman/diffie_hellman.dart';
import 'package:test/test.dart';

void main() {
  BigInt publicKey = BigInt.from(1);
  BigInt privateKey = BigInt.from(2);
  DhParameterSpec dhParameterSpec = DhGroup.g1.getParameterSpec(256);
  DhKeyPair keyPair = DhKeyPair(
    publicKey: publicKey,
    privateKey: privateKey,
    parameterSpec: dhParameterSpec,
  );
  test('Test getters', () {
    expect(keyPair.publicKey, publicKey);
    expect(keyPair.privateKey, privateKey);
    expect(keyPair.parameterSpec, dhParameterSpec);
  });
}
