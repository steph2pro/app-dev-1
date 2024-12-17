import 'package:crush_app/src/datasource/models/user/role.model.dart';

class UserModel {
  final String id;
  final String? email;
  final String username;
  final String userChatId;
  final String? name;
  final String lang;
  final DateTime dob;
  final bool emailVerified;
  final String phone;
  final bool isDelete;
  final bool profileComplete;
  final bool lock;
  final String roleId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? chatId;
  final Role role;
  final String accessToken;

  UserModel({
    required this.id,
    this.email,
    required this.username,
    required this.userChatId,
    this.name,
    required this.lang,
    required this.dob,
    required this.emailVerified,
    required this.phone,
    required this.isDelete,
    required this.profileComplete,
    required this.lock,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
    this.chatId,
    required this.role,
    required this.accessToken,
  });

  // Méthode pour convertir un objet JSON en instance de UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      name: json['name'],
      userChatId: json['userChatId'],
      lang: json['lang'],
      dob: DateTime.parse(json['dob']),
      emailVerified: json['emailVerified'],
      phone: json['phone'],
      isDelete: json['isDelete'],
      profileComplete: json['profileComplete'],
      lock: json['lock'],
      roleId: json['roleId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      chatId: json['chatId'],
      role: Role.fromJson(json['role']),
      accessToken: json['access_token'],
    );
  }

  // Méthode pour convertir une instance de UserModel en objet JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'name': name,
      'userChatId': userChatId,
      'lang': lang,
      'dob': dob.toIso8601String(),
      'emailVerified': emailVerified,
      'phone': phone,
      'isDelete': isDelete,
      'profileComplete': profileComplete,
      'lock': lock,
      'roleId': roleId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'chatId': chatId,
      'role': role.toJson(),
      'access_token': accessToken,
    };
  }

  Map<String, dynamic> toJson2(UserModel data) {
    return {
      'id': data.id,
      'email': data.email,
      'username': data.username,
      'name': data.name,
      'userChatId': data.userChatId,
      'lang': lang,
      'dob': data.dob.toIso8601String(),
      'emailVerified': data.emailVerified,
      'phone': data.phone,
      'isDelete': data.isDelete,
      'profileComplete': data.profileComplete,
      'lock': data.lock,
      'roleId': data.roleId,
      'createdAt': data.createdAt.toIso8601String(),
      'updatedAt': data.updatedAt.toIso8601String(),
      'chatId': data.chatId,
      'role': data.role.toJson(),
      'access_token': data.accessToken,
    };
  }

  // Méthode statique pour créer un utilisateur avec des valeurs par défaut
  static UserModel empty() {
    return UserModel(
      id: '',
      email: null,
      username: '',
      name: null,
      userChatId: '',
      lang: 'en',
      dob: DateTime.now(),
      emailVerified: false,
      phone: '',
      isDelete: false,
      profileComplete: false,
      lock: false,
      roleId: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      chatId: null,
      role: Role
          .empTyRole(), // Assurez-vous que Role a également une méthode vide
      accessToken: '',
    );
  }
}
