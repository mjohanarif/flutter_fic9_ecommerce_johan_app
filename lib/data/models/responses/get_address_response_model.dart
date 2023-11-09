import 'dart:convert';

class GetAddressResponseModel {
  final List<GetAddress> data;
  final Meta meta;

  GetAddressResponseModel({
    required this.data,
    required this.meta,
  });

  factory GetAddressResponseModel.fromRawJson(String str) =>
      GetAddressResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAddressResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAddressResponseModel(
        data: List<GetAddress>.from(
            json["data"].map((x) => GetAddress.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class GetAddress {
  final int id;
  final Attributes attributes;

  GetAddress({
    required this.id,
    required this.attributes,
  });

  factory GetAddress.fromRawJson(String str) =>
      GetAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAddress.fromJson(Map<String, dynamic> json) => GetAddress(
        id: json["id"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  final String name;
  final String address;
  final String phone;
  final String provId;
  final String cityId;
  final String subdistrictId;
  final String codePos;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final bool isDefault;

  Attributes({
    required this.name,
    required this.address,
    required this.phone,
    required this.provId,
    required this.cityId,
    required this.subdistrictId,
    required this.codePos,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.isDefault,
  });

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        provId: json["prov_id"],
        cityId: json["city_id"],
        subdistrictId: json["subdistrict_id"],
        codePos: json["code_pos"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        isDefault: json["is_default"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "phone": phone,
        "prov_id": provId,
        "city_id": cityId,
        "subdistrict_id": subdistrictId,
        "code_pos": codePos,
        "user_id": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "is_default": isDefault,
      };
}

class Meta {
  final Pagination pagination;

  Meta({
    required this.pagination,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
      };
}
