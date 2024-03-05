import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:diffie_hellman/src/keys/codec/dh_key_codec.dart';
import 'package:diffie_hellman/src/keys/dh_private_key.dart';
import 'package:diffie_hellman/src/spec/dh_parameter.dart';
import 'package:diffie_hellman/src/utils/extensions.dart';

class DhPrivateKeyCodec extends DhKeyCodec<DhPrivateKey> {
  @override
  String get beginDelimiter => '-----BEGIN PRIVATE KEY-----';

  @override
  String get endDelimiter => '-----END PRIVATE KEY-----';

  @override
  ASN1Sequence asn1Encode(DhPrivateKey key) {
    ASN1Sequence outerSequence = ASN1Sequence();

    ASN1Sequence keyAgreementSequence = ASN1Sequence();
    keyAgreementSequence.add(
      ASN1ObjectIdentifier(
        DhKeyCodec.oId,
      ),
    );
    keyAgreementSequence.add(parameterCodec.asn1Encode(key.parameter));

    ASN1OctetString privateKeyOctetString =
        ASN1OctetString(key.value.toBigEndianBytes());

    outerSequence.add(ASN1Integer(BigInt.zero));
    outerSequence.add(keyAgreementSequence);
    outerSequence.add(privateKeyOctetString);

    return outerSequence;
  }

  @override
  DhPrivateKey asn1Decode(Uint8List derBytes) {
    ASN1Parser asn1Parser = ASN1Parser(derBytes);

    ASN1Sequence outerSequence = asn1Parser.nextObject() as ASN1Sequence;

    ASN1Sequence keyAgreementSequence =
        outerSequence.elements[1] as ASN1Sequence;
    ASN1ObjectIdentifier oid =
        keyAgreementSequence.elements[0] as ASN1ObjectIdentifier;
    if (oid.identifier != DhKeyCodec.oIdString) {
      throw ArgumentError('Invalid OID: ${oid.oi}');
    }

    ASN1Sequence parameterSequence =
        keyAgreementSequence.elements[1] as ASN1Sequence;

    ASN1OctetString privateKeyOctetString =
        outerSequence.elements[2] as ASN1OctetString;

    DhParameter parameter =
        parameterCodec.asn1Decode(parameterSequence.encodedBytes);

    BigInt privateKeyValue = privateKeyOctetString.octets.toBigInt();

    return DhPrivateKey(privateKeyValue, parameter: parameter);
  }
}
