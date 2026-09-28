/// A utility class designed for validating incoming application data.
class DataValidator {

  /// Validates if an input string is a properly formatted age.
  ///
  /// Takes an [input] string representing user age.
  /// Returns an [int] parsed from the input if valid.
  ///
  /// Throws an [ArgumentError] if [input] is empty.
  /// Throws a [FormatException] if [input] contains non-numeric characters.
  static int validateAge(String input) {
    if (input.isEmpty) {
      throw ArgumentError('Age input cannot be empty.');
    }
    
    int? age = int.tryParse(input);
    if (age == null) {
      throw FormatException('Age must be a valid number.');
    }

    return age;
  }
}

void main() {
  try {
    int age = DataValidator.validateAge('19');
    print('Validated Age: $age');
  } catch (e) {
    print('Error: $e');
  }
}