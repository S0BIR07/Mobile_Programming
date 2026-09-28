/// **A utility class for string sanitization and checks.**
///
/// ### Overview:
/// This class helps maintain **data consistency** across user inputs.
///
/// Key Features:
/// * Strips leading and trailing whitespace.
/// * Verifies minimum character length constraints.
///
/// Example implementation:
/// ```dart
/// bool valid = TextSanitizer.isNonEmpty(' Hello ');
/// print(valid); // true
/// ```
class TextSanitizer {

  /// Checks if a string contains meaningful text after trimming.
  ///
  /// Takes a [text] input and returns `true` if length > 0.
  static bool isNonEmpty(String text) {
    return text.trim().isNotEmpty;
  }
}

void main() {
  print(TextSanitizer.isNonEmpty('  Dart  '));
}