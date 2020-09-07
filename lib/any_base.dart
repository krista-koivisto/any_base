library any_base;

/// Convert numbers from any base (radix) to any other base using any alphabet
/// of digits.
///
/// __Example__
///
/// ```dart
/// const dec2hex = AnyBase(AnyBase.dec, AnyBase.hex);
///
/// dec2hex.convert('123456'); // returns '1e240'.
/// dec2hex.revert('1e240');   // returns '123456'.
/// ```
///
/// Returns an __AnyBase__ object that can be used to convert input from the
/// source alphabet to the destination alphabet, extrapolating the radices
/// from the lengths of the alphabets.
class AnyBase {
  final String sourceAlphabet;
  final String destinationAlphabet;

  /// Predefined alphabet for binary.
  static const String bin = '01';

  /// Predefined alphabet for octal.
  static const String oct = '01234567';

  /// Predefined alphabet for decimal.
  static const String dec = '0123456789';

  /// Predefined alphabet for hexadecimal.
  static const String hex = '0123456789abcdef';

  const AnyBase(this.sourceAlphabet, this.destinationAlphabet)
      : assert(sourceAlphabet != null && sourceAlphabet.length > 0),
        assert(destinationAlphabet != null && destinationAlphabet.length > 0);

  /// Convert `source` from the source alphabet to the destination alphabet.
  ///
  /// Returns a String where [source] has been converted from `sourceAlphabet`
  /// to `destinationAlphabet`.
  String convert(String source) {
    return _convert(source, sourceAlphabet, destinationAlphabet);
  }

  /// Convert `source` from the destination alphabet to the source alphabet.
  ///
  /// Returns a String where [source] has been converted from
  /// `destinationAlphabet` to `sourceAlphabet`.
  String revert(String source) {
    return _convert(source, destinationAlphabet, sourceAlphabet);
  }

  static String _convert(
      source, String sourceAlphabet, String destinationAlphabet) {
    assert(source != null);
    if (source.length == 0 || sourceAlphabet == destinationAlphabet) {
      return source;
    }

    final sourceBase = sourceAlphabet.length;
    final destinationBase = destinationAlphabet.length;
    final Map numberMap = {};
    int divide = 0;
    int newLength = 0;
    int length = source.length;
    String result = '';

    for (int i = 0; i < length; i++) {
      final index = sourceAlphabet.indexOf(source[i]);
      if (index == -1) {
        throw FormatException('Source "$source" contains character ' +
            '"${source[i]}" which is outside of the defined source alphabet ' +
            '"$sourceAlphabet"');
      }
      numberMap[i] = sourceAlphabet.indexOf(source[i]);
    }

    // Algorithm below by Kamil Harasimowicz.
    // https://github.com/HarasimowiczKamil/any-base
    // See section "any-base algorithm" in LICENSE file for license.
    do {
      divide = 0;
      newLength = 0;
      for (int i = 0; i < length; i++) {
        divide = divide * sourceBase + numberMap[i];
        if (divide >= destinationBase) {
          numberMap[newLength++] = divide ~/ destinationBase;
          divide = divide % destinationBase;
        } else if (newLength > 0) {
          numberMap[newLength++] = 0;
        }
      }
      length = newLength;
      result = destinationAlphabet[divide] + result;
    } while (newLength != 0);
    return result;
  }
}
