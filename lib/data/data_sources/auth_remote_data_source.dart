import 'package:dartz/dartz.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/requests/login_requests_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/requests/register_requests_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel data) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/auth/local/register'),
      body: data.toJson(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(
        AuthResponseModel.fromJson(
          response.body,
        ),
      );
    } else {
      return const Left(
        'Server Error',
      );
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel data) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/auth/local'),
      body: data.toJson(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(
        AuthResponseModel.fromJson(
          response.body,
        ),
      );
    } else {
      return const Left(
        'Server Error',
      );
    }
  }
}
