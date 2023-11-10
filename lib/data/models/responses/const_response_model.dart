import 'dart:convert';

class CostResponseModel {
  final Rajaongkir rajaongkir;

  CostResponseModel({
    required this.rajaongkir,
  });

  factory CostResponseModel.fromRawJson(String str) =>
      CostResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CostResponseModel.fromJson(Map<String, dynamic> json) =>
      CostResponseModel(
        rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
      );

  Map<String, dynamic> toJson() => {
        "rajaongkir": rajaongkir.toJson(),
      };
}

class Rajaongkir {
  final Query query;
  final Status status;
  final NDetails originDetails;
  final NDetails destinationDetails;
  final List<Result> results;

  Rajaongkir({
    required this.query,
    required this.status,
    required this.originDetails,
    required this.destinationDetails,
    required this.results,
  });

  factory Rajaongkir.fromRawJson(String str) =>
      Rajaongkir.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        query: Query.fromJson(json["query"]),
        status: Status.fromJson(json["status"]),
        originDetails: NDetails.fromJson(json["origin_details"]),
        destinationDetails: NDetails.fromJson(json["destination_details"]),
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "query": query.toJson(),
        "status": status.toJson(),
        "origin_details": originDetails.toJson(),
        "destination_details": destinationDetails.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class NDetails {
  final String subdistrictId;
  final String provinceId;
  final String province;
  final String cityId;
  final String city;
  final String type;
  final String subdistrictName;

  NDetails({
    required this.subdistrictId,
    required this.provinceId,
    required this.province,
    required this.cityId,
    required this.city,
    required this.type,
    required this.subdistrictName,
  });

  factory NDetails.fromRawJson(String str) =>
      NDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NDetails.fromJson(Map<String, dynamic> json) => NDetails(
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
}

class Query {
  final String origin;
  final String originType;
  final String destination;
  final String destinationType;
  final int weight;
  final String courier;

  Query({
    required this.origin,
    required this.originType,
    required this.destination,
    required this.destinationType,
    required this.weight,
    required this.courier,
  });

  factory Query.fromRawJson(String str) => Query.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        origin: json["origin"],
        originType: json["originType"],
        destination: json["destination"],
        destinationType: json["destinationType"],
        weight: json["weight"],
        courier: json["courier"],
      );

  Map<String, dynamic> toJson() => {
        "origin": origin,
        "originType": originType,
        "destination": destination,
        "destinationType": destinationType,
        "weight": weight,
        "courier": courier,
      };
}

class Result {
  final String code;
  final String name;
  final List<ResultCost> costs;

  Result({
    required this.code,
    required this.name,
    required this.costs,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"],
        name: json["name"],
        costs: List<ResultCost>.from(
            json["costs"].map((x) => ResultCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": List<dynamic>.from(costs.map((x) => x.toJson())),
      };
}

class ResultCost {
  final String service;
  final String description;
  final List<CostCost> cost;

  ResultCost({
    required this.service,
    required this.description,
    required this.cost,
  });

  factory ResultCost.fromRawJson(String str) =>
      ResultCost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultCost.fromJson(Map<String, dynamic> json) => ResultCost(
        service: json["service"],
        description: json["description"],
        cost:
            List<CostCost>.from(json["cost"].map((x) => CostCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": List<dynamic>.from(cost.map((x) => x.toJson())),
      };
}

class CostCost {
  final int value;
  final String etd;
  final String note;

  CostCost({
    required this.value,
    required this.etd,
    required this.note,
  });

  factory CostCost.fromRawJson(String str) =>
      CostCost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CostCost.fromJson(Map<String, dynamic> json) => CostCost(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
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
