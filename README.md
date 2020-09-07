# Any Base

Convert numbers from any base (radix) to any other base using any
alphabet of digits.

## Example ##

```dart
// Flickr Base 58 alphabet.
const flickr58 = '123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ';
const dec2hex = AnyBase(AnyBase.dec, AnyBase.hex);
const dec2flickr = AnyBase(AnyBase.dec, flickr58);

dec2hex.convert('123456'); // returns '1e240'.
dec2flickr.convert('1234567890'); // returns '2T6u2h'.
dec2flickr.revert('2T6u2h'); // returns '1234567890'.
```

## API ##

### AnyBase() ###
-----------------

Returns an __AnyBase__ object that can be used to convert input from the
source alphabet to the destination alphabet, extrapolating the radices
from the lengths of the alphabets.

#### Example ####

```dart
const anyBase = const AnyBase(sourceAlphabet, destinationAlphabet);
```

#### Parameters ####

* `String` __sourceAlphabet__      digits in ascending order.
* `String` __destinationAlphabet__ digits in ascending order.

*Ascending order meaning from lowest value to highest. For example
`'0123456789'` in decimal.*



### AnyBase.convert() ###
-------------------------

Returns the input value mapped from the source alphabet to the
destination alphabet. For example, if the input value was `'10'` and the
input alphabet was `AnyBase.dec` (for decimal) and the output alphabet
was `AnyBase.hex` (for hexadecimal) the return value would be `'a'`;

#### Example ####

```dart
const anyBase = const AnyBase(sourceAlphabet, destinationAlphabet);
anyBase.convert(source);
```

#### Parameters ####

* `String` __source__ Input value as String. For example `'10'`.



### AnyBase.revert() ###
------------------------

Performs the converse action of convert.

#### Example ####

```dart
const anyBase = const AnyBase(sourceAlphabet, destinationAlphabet);
anyBase.revert(source);
```

#### Parameters ####

* `String` __source__ Input value as String. For example `'a'`.


### Static Members ###
----------------------

 * `String` __AnyBase.dec__ Predefined alphabet for decimal numbers.
 * `String` __AnyBase.hex__ Predefined alphabet for hexadecimal numbers.
 * `String` __AnyBase.bin__ Predefined alphabet for binary numbers.
 * `String` __AnyBase.oct__ Predefined alphabet for octal numbers.

## Attributions

The original algorithm was converted from Kamil Harasimowicz's
[any-base](https://github.com/HarasimowiczKamil/any-base) npm project. A
copy of the project's license can be found in the [LICENSE](LICENSE)
file under the section `any-base algorithm`.
