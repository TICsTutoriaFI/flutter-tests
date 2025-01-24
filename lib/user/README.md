# Process the name of an user

A lot of apps require either a username or the real name of the user, in some countries people have two surnames or just one, you need to ensure that you are prepared for everything.

## Instructions

Modify the `User` class in a way that it includes the following attributes:

- `name`
- `firstSurname`
- `secondSurname`

Then, make a constructor where the attribute `secondSurname` is optional but still accessible if needed (use null safety features) [check constructors](https://dart.dev/language/constructors#instance-variable-initialization). So it can be called:

```dart
User user = User(name: "John", firstSurname: "Doe");
// Or 
User user2 = User(name: "Jane", firstSurname: "Doe", secondSurname: "Roe");
```

Finally override the `toString` method in a way that if called it returns the name composed like:

`<Name> <firstSurname> {secondSurname}`

Only show `secondSurname` if is not null
