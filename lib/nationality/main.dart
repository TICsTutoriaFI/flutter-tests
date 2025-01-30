class User {
  String name;
  int age;

  User({required this.name, required this.age});

  String getNationality() {
    throw UnimplementedError();
  }
}
