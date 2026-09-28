class UserProfile {
  final String username;
  final int age;

  UserProfile(String username, int age)
      : assert(username.isNotEmpty, 'Username cannot be empty'),
        assert(age >= 0 && age <= 120, 'Age must be between 0 and 120'),
        this.username = username,
        this.age = age;
  void display() {
    print('User: $username, Age: $age');
  }
}

void main() {
  var validUser = UserProfile('Muhammadsobir', 19);
  validUser.display();
}