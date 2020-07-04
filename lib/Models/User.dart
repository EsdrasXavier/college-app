class User {
  final int userId;
  final String userName;
  final String token;

  User({this.userId, this.userName, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      userName: json['user_name'],
      token: json['token'],
    );
  }
}
