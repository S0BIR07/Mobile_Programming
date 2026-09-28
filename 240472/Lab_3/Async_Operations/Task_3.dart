Future<String> fetchUser() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'User Profile Loaded';
}

Future<List<String>> fetchPosts() async {
  await Future.delayed(const Duration(seconds: 2));
  return ['Post 1', 'Post 2'];
}

Future<Map<String, String>> fetchSettings() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return {'theme': 'dark'};
}

void main() async {
  final stopwatch = Stopwatch()..start();
  print('Starting concurrent tasks...');

  final results = await Future.wait([
    fetchUser(),
    fetchPosts(),
    fetchSettings(),
  ]);

  print('All Tasks Completed in ${stopwatch.elapsed.inSeconds} seconds!');
  print('User: ${results[0]}');
  print('Posts: ${results[1]}');
  print('Settings: ${results[2]}');
}