import 'package:flutter_test/flutter_test.dart';
import './main.dart';

void main() {
  test('Run hello world', () {
    var result = helloWorld();
    expect(result, equals('Hello world from Dart!'), skip: true);
  });
}
