# Syllabus

Installing Flutter SDK (following documentation)

## Basic

### Hello world

#### Objective

Verify if the user correctly installed the Flutter SDK and can run tests.

#### Exercise

Make a function that returns `Hello world from Dart`

### Palindrome

#### Objective

Verify if the user can manipulate string and compose new strings

#### Exercise

Given a set of string verify if the string is a palindrome.

If the string is a palindrome return:

`Palindrome: STRING`

If the string isn't a palindrome, return:

`Not palindrome: STRING`

### Number parsing

#### Objective

Verify if the user can use try-catch blocks

#### Exercise

Given some strings return either true or false if the string is a number

### Consuming an API using Dio

#### Objective

Verify if the user can import a library, learn from documentation and use a library to execute an action

#### Exercise

Using [Dio](https://pub.dev/packages/dio) make a get petition to `https://goweather.herokuapp.com/weather/Toluca` and return a string like:

`DESCRIPTION: TEMPERATURE`

### Consuming a structured API using Dio

#### Objective

Verify if the user can create classes for received data from a structured API

#### Exercise

Using [Dio](https://pub.dev/packages/dio) make a petition to `http://numbersapi.com/NUM?json` where `NUM` is a random number. A class `Fact` must be returned where it has two attributes:

- Text: String
- Number: Integer

The [Numbers API](http://numbersapi.com/)
