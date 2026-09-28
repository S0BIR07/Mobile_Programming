/// Abstract base class for database clients.
abstract class BaseDatabase {
  /// Connects to the database server.
  void connect();
}

/// PostgreSQL database implementation.
class PostgresDatabase extends BaseDatabase {
  
  /// Establishes connection using modern credentials.
  @override
  void connect() {
    print('Connected to PostgreSQL database.');
  }

  /// Legacy authentication method.
  /// 
  /// Use [connect] instead for enhanced security protocols.
  @Deprecated('Use connect() instead. This method will be removed in v2.0.')
  void oldConnect(String username, String password) {
    print('Connected via legacy method for user: $username');
  }
}

void main() {
  var db = PostgresDatabase();
  
  // Modern overridden call
  db.connect();

  // VS Code will draw a strikethrough over oldConnect()
  db.oldConnect('admin', 'secret123');
}