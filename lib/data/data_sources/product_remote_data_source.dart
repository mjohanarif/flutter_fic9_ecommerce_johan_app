import 'package:dartz/dartz.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDataSource {
  Future<Either<String, ProductResponseModel>> getAllProduct() async {
    final response = await http
        .get(Uri.parse('${Variables.baseUrl}/api/products?populate=*'));

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromRawJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}
