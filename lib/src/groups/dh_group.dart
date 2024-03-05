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
  g18,

  /// 1024-bit MODP Group with 160-bit prime order subgroup.
  g22,

  /// 2048-bit MODP Group with 224-bit prime order subgroup.
  g23,

  /// 2048-bit MODP Group with 256-bit prime order subgroup.
  g24;

  /// The Diffie-Hellman parameters for this group
  DhParameter get parameter => getParameter(this);
}
