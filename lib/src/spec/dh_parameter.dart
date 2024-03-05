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
  final BigInt g;

  /// The size in bits of the random exponent (private key).
  final int? l;

  DhParameter({
    required this.p,
    required this.g,
    this.l,
  }) : _codec = DhParameterCodec();

  /// Constructs a [DhParameter] instance using a PEM string.
  factory DhParameter.fromPem(String pem) => DhParameterCodec().decode(pem);

  String toPem() => _codec.encode(this);

  DhParameter copyWith({
    BigInt? p,
    BigInt? g,
    int? l,
  }) =>
      DhParameter(
        p: p ?? this.p,
        g: g ?? this.g,
        l: l ?? this.l,
      );

  @override
  List<Object?> get props => [
        p,
        g,
        l,
      ];
}
