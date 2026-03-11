class User {
  int? id;
  String name;
  String birthday;

  User({
    this.id,
    required this.name,
    required this.birthday,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'birthday': birthday,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      name: map['name'] as String,
      birthday: map['birthday'] as String,
    );
  }
}
