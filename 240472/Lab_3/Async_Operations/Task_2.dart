Future<Map<String, dynamic>> fetchUserData(int userId) async {
  print('Querying database for User ID: $userId...');
  await Future.delayed(const Duration(seconds: 2));
  return {
    'id': userId,
    'username': 'sobir07',
    'email': 'sobir@dev.com',
  };
}

void main() async {
  print('Start database request.');
  var user = await fetchUserData(240472);
  print('Database Result: $user');
}