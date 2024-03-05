import 'dart:convert';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:meta/meta.dart';

abstract class PemCodec<T> {
  @protected
  String get beginDelimiter;

  @protected
  String get endDelimiter;

  String removeDelimiters(String encoded) {
    return encoded
        .replaceAll(beginDelimiter, '')
        .replaceAll(endDelimiter, '')
        .replaceAll('\n', '');
  }

  String encode(T value) {
    String base64 = base64Encode(asn1Encode(value).encodedBytes);

    return '$beginDelimiter$base64$endDelimiter';
  }

  T decode(String encoded) {
    String encodedWithoutDelimiters = removeDelimiters(encoded);

    try {
      Uint8List derBytes = base64Decode(encodedWithoutDelimiters);
      return asn1Decode(derBytes);
    } on ArgumentError {
      rethrow;
    } catch (e) {
      throw FormatException('Invalid encoding');
    }
  }

  ASN1Sequence asn1Encode(T value);

  T asn1Decode(Uint8List derBytes);
}
