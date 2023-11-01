import 'package:flutter_fic9_ecommerce_johan_app/common/extentions/int_ext.dart';

class ProductModel {
  final List<String> images;
  final String name;
  final int price;

  const ProductModel({
    required this.images,
    required this.name,
    required this.price,
  });

  String get priceFormat => price.currencyFormatRp;
}
