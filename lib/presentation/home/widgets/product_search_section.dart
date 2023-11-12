import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/spaces.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/home/bloc/search_product/search_product_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/home/widgets/product_search_card.dart';

class ProductSearchSection extends StatelessWidget {
  const ProductSearchSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchProductBloc, SearchProductState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (message) {
            return Text(message);
          },
          loaded: (response) {
            return ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 0),
              separatorBuilder: (context, index) {
                return const SpaceHeight(8);
              },
              itemBuilder: (context, index) => ProductSearchCard(
                data: response.data[index],
              ),
              itemCount: response.data.length,
            );
          },
        );
      },
    );
  }
}
