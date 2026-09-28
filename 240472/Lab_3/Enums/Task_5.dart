enum UserRole {
  admin,
  editor,
  viewer
}

class RoleParser {
  static UserRole? safeParse(String rawRole) {
    try {
      return UserRole.values.byName(rawRole.trim().toLowerCase());
    } on ArgumentError {
      return null;
    }
  }
}

void main() {
  List<String> rawInputData = ['admin', ' EDITOR ', 'super_user', 'viewer'];

  for (String input in rawInputData) {
    UserRole? role = RoleParser.safeParse(input);

    if (role != null) {
      print('Success: Translated "$input" to $role');
    } else {
      print('Warning: "$input" is not a valid UserRole. Skipping.');
    }
  }
}