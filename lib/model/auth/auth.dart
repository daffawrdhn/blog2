// To parse this JSON data, do
//
//     final auth = authFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Auth authFromJson(String str) => Auth.fromJson(json.decode(str));

String authToJson(Auth data) => json.encode(data.toJson());

class Auth {
  Auth({
    @required this.success,
    @required this.data,
    @required this.message,
  });

  final bool success;
  final Data data;
  final String message;


  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };

}

class Data {
  Data({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.token,
  });

  final int id;
  final String name;
  final String email;
  final String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "token": token,
      };
}
