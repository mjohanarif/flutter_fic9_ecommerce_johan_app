// ignore_for_file: constant_identifier_names

import 'dart:convert';

class SubdistrictResponseModel {
  final Rajaongkir rajaongkir;

  SubdistrictResponseModel({
    required this.rajaongkir,
  });

  factory SubdistrictResponseModel.fromRawJson(String str) =>
      SubdistrictResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubdistrictResponseModel.fromJson(Map<String, dynamic> json) =>
      SubdistrictResponseModel(
        rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
      );

  Map<String, dynamic> toJson() => {
        "rajaongkir": rajaongkir.toJson(),
      };
}

class Rajaongkir {
  final Query query;
  final Status status;
  final List<Subdistrict> results;

  Rajaongkir({
    required this.query,
    required this.status,
    required this.results,
  });

  factory Rajaongkir.fromRawJson(String str) =>
      Rajaongkir.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        query: Query.fromJson(json["query"]),
        status: Status.fromJson(json["status"]),
        results: List<Subdistrict>.from(
            json["results"].map((x) => Subdistrict.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "query": query.toJson(),
        "status": status.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Query {
  final String city;

  Query({
    required this.city,
  });

  factory Query.fromRawJson(String str) => Query.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
      };
}

class Subdistrict {
  final String subdistrictId;
  final String provinceId;
  final String province;
  final String cityId;
  final String city;
  final String type;
  final String subdistrictName;

  Subdistrict({
    required this.subdistrictId,
    required this.provinceId,
    required this.province,
    required this.cityId,
    required this.city,
    required this.type,
    required this.subdistrictName,
  });

  factory Subdistrict.fromRawJson(String str) =>
      Subdistrict.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Subdistrict.fromJson(Map<String, dynamic> json) => Subdistrict(
        subdistrictId: json["subdistrict_id"],
        provinceId: json["province_id"],
        province: json["province"],
        cityId: json["city_id"],
        city: json["city"],
        type: json["type"],
        subdistrictName: json["subdistrict_name"],
      );

  Map<String, dynamic> toJson() => {
        "subdistrict_id": subdistrictId,
        "province_id": provinceId,
        "province": province,
        "city_id": cityId,
        "city": city,
        "type": type,
        "subdistrict_name": subdistrictName,
      };

  @override
  String toString() => subdistrictName;
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
