List<int> transformList(List<int> numbers, int Function(int) transformer) {
  List<int> result = [];
  for (int number in numbers) {
    result.add(transformer(number));
  }
  return result;
}

void main() {
  List<int> originalList = [1, 2, 3, 4, 5];
  List<int> doubled = transformList(originalList, (n) => n * 2);
  print('Doubled: $doubled');
  List<int> squared = transformList(originalList, (n) => n * n);
  print('Squared: $squared');
}