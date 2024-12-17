class Participant {
  final String id;
  final String username;

  Participant({
    required this.id,
    required this.username,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      username: json['username'],
    );
  }
  static Participant empty() {
    return Participant(
      id: '',
      username: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
    };
  }
}
