import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:diffie_hellman/src/base/pem_codec.dart';
import 'package:diffie_hellman/src/spec/dh_parameter.dart';
import 'package:meta/meta.dart';

class DhParameterCodec extends PemCodec<DhParameter> {
  @override
  @protected
  String get beginDelimiter => '-----BEGIN DH PARAMETERS-----';

  @override
  @protected
  String get endDelimiter => '-----END DH PARAMETERS-----';

  @override
  ASN1Sequence asn1Encode(DhParameter parameter) {
    var asn1Sequence = ASN1Sequence();

    asn1Sequence.add(ASN1Integer(parameter.p));
    asn1Sequence.add(ASN1Integer(BigInt.from(parameter.g)));
    if (parameter.length != null) {
      asn1Sequence.add(ASN1Integer(BigInt.from(parameter.length!)));
    }

    return asn1Sequence;
  }

  @override
  DhParameter asn1Decode(Uint8List derBytes) {
    ASN1Parser asn1Parser = ASN1Parser(derBytes);

    ASN1Sequence asn1Sequence = asn1Parser.nextObject() as ASN1Sequence;

    BigInt p = (asn1Sequence.elements[0] as ASN1Integer).valueAsBigInteger;
    int g = (asn1Sequence.elements[1] as ASN1Integer).valueAsBigInteger.toInt();

    int? length;
    if (asn1Sequence.elements.length == 3) {
      length =
          (asn1Sequence.elements[2] as ASN1Integer?)?.valueAsBigInteger.toInt();
    }

    return DhParameter(
      p: p,
      g: g,
      length: length,
    );
  }
}
