import 'dart:convert';

class ProvinceResponseModel {
  final Rajaongkir rajaongkir;

  ProvinceResponseModel({
    required this.rajaongkir,
  });

  factory ProvinceResponseModel.fromRawJson(String str) =>
      ProvinceResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProvinceResponseModel.fromJson(Map<String, dynamic> json) =>
      ProvinceResponseModel(
        rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
      );

  Map<String, dynamic> toJson() => {
        "rajaongkir": rajaongkir.toJson(),
      };
}

class Rajaongkir {
  final List<dynamic> query;
  final Status status;
  final List<Province> results;

  Rajaongkir({
    required this.query,
    required this.status,
    required this.results,
  });

  factory Rajaongkir.fromRawJson(String str) =>
      Rajaongkir.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        query: List<dynamic>.from(json["query"].map((x) => x)),
        status: Status.fromJson(json["status"]),
        results: List<Province>.from(
            json["results"].map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "query": List<dynamic>.from(query.map((x) => x)),
        "status": status.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Province {
  final String provinceId;
  final String province;

  Province({
    required this.provinceId,
    required this.province,
  });

  factory Province.fromRawJson(String str) =>
      Province.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        provinceId: json["province_id"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province": province,
      };

  @override
  String toString() => province;
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
