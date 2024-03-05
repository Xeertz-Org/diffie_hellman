import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:diffie_hellman/src/keys/codec/dh_key_codec.dart';
import 'package:diffie_hellman/src/keys/dh_public_key.dart';
import 'package:diffie_hellman/src/spec/dh_parameter.dart';
import 'package:diffie_hellman/src/utils/extensions.dart';

class DhPublicKeyCodec extends DhKeyCodec<DhPublicKey> {
  @override
  String get beginDelimiter => '-----BEGIN PUBLIC KEY-----';

  @override
  String get endDelimiter => '-----END PUBLIC KEY-----';

  @override
  ASN1Sequence asn1Encode(DhPublicKey key) {
    ASN1Sequence outerSequence = ASN1Sequence();

    ASN1Sequence keyAgreementSequence = ASN1Sequence();
    keyAgreementSequence.add(
      ASN1ObjectIdentifier(
        DhKeyCodec.oId,
      ),
    );
    keyAgreementSequence.add(parameterCodec.asn1Encode(key.parameter));

    ASN1BitString publicKeyBitString =
        ASN1BitString(key.value.toBigEndianBytes());

    outerSequence.add(keyAgreementSequence);
    outerSequence.add(publicKeyBitString);

    return outerSequence;
  }

  @override
  DhPublicKey asn1Decode(Uint8List derBytes) {
    ASN1Parser asn1Parser = ASN1Parser(derBytes);

    ASN1Sequence outerSequence = asn1Parser.nextObject() as ASN1Sequence;

    ASN1Sequence keyAgreementSequence =
        outerSequence.elements[0] as ASN1Sequence;
    ASN1ObjectIdentifier oid =
        keyAgreementSequence.elements[0] as ASN1ObjectIdentifier;
    if (oid.identifier != DhKeyCodec.oIdString) {
      throw ArgumentError('Invalid OID: ${oid.oi}');
    }

    ASN1Sequence parameterSequence =
        keyAgreementSequence.elements[1] as ASN1Sequence;

    ASN1BitString publicKeyBitString =
        outerSequence.elements[1] as ASN1BitString;

    DhParameter parameter =
        parameterCodec.asn1Decode(parameterSequence.encodedBytes);

    BigInt publicKeyValue =
        Uint8List.fromList(publicKeyBitString.stringValue).toBigInt();

    return DhPublicKey(publicKeyValue, parameter: parameter);
  }
}
