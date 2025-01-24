import 'package:flutter_test/flutter_test.dart';
import './main.dart';

void main() {
  group('One surname user', () {
    test('Valid creation', () {
      User user = User(name: "John", firstSurname: "Doe");

      expect(user.name, "John");
      expect(user.firstSurname, "Doe");
      expect(user.secondSurname, null);
    });
    test('Valid creation with null', () {
      User user = User(name: "John", firstSurname: "Doe", secondSurname: null);

      expect(user.name, "John");
      expect(user.firstSurname, "Doe");
      expect(user.secondSurname, null);
    });
    test('Overrides toString', () {
      User user = User(name: "John", firstSurname: "Doe");
      expect(user.toString(), "John Doe");
    });
  });

  group('Two surname user', () {
    test('Valid creation', () {
      User user = User(name: "John", firstSurname: "Doe", secondSurname: "Roe");

      expect(user.name, "John");
      expect(user.firstSurname, "Doe");
      expect(user.secondSurname, "Roe");
    });
    test('Overrides toString', () {
      User user = User(name: "John", firstSurname: "Doe", secondSurname: "Roe");
      expect(user.toString(), "John Doe Roe");
    });
  });
}
