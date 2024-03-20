// To parse this JSON data, do
//
//     final modelPegawai = modelPegawaiFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

ModelPegawai modelPegawaiFromJson(String str) =>
    ModelPegawai.fromJson(json.decode(str));

String modelPegawaiToJson(ModelPegawai data) => json.encode(data.toJson());

class ModelPegawai {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelPegawai({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelPegawai.fromJson(Map<String, dynamic> json) => ModelPegawai(
        isSuccess: json["isSuccess"] == 1,
        message: json["message"] ?? "",
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String nama;
  String noBp;
  String noTelp;
  String email;
  DateTime tglInput;

  Datum({
    required this.id,
    required this.nama,
    required this.noBp,
    required this.noTelp,
    required this.email,
    required this.tglInput,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nama: json["nama"],
        noBp: json["no_bp"],
        noTelp: json["no_telp"],
        email: json["email"],
        tglInput: json["tgl_input"] != null
            ? DateTime.parse(json["tgl_input"])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "no_bp": noBp,
        "no_telp": noTelp,
        "email": email,
        "tgl_input": DateFormat('yyyy-MM-dd HH:mm:ss').format(tglInput),
      };
}
