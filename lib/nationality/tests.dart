import 'package:flutter_test/flutter_test.dart';
import './main.dart';

void main() {
  group('Existing name', () {
    test('Johnson', () {
      User user = User(name: 'Johnson', age: 20);
      expect(user.getNationality(), 'Johnson is from CM with 7.38% certainty');
    });
    test('Daniel', () {
      User user = User(name: 'Daniel', age: 40);
      expect(user.getNationality(), 'Daniel is from RO with 9.32% certainty');
    });
  });
  group('Not existing name', () {
    test('qsdcv', () {
      User user = User(name: 'qsdcv', age: 20);
      expect(user.getNationality(), 'qsdcv not available');
    });
    test('123', () {
      User user = User(name: '123', age: 40);
      expect(user.getNationality(), '123 not available');
    });
  });
}
