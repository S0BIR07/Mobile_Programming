void processUsername(String? username) {
  if (username == null || username.trim().isEmpty) {
    throw ArgumentError('Username input cannot be null or empty.');
  }

  print('Processing valid username: $username');
}

void main() {
  try {
    processUsername('sobir07');
    processUsername('');
  } catch (e) {
    print('Error: $e');
  }
}