class UserChat {
  final String id;
  final String username;

  UserChat({required this.id, required this.username});

  // Méthode pour convertir un objet JSON en instance de Role
  factory UserChat.fromJson(Map<String, dynamic> json) {
    return UserChat(
      id: json['id'],
      username: json['username'],
    );
  }

  // Méthode pour convertir une instance de Role en objet JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
    };
  }

  static empTyRole() {
    return UserChat(id: '', username: '');
  }
}
