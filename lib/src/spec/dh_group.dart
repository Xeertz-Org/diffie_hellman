import 'package:diffie_hellman/diffie_hellman.dart';
import 'package:diffie_hellman/src/spec/dh_parameter_constants.dart';

enum DhGroup {
  g1,
  g2,
  g5,
  g14,
  g15,
  g16,
  g17,
  g18;

  static DhGroup fromId(int id) {
    switch (id) {
      case 1:
        return DhGroup.g1;
      case 2:
        return DhGroup.g2;
      case 5:
        return DhGroup.g5;
      case 14:
        return DhGroup.g14;
      case 15:
        return DhGroup.g15;
      case 16:
        return DhGroup.g16;
      case 17:
        return DhGroup.g17;
      case 18:
        return DhGroup.g18;
      default:
        throw ArgumentError('Invalid group id');
    }
  }

  int get id {
    switch (this) {
      case DhGroup.g1:
        return 1;
      case DhGroup.g2:
        return 2;
      case DhGroup.g5:
        return 5;
      case DhGroup.g14:
        return 14;
      case DhGroup.g15:
        return 15;
      case DhGroup.g16:
        return 16;
      case DhGroup.g17:
        return 17;
      case DhGroup.g18:
        return 18;
    }
  }

  String get _pHex {
    switch (this) {
      case DhGroup.g1:
        return g1Prime;
      case DhGroup.g2:
        return g2Prime;
      case DhGroup.g5:
        return g5Prime;
      case DhGroup.g14:
        return g14Prime;
      case DhGroup.g15:
        return g15Prime;
      case DhGroup.g16:
        return g16Prime;
      case DhGroup.g17:
        return g17Prime;
      case DhGroup.g18:
        return g18Prime;
    }
  }

  BigInt get _p => BigInt.parse(
        _pHex,
        radix: 16,
      );

  DhParameterSpec getParameterSpec(int privateKeyLength) => DhParameterSpec(
        groupId: id,
        p: _p,
        g: generator,
        length: privateKeyLength,
      );
}
