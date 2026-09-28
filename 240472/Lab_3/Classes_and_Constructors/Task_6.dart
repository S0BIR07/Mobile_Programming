class UserDto {
  final int id;
  final String username;
  final String email;

  const UserDto({
    required this.id,
    required this.username,
    required this.email,
  });

  UserDto copyWith({
    int? id,
    String? username,
    String? email,
  }) {
    return UserDto(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  @override
  String toString() => 'UserDto(id: $id, username: $username, email: $email)';
}

void main() {
 const user1 = UserDto(id: 1, username: 'sobir', email: 'sobir@dev.com');
  const user2 = UserDto(id: 1, username: 'sobir', email: 'sobir@dev.com');
  print(user1);
  print('Are user1 and user2 identical in memory? ${identical(user1, user2)}'); 
  UserDto updatedUser = user1.copyWith(email: 'newemail@dev.com');
  print('Updated DTO: $updatedUser');
}