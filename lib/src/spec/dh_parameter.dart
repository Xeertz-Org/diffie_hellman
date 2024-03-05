import 'package:diffie_hellman/src/spec/codec/dh_parameter_codec.dart';
import 'package:equatable/equatable.dart';

/// This class specifies the set of parameters used with the Diffie-Hellman algorithm, as specified in PKCS #3
/// The parameters are a prime p, a base g, and optionally the length in bits of the private value, (default to 256).
/// Note that this class does not perform any validation on specified parameters.
class DhParameter extends Equatable {
  final DhParameterCodec _codec;

  /// The prime modulus p.
  final BigInt p;

  /// The base generator g.
  final int g;

  /// The size in bits of the random exponent (private key).
  final int? length;

  DhParameter({
    required this.p,
    required this.g,
    this.length,
  }) : _codec = DhParameterCodec();

  /// Constructs a [DhParameter] instance using a PEM string.
  factory DhParameter.fromPem(String pem) => DhParameterCodec().decode(pem);

  String toPem() => _codec.encode(this);

  @override
  List<Object?> get props => [
        p,
        g,
        length,
      ];
}
