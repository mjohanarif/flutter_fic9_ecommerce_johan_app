import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/spaces.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/colors.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/images.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/home/bloc/products/products_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/home/widgets/category_button.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/home/widgets/image_slider.dart';

import 'product_card.dart';

class ProductListSection extends StatelessWidget {
  const ProductListSection({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageSlider(items: images),
        const SpaceHeight(12.0),
        const Text(
          "Kategori",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: ColorName.primary,
          ),
        ),
        const SpaceHeight(12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CategoryButton(
                imagePath: Images.fashion1,
                label: 'Pakaian',
                onPressed: () {},
              ),
            ),
            Flexible(
              child: CategoryButton(
                imagePath: Images.fashion2,
                label: 'Pakaian',
                onPressed: () {},
              ),
            ),
            Flexible(
              child: CategoryButton(
                imagePath: Images.fashion3,
                label: 'Pakaian',
                onPressed: () {},
              ),
            ),
            Flexible(
              child: CategoryButton(
                imagePath: Images.more,
                label: 'Pakaian',
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SpaceHeight(16.0),
        const Text(
          "Produk",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: ColorName.primary,
          ),
        ),
        const SpaceHeight(8.0),
        BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              loaded: (data) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 55.0,
                  ),
                  itemCount: data.data.length,
                  itemBuilder: (context, index) => ProductCard(
                    data: data.data[index],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
