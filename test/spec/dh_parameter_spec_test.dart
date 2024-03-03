import 'package:diffie_hellman/src/spec/dh_parameter_spec.dart';
import 'package:test/test.dart';

void main() {
  DhParameterSpec dhParameterSpec = DhParameterSpec(
    groupId: 1,
    p: BigInt.two,
    g: 2,
  );
  test('Test getters - default length', () {
    expect(
      dhParameterSpec.p,
      BigInt.two,
    );
    expect(dhParameterSpec.g, 2);
    expect(dhParameterSpec.length, 256);
  });
  test('Test getters', () {
    expect(
      dhParameterSpec.p,
      BigInt.two,
    );
    expect(dhParameterSpec.g, 2);
    expect(dhParameterSpec.length, 256);
  });
}
