import 'package:diffie_hellman/src/groups/dh_groups.dart';
import 'package:diffie_hellman/src/spec/dh_parameter.dart';

/// Diffie-Hellman groups
enum DhGroup {
  /// 768-bit MODP Group.
  g1,

  /// 1024-bit MODP Group.
  g2,

  /// 1536-bit MODP Group.
  g5,

  /// 2048-bit MODP Group.
  g14,

  /// 3072-bit MODP Group.
  g15,

  /// 4096-bit MODP Group.
  g16,

  /// 6144-bit MODP Group.
  g17,

  /// 8192-bit MODP Group.
  g18;

  /// Get the Diffie-Hellman parameters for this group
  /// If [privateValueLength] is not provided, the default value of 2048 is used.
  DhParameter getParameter({int? privateValueLength}) => getDhParameter(
        this,
        privateValueLength: privateValueLength,
      );
}
