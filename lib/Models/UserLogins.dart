class UserLogins {
  UserLogins(
    this.id,
    this.user_id,
    this.created_at,
    this.updated_at,
  );
  int id;
  int user_id;
  DateTime created_at;
  DateTime updated_at;

  factory UserLogins.fromJson(dynamic json) {
    return UserLogins(
      json['id'] as int,
      json['user_id'] as int,
      DateTime.parse(json['created_at']),
      DateTime.parse(json['updated_at']),
    );
  }

  @override
  String toString() {
    return '{${this.id},${this.user_id},${this.created_at},${this.updated_at}}';
  }
}
