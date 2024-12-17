class Role {
  final String name;

  Role({required this.name});

  // Méthode pour convertir un objet JSON en instance de Role
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      name: json['name'],
    );
  }

  // Méthode pour convertir une instance de Role en objet JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  static empTyRole() {
    return Role(name: "");
  }
}
