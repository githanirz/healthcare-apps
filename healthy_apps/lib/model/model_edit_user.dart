// To parse this JSON data, do
//
//     final modelEditUser = modelEditUserFromJson(jsonString);

import 'dart:convert';

ModelEditUser modelEditUserFromJson(String str) =>
    ModelEditUser.fromJson(json.decode(str));

String modelEditUserToJson(ModelEditUser data) => json.encode(data.toJson());

class ModelEditUser {
  bool isSuccess;
  int value;
  String message;
  String username;
  String id;

  ModelEditUser({
    required this.isSuccess,
    required this.value,
    required this.message,
    required this.username,
    required this.id,
  });

  factory ModelEditUser.fromJson(Map<String, dynamic> json) => ModelEditUser(
        isSuccess: json["isSuccess"],
        value: json["value"],
        message: json["message"],
        username: json["username"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "value": value,
        "message": message,
        "username": username,
        "id": id,
      };
}
