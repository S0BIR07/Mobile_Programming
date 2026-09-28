void levelThree() {
  int.parse('invalid_number');
}
void levelTwo() => levelThree();
void levelOne() => levelTwo();

void main() {
  try {
    levelOne();
  } catch (error, stackTrace) {
    print('=== ERROR ENCOUNTERED ===');
    print('Error Message: $error\n');
    print('=== FULL STACK TRACE ===');
    print(stackTrace);
  }
}