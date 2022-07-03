/// This class specifies the set of parameters used with the Diffie-Hellman algorithm, as specified in PKCS #3
/// The parameters are a prime p, a base g, and optionally the length in bits of the private value, (default to 256).
/// Note that this class does not perform any validation on specified parameters.
class DhParameterSpec {
  static const int defaultPrivateKeyLength = 256;

  final BigInt _p;
  final int _g;
  final int _length;

  DhParameterSpec({
    required BigInt p,
    required int g,
    int length = defaultPrivateKeyLength,
  })  : _p = p,
        _g = g,
        _length = length;

  /// Returns the size in bits of the random exponent (private value)
  int get length => _length;

  /// Returns the base generator g
  int get g => _g;

  /// Returns the prime modulus p
  BigInt get p => _p;
}
