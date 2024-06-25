import 'dart:convert';

UsersModel usersModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));
String userModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  UsersModel({
    this.uid,
    this.name,
    this.email,
    this.creationTime,
    this.lastSignInTime,
    this.photoUrl,
    this.status,
    this.updatedTime,
  });

  String? uid;
  String? name;
  String? email;
  String? creationTime;
  String? lastSignInTime;
  String? photoUrl;
  String? status;
  String? updatedTime;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      creationTime: json['creationTime'],
      lastSignInTime: json['lastSignInTime'],
      photoUrl: json['photoUrl'],
      status: json['status'],
      updatedTime: json['updatedTime']);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'creationTime': creationTime,
        'lastSignInTime': lastSignInTime,
        'photoUrl': photoUrl,
        'status': status,
        'updatedTime': updatedTime,
      };
}

class ChatUser {
  ChatUser({
    this.connection,
    this.chatId,
    this.lastTime,
    this.total_unread,
  });

  String? connection;
  String? chatId;
  String? lastTime;
  int? total_unread;

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        connection: json['connection'],
        chatId: json['chatId'],
        lastTime: json['lastTime'],
        total_unread: json['total_unread'],
      );

  Map<String, dynamic> toJson() => {
        "connection": connection,
        "chat_id": chatId,
        "lastTime": lastTime,
        "total_unread": total_unread,
      };
}
