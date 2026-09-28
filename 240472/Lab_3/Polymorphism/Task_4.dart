class Repository<T> {
  final List<T> _storage = [];
  void add(T item) {
    _storage.add(item);
    print('Added $T to repository.');
  }
  List<T> getAll() => List.unmodifiable(_storage);
}

class User {
  final String name;
  User(this.name);
  @override
  String toString() => 'User($name)';
}

void main() {
  var stringRepo = Repository<String>();
  stringRepo.add('First Entry');
  var userRepo = Repository<User>();
  userRepo.add(User('Alice'));
  userRepo.add(User('Bob'));
  print('Users in DB: ${userRepo.getAll()}');
}