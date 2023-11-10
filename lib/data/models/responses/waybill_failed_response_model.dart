import 'dart:convert';

class WaybillFailedResponseModel {
  final Rajaongkir rajaongkir;

  WaybillFailedResponseModel({
    required this.rajaongkir,
  });

  factory WaybillFailedResponseModel.fromRawJson(String str) =>
      WaybillFailedResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WaybillFailedResponseModel.fromJson(Map<String, dynamic> json) =>
      WaybillFailedResponseModel(
        rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
      );

  Map<String, dynamic> toJson() => {
        "rajaongkir": rajaongkir.toJson(),
      };
}

class Rajaongkir {
  final Query? query;
  final Status status;
  final dynamic result;

  Rajaongkir({
    required this.query,
    required this.status,
    required this.result,
  });

  factory Rajaongkir.fromRawJson(String str) =>
      Rajaongkir.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        query: json["query"] != null ? Query.fromJson(json["query"]) : null,
        status: Status.fromJson(json["status"]),
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "query": query?.toJson(),
        "status": status.toJson(),
        "result": result,
      };
}

class Query {
  final String waybill;
  final String courier;

  Query({
    required this.waybill,
    required this.courier,
  });

  factory Query.fromRawJson(String str) => Query.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        waybill: json["waybill"],
        courier: json["courier"],
      );

  Map<String, dynamic> toJson() => {
        "waybill": waybill,
        "courier": courier,
      };
}

class Status {
  final int code;
  final String description;

  Status({
    required this.code,
    required this.description,
  });

  factory Status.fromRawJson(String str) => Status.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };
}
