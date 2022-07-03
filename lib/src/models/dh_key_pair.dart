class DhKeyPair {
  final BigInt _publicKey;
  final BigInt _privateKey;

  DhKeyPair({
    required BigInt publicKey,
    required BigInt privateKey,
  })  : _publicKey = publicKey,
        _privateKey = privateKey;

  int get privateKey => _privateKey.toInt();

  int get publicKey => _publicKey.toInt();
}
