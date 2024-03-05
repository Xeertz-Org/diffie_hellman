import 'package:diffie_hellman/src/base/pem_codec.dart';
import 'package:diffie_hellman/src/keys/dh_key.dart';
import 'package:diffie_hellman/src/spec/codec/dh_parameter_codec.dart';
import 'package:meta/meta.dart';

abstract class DhKeyCodec<T extends DhKey> extends PemCodec<T> {
  static const String oIdString = '1.2.840.113549.1.3.1';
  static final List<int> oId = oIdString.split('.').map(int.parse).toList();

  @protected
  final DhParameterCodec parameterCodec = DhParameterCodec();
}
