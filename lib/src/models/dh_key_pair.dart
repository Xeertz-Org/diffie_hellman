/// This class is a container for a key pair (a public key and a private key)
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
