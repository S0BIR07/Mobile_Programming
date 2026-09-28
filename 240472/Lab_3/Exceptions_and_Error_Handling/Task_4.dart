import 'dart:io';

void processFile(String path) {
  try {
    if (path.isEmpty) {
      throw ArgumentError('Path string cannot be empty.');
    }
    
    var file = File(path);
    file.readAsStringSync();
  } on ArgumentError catch (e) {
    print('[Specific Handler]: Invalid Argument provided -> $e');
  } on PathNotFoundException catch (e) {
    print('[Specific Handler]: File system path missing -> ${e.message}');
  } catch (e) {
    print('[Generic Handler]: An unexpected error occurred -> $e');
  }
}

void main() {
  processFile('');
  processFile('non_existent.txt');
}