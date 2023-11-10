import 'package:flutter_fic9_ecommerce_johan_app/common/extentions/int_ext.dart';

class OrderProductModel {
  final String imagePath;
  final String name;
  final int price;

  const OrderProductModel({
    required this.imagePath,
    required this.name,
    required this.price,
  });

  String get priceFormat => price.currencyFormatRp;
}
