import 'package:diffie_hellman/src/models/dh_parameter_spec.dart';

import 'constants/dh_parameter_constants.dart';

class DhGroups {
  static DhParameterSpec getDhParametersFromGroup(
    int groupId, {
    required int privateKeyLength,
  }) {
    BigInt p;
    switch (groupId) {
      case 1:
        p = BigInt.parse(
          group1Prime,
          radix: 16,
        );
        break;
      case 2:
        p = BigInt.parse(
          group2Prime,
          radix: 16,
        );
        break;
      case 5:
        p = BigInt.parse(
          group5Prime,
          radix: 16,
        );
        break;
      case 14:
        p = BigInt.parse(
          group14Prime,
          radix: 16,
        );
        break;
      case 15:
        p = BigInt.parse(
          group15Prime,
          radix: 16,
        );
        break;
      case 16:
        p = BigInt.parse(
          group16Prime,
          radix: 16,
        );
        break;
      case 17:
        p = BigInt.parse(
          group17Prime,
          radix: 16,
        );
        break;
      case 18:
        p = BigInt.parse(
          group18Prime,
          radix: 16,
        );
        break;
      default:
        throw ArgumentError.value(groupId, 'Unknown groupId');
    }
    return DhParameterSpec(
      p: p,
      g: generator,
      length: privateKeyLength,
    );
  }
}
