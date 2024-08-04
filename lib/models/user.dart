// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? role;
  // String? token;
  // String? createdAt;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.role,
    // this.token,
    // this.createdAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    // // token = json['token'];
    // createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    // data['token'] = token;
    // data['createdAt'] = createdAt;
    return data;
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }
}
