import 'dart:convert';

class AddAddressRequestModel {
  final AddAddress data;

  AddAddressRequestModel({
    required this.data,
  });

  factory AddAddressRequestModel.fromRawJson(String str) =>
      AddAddressRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddAddressRequestModel.fromJson(Map<String, dynamic> json) =>
      AddAddressRequestModel(
        data: AddAddress.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class AddAddress {
  final String name;
  final String address;
  final String phone;
  final String provId;
  final String cityId;
  final String subdistrictId;
  final String codePos;
  final String userId;
  final bool isDefault;

  AddAddress({
    required this.name,
    required this.address,
    required this.phone,
    required this.provId,
    required this.cityId,
    required this.subdistrictId,
    required this.codePos,
    required this.userId,
    required this.isDefault,
  });

  factory AddAddress.fromRawJson(String str) =>
      AddAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddAddress.fromJson(Map<String, dynamic> json) => AddAddress(
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        provId: json["prov_id"],
        cityId: json["city_id"],
        subdistrictId: json["subdistrict_id"],
        codePos: json["code_pos"],
        userId: json["user_id"],
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
        "is_default": isDefault,
      };
}
