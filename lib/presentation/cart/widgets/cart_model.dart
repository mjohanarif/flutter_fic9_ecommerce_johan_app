import 'package:flutter_fic9_ecommerce_johan_app/common/extentions/string_ext.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/product_response_model.dart';

class CartModel {
  final Product product;
  int quantity;

  CartModel({
    required this.product,
    this.quantity = 1,
  });

  String get priceFormat => product.attributes.price.currencyFormatRp;
}
