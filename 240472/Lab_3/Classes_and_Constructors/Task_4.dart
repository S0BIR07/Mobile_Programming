class Database{
  static final Database _instance=Database._internal();
  Database._internal();
  factory Database(){
    return _instance;
  }
}

void query(String sql){
  print('Executing SQL query: $sql');
}

void main(){
  var db1=Database();
  var db2=Database();
  print('Are both instances the same? ${db1==db2}');
  query('SELECT * FROM users');
}