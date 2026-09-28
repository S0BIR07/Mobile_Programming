abstract class Printable {
  void printData();
}

class Document implements Printable {
  @override
  void printData() {
    print('Printing document contents...');
  }
}

mixin Logger {
  void log(String msg) {
    print('[LOG]: $msg');
  }
}

class Service with Logger {
  void execute() {
    log('Service started successfully.');
  }
}

void main() {
  var doc = Document();
  doc.printData();
  var service = Service();
  service.execute();
}