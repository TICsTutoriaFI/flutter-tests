import 'package:flutter_test/flutter_test.dart';
import './main.dart';

void main() {
  group('Single words', () {
    test('Normal word', () {
      expect(isPalindrome('anna'), equals(true));
    });
    test('Normal word', () {
      expect(isPalindrome('felix'), equals(false));
    });
    test('Word with alternating capitals', () {
      expect(isPalindrome('KaYak'), equals(true));
    });
    test('Word with alternating capitals', () {
      expect(isPalindrome('feRReTs'), equals(false));
    });
  }, skip: false);

  group('Multiple words', () {
    test('Normal phrase', () {
      expect(isPalindrome('taco cat'), equals(true));
    });
    test('Normal phrase', () {
      expect(isPalindrome('dog food'), equals(false));
    });
    test('Phrase with upper case', () {
      expect(isPalindrome('Top Spot'), equals(true));
    });
    test('Phrase with upper case', () {
      expect(isPalindrome('My Mom Sleep'), equals(false));
    });
  }, skip: true);
}
