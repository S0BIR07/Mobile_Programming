import 'dart:io';

void logAndForwardError() {
  try {
    print('Performing network request...');
    throw HttpException('500 Internal Server Error');
  } catch (e) {
    print('Local Logger: Exception caught during request ($e). Rethrowing...');
    rethrow;
  }
}

void main() {
  try {
    logAndForwardError();
  } catch (e) {
    print('Global Main Handler: Successfully received forwarded exception -> $e');
  }
}