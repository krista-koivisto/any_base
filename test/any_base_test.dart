import 'package:any_base/any_base.dart';
import 'package:test/test.dart';

/// Returns a matcher for functions that throw object with type [T].
Matcher throwsTypeOf<T>() => throwsA(isA<T>());

void main() {
  test('hex 10 equals dec 16', () {
    final anyBase = AnyBase(AnyBase.hex, AnyBase.dec);
    expect(anyBase.convert('10'), '16');
  });
  test('revert equals input to convert', () {
    final anyBase = AnyBase(AnyBase.hex, AnyBase.dec);
    expect(anyBase.convert('250a'), '9482');
    expect(anyBase.revert('9482'), '250a');
  });
  test('custom alphabets map properly', () {
    final customHex = '0123456789nybase';
    final fromHex = AnyBase(AnyBase.hex, customHex);
    final toHex = AnyBase(customHex, AnyBase.hex);
    expect(fromHex.convert('abcdef'), 'nybase');
    expect(toHex.convert('nybase'), 'abcdef');
  });
}
