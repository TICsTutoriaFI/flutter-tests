import 'package:flutter_test/flutter_test.dart';
import './main.dart';

void main() {
  Parser ps = Parser();
  group('Only integers', () {
    test('Correct integer', () {
      expect(ps.strToInt('10'), equals(10));
    });
    test('Incorrect integer', () {
      expect(ps.strToInt('ten'), equals(-1));
    });
    test('Incorrect integer', () {
      expect(ps.strToInt('11:00'), equals(-1));
    });
    test('Incorrect integer', () {
      expect(ps.strToInt('11.5'), equals(11));
    });
    test('Signed integer', () {
      expect(ps.strToInt('-12'), equals(-12));
    });
  });
  group('Doubles', () {
    test('Correct double', () {
      expect(ps.strToInt('11.5'), equals(11.5));
    });
    test('Incorrect double', () {
      expect(ps.strToInt('ten'), equals(-1));
    });
    test('Incorrect double', () {
      expect(ps.strToInt('11:00'), equals(-1));
    });
    test('Correct integer', () {
      expect(ps.strToInt('20'), equals(20));
    });
    test('Signed double', () {
      expect(ps.strToInt('-12.5'), equals(-12.5));
    });
  });
}
