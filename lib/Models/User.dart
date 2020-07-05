class User {
  final int userId;
  final String userName;
  final String token;
  final String createdAt;

  User({this.userId, this.userName, this.token, this.createdAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['id'],
        userName: json['name'],
        token: json['token'],
        createdAt: json['createdAt']);
  }
}
