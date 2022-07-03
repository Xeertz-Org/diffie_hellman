class DhKeyPair {
  final BigInt _publicKey;
  final BigInt _privateKey;

  DhKeyPair({
    required BigInt publicKey,
    required BigInt privateKey,
  })  : _publicKey = publicKey,
        _privateKey = privateKey;

  BigInt get privateKey => _privateKey;

  BigInt get publicKey => _publicKey;
}
