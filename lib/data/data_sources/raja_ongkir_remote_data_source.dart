import 'package:dartz/dartz.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/city_response_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/const_response_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/province_response_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/subdistrict_response_model.dart';
import 'package:http/http.dart' as http;

class RajaOngkirRemoteDataSource {
  Future<Either<String, ProvinceResponseModel>> getProvince() async {
    final url = Uri.parse('https://pro.rajaongkir.com/api/province');

    final response = await http.get(
      url,
      headers: {
        'key': Variables.rajaongkirKey,
      },
    );
    if (response.statusCode == 200) {
      return Right(
        ProvinceResponseModel.fromRawJson(
          response.body,
        ),
      );
    } else {
      return Left(
        '${response.statusCode.toString()},${response.reasonPhrase}',
      );
    }
  }

  Future<Either<String, CityResponseModel>> getCity(String provinceId) async {
    final url =
        Uri.parse('https://pro.rajaongkir.com/api/city?province=$provinceId');

    final response = await http.get(
      url,
      headers: {
        'key': Variables.rajaongkirKey,
      },
    );
    if (response.statusCode == 200) {
      return Right(
        CityResponseModel.fromRawJson(
          response.body,
        ),
      );
    } else {
      return Left(
        '${response.statusCode.toString()},${response.reasonPhrase}',
      );
    }
  }

  Future<Either<String, SubdistrictResponseModel>> getSubdistrict(
      String cityId) async {
    final url =
        Uri.parse('https://pro.rajaongkir.com/api/subdistrict?city=$cityId');

    final response = await http.get(
      url,
      headers: {
        'key': Variables.rajaongkirKey,
      },
    );
    if (response.statusCode == 200) {
      return Right(
        SubdistrictResponseModel.fromRawJson(
          response.body,
        ),
      );
    } else {
      return Left(
        '${response.statusCode.toString()},${response.reasonPhrase}',
      );
    }
  }

  Future<Either<String, CostResponseModel>> getCost(
    String destination,
    String courier,
    String origin,
  ) async {
    final url = Uri.parse('https://pro.rajaongkir.com/api/cost');
    final response = await http.post(
      url,
      headers: {
        'key': Variables.rajaongkirKey,
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'origin': origin,
        'originType': 'subdistrict',
        'destination': destination,
        'destinationType': 'subdistrict',
        'weight': '500',
        'courier': courier,
      },
    );

    if (response.statusCode == 200) {
      return Right(
        CostResponseModel.fromRawJson(response.body),
      );
    } else {
      return const Left('Error');
    }
  }
}
