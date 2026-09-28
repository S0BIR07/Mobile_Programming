void main() {
  // Single-line comment: Storing dimensions for the calculation
  double principal = 1000.0;
  double rate = 0.05;
  int timeInYears = 3;

  /*
    Multi-line comment:
    Calculating Simple Interest using the standard financial formula.
    Formula: Interest = (Principal * Rate * Time)
  */
  double simpleInterest = principal * rate * timeInYears;

  print('Simple Interest: \$${simpleInterest}');
}