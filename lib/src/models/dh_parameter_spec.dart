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

  int get length => _length;

  int get g => _g;

  BigInt get p => _p;
}
