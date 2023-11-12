import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/spaces.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/colors.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/extentions/int_ext.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/product_response_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/widgets/cart_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/product_detail/product_detail_page.dart';

class ProductSearchCard extends StatelessWidget {
  final Product data;
  const ProductSearchCard({
    Key? key,
    required this.data,
  }) : super(key: key);

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
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: ColorName.black.withOpacity(0.05),
              blurRadius: 7.0,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(16)),
              child: Image.network(
                '${Variables.baseUrl}${data.attributes.image.data.first.attributes.url}',
                height: 120.0,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.attributes.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SpaceHeight(4.0),
                    Text(
                      data.attributes.description,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<CartBloc>().add(
                                  CartEvent.remove(
                                    CartModel(product: data),
                                  ),
                                );
                          },
                          child: const Icon(Icons.remove),
                        ),
                        const SpaceWidth(8),
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
