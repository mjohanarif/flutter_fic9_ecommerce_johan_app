import 'package:dartz/dartz.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/requests/order_request_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/order_detail_response_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/order_response_model.dart';
import 'package:http/http.dart' as http;

class OrderRemoteDataSource {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel request) async {
    final token = await AuthLocalDataSource().getToken();

    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(
        OrderResponseModel.fromRawJson(response.body),
      );
    } else {
      return Left(
        'Status code:${response.statusCode}, ${response.reasonPhrase}',
      );
    }
  }

  Future<Either<String, OrderDetailResponseModel>> getOrderById(
      String id) async {
    final token = await AuthLocalDataSource().getToken();

    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/orders/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Right(
        OrderDetailResponseModel.fromJson(response.body),
      );
    } else {
      return Left(
        'Status code:${response.statusCode}, ${response.reasonPhrase}',
      );
    }
  }
}
