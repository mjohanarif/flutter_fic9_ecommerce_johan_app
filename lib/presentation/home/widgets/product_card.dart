import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/extentions/int_ext.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/product_response_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/widgets/cart_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/product_detail/product_detail_page.dart';

import '../../../common/components/spaces.dart';
import '../../../common/constants/colors.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: data,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorName.white,
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          boxShadow: [
            BoxShadow(
              color: ColorName.black.withOpacity(0.05),
              blurRadius: 7.0,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              '${Variables.baseUrl}${data.attributes.image.data.first.attributes.url}',
              width: 170.0,
              height: 112.0,
              fit: BoxFit.contain,
            ),
            const SpaceHeight(14.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              data.attributes.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SpaceHeight(4.0),
                          Text(
                            int.parse(data.attributes.price).currencyFormatRp,
                            style: const TextStyle(
                              color: ColorName.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<CartBloc>().add(
                              CartEvent.add(
                                CartModel(product: data),
                              ),
                            );
                      },
                      child: const Icon(
                        Icons.add,
                        color: ColorName.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
