import 'dart:convert';

class WaybillSuccessResponseModel {
  final Rajaongkir rajaongkir;

  WaybillSuccessResponseModel({
    required this.rajaongkir,
  });

  factory WaybillSuccessResponseModel.fromRawJson(String str) =>
      WaybillSuccessResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WaybillSuccessResponseModel.fromJson(Map<String, dynamic> json) =>
      WaybillSuccessResponseModel(
        rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
      );

  Map<String, dynamic> toJson() => {
        "rajaongkir": rajaongkir.toJson(),
      };
}

class Rajaongkir {
  final Query query;
  final Status status;
  final Result result;

  Rajaongkir({
    required this.query,
    required this.status,
    required this.result,
  });

  factory Rajaongkir.fromRawJson(String str) =>
      Rajaongkir.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        query: Query.fromJson(json["query"]),
        status: Status.fromJson(json["status"]),
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "query": query.toJson(),
        "status": status.toJson(),
        "result": result.toJson(),
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

class Result {
  final bool delivered;
  final Summary summary;
  final Details details;
  final List<Manifest> manifest;
  final DeliveryStatus deliveryStatus;

  Result({
    required this.delivered,
    required this.summary,
    required this.details,
    required this.manifest,
    required this.deliveryStatus,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        delivered: json["delivered"],
        summary: Summary.fromJson(json["summary"]),
        details: Details.fromJson(json["details"]),
        manifest: List<Manifest>.from(
            json["manifest"].map((x) => Manifest.fromJson(x))),
        deliveryStatus: DeliveryStatus.fromJson(json["delivery_status"]),
      );

  Map<String, dynamic> toJson() => {
        "delivered": delivered,
        "summary": summary.toJson(),
        "details": details.toJson(),
        "manifest": List<dynamic>.from(manifest.map((x) => x.toJson())),
        "delivery_status": deliveryStatus.toJson(),
      };
}

class DeliveryStatus {
  final String status;
  final String podReceiver;
  final DateTime podDate;
  final String podTime;

  DeliveryStatus({
    required this.status,
    required this.podReceiver,
    required this.podDate,
    required this.podTime,
  });

  factory DeliveryStatus.fromRawJson(String str) =>
      DeliveryStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryStatus.fromJson(Map<String, dynamic> json) => DeliveryStatus(
        status: json["status"],
        podReceiver: json["pod_receiver"],
        podDate: DateTime.parse(json["pod_date"]),
        podTime: json["pod_time"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "pod_receiver": podReceiver,
        "pod_date":
            "${podDate.year.toString().padLeft(4, '0')}-${podDate.month.toString().padLeft(2, '0')}-${podDate.day.toString().padLeft(2, '0')}",
        "pod_time": podTime,
      };
}

class Details {
  final String waybillNumber;
  final DateTime waybillDate;
  final String waybillTime;
  final double weight;
  final String origin;
  final String destination;
  final String shippperName;
  final String shipperAddress1;
  final String shipperAddress2;
  final String shipperAddress3;
  final String shipperCity;
  final String receiverName;
  final String receiverAddress1;
  final String receiverAddress2;
  final String receiverAddress3;
  final String receiverCity;

  Details({
    required this.waybillNumber,
    required this.waybillDate,
    required this.waybillTime,
    required this.weight,
    required this.origin,
    required this.destination,
    required this.shippperName,
    required this.shipperAddress1,
    required this.shipperAddress2,
    required this.shipperAddress3,
    required this.shipperCity,
    required this.receiverName,
    required this.receiverAddress1,
    required this.receiverAddress2,
    required this.receiverAddress3,
    required this.receiverCity,
  });

  factory Details.fromRawJson(String str) => Details.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        waybillNumber: json["waybill_number"],
        waybillDate: DateTime.parse(json["waybill_date"]),
        waybillTime: json["waybill_time"],
        weight: json["weight"]?.toDouble(),
        origin: json["origin"],
        destination: json["destination"],
        shippperName: json["shippper_name"],
        shipperAddress1: json["shipper_address1"],
        shipperAddress2: json["shipper_address2"],
        shipperAddress3: json["shipper_address3"],
        shipperCity: json["shipper_city"],
        receiverName: json["receiver_name"],
        receiverAddress1: json["receiver_address1"],
        receiverAddress2: json["receiver_address2"],
        receiverAddress3: json["receiver_address3"],
        receiverCity: json["receiver_city"],
      );

  Map<String, dynamic> toJson() => {
        "waybill_number": waybillNumber,
        "waybill_date":
            "${waybillDate.year.toString().padLeft(4, '0')}-${waybillDate.month.toString().padLeft(2, '0')}-${waybillDate.day.toString().padLeft(2, '0')}",
        "waybill_time": waybillTime,
        "weight": weight,
        "origin": origin,
        "destination": destination,
        "shippper_name": shippperName,
        "shipper_address1": shipperAddress1,
        "shipper_address2": shipperAddress2,
        "shipper_address3": shipperAddress3,
        "shipper_city": shipperCity,
        "receiver_name": receiverName,
        "receiver_address1": receiverAddress1,
        "receiver_address2": receiverAddress2,
        "receiver_address3": receiverAddress3,
        "receiver_city": receiverCity,
      };
}

class Manifest {
  final String manifestCode;
  final String manifestDescription;
  final DateTime manifestDate;
  final String manifestTime;
  final String cityName;

  Manifest({
    required this.manifestCode,
    required this.manifestDescription,
    required this.manifestDate,
    required this.manifestTime,
    required this.cityName,
  });

  factory Manifest.fromRawJson(String str) =>
      Manifest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Manifest.fromJson(Map<String, dynamic> json) => Manifest(
        manifestCode: json["manifest_code"] ?? '',
        manifestDescription: json["manifest_description"],
        manifestDate: DateTime.parse(json["manifest_date"]),
        manifestTime: json["manifest_time"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "manifest_code": manifestCode,
        "manifest_description": manifestDescription,
        "manifest_date":
            "${manifestDate.year.toString().padLeft(4, '0')}-${manifestDate.month.toString().padLeft(2, '0')}-${manifestDate.day.toString().padLeft(2, '0')}",
        "manifest_time": manifestTime,
        "city_name": cityName,
      };
}

class Summary {
  final String courierCode;
  final String courierName;
  final String waybillNumber;
  final String serviceCode;
  final DateTime waybillDate;
  final String shipperName;
  final String receiverName;
  final String origin;
  final String destination;
  final String status;

  Summary({
    required this.courierCode,
    required this.courierName,
    required this.waybillNumber,
    required this.serviceCode,
    required this.waybillDate,
    required this.shipperName,
    required this.receiverName,
    required this.origin,
    required this.destination,
    required this.status,
  });

  factory Summary.fromRawJson(String str) => Summary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        courierCode: json["courier_code"],
        courierName: json["courier_name"],
        waybillNumber: json["waybill_number"],
        serviceCode: json["service_code"],
        waybillDate: DateTime.parse(json["waybill_date"]),
        shipperName: json["shipper_name"],
        receiverName: json["receiver_name"],
        origin: json["origin"],
        destination: json["destination"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "courier_code": courierCode,
        "courier_name": courierName,
        "waybill_number": waybillNumber,
        "service_code": serviceCode,
        "waybill_date":
            "${waybillDate.year.toString().padLeft(4, '0')}-${waybillDate.month.toString().padLeft(2, '0')}-${waybillDate.day.toString().padLeft(2, '0')}",
        "shipper_name": shipperName,
        "receiver_name": receiverName,
        "origin": origin,
        "destination": destination,
        "status": status,
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
