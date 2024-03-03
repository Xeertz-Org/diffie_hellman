import 'package:diffie_hellman/src/spec/dh_parameter_spec.dart';
import 'package:equatable/equatable.dart';

/// This class is a container for a key pair (a public key and a private key)
class DhKeyPair extends Equatable {
  final BigInt publicKey;
  final BigInt privateKey;
  final DhParameterSpec parameterSpec;

  const DhKeyPair({
    required this.publicKey,
    required this.privateKey,
    required this.parameterSpec,
  });

  @override
  List<Object?> get props => [
        publicKey,
        privateKey,
        parameterSpec,
      ];
}
