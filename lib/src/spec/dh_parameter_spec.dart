import 'package:equatable/equatable.dart';

/// This class specifies the set of parameters used with the Diffie-Hellman algorithm, as specified in PKCS #3
/// The parameters are a prime p, a base g, and optionally the length in bits of the private value, (default to 256).
/// Note that this class does not perform any validation on specified parameters.
class DhParameterSpec extends Equatable {
  static const int defaultPrivateKeyLength = 256;

  /// The Diffie-Hellman group ID
  final int groupId;

  /// The prime modulus p
  final BigInt p;

  /// The base generator g
  final int g;

  /// The size in bits of the random exponent (private key)
  final int length;

  const DhParameterSpec({
    required this.groupId,
    required this.p,
    required this.g,
    this.length = defaultPrivateKeyLength,
  });

  @override
  List<Object?> get props => [
        groupId,
        p,
        g,
        length,
      ];
}
