int safeDivide(int numerator, int denominator) {
  try {
    return numerator ~/ denominator;
  } on UnsupportedError {
    print('Caught UnsupportedError: Cannot divide an integer by zero.');
    return 0;
  }
}

void main() {
  print('Result (10 / 2): ${safeDivide(10, 2)}');
  print('Result (10 / 0): ${safeDivide(10, 0)}');
}