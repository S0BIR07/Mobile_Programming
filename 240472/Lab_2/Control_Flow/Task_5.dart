void main() {
  outerLoop:
  for (int i = 1; i <= 3; i++) {
    innerLoop:
    for (int j = 1; j <= 3; j++) {
      if (i == 1 && j == 2) {
        print("Skipping remainder of outer iteration 1...");
        continue outerLoop;
      }
      if (i == 2 && j == 2) {
        print("Breaking out of outer loop completely!");
        break innerLoop;
      }
      print("i: $i, j: $j");
    }
  }
}