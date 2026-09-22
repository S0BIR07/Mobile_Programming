String formatMessage(String message, [String prefix = '', String suffix = '']) {
  return '$prefix$message$suffix';
}

void main() {
  print(formatMessage('Hello')); 
  print(formatMessage('World', '>>> ')); 
  print(formatMessage('Flutter', '[', ']')); 
}