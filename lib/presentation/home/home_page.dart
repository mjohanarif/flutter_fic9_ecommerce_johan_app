import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_fic9_ecommerce_johan_app/common/components/search_input.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/spaces.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/colors.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/images.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/cart_page.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/home/bloc/search_product/search_product_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/home/widgets/product_list_section.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/home/widgets/product_search_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      Images.recomendedProductBanner,
      Images.recomendedProductBanner,
      Images.recomendedProductBanner,
    ];

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(20.0),
          Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alamat Pengiriman",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: ColorName.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Sleman, DI Yogyakarta",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorName.primary,
                        ),
                      ),
                      SpaceWidth(5.0),
                      Icon(
                        Icons.expand_more,
                        size: 18.0,
                        color: ColorName.primary,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartPage(),
                                ),
                              );
                            },
                            icon: Image.asset(
                              Images.iconBuy,
                              height: 24.0,
                            ),
                          );
                        },
                        loaded: (carts) {
                          int quantity = 0;
                          for (var cart in carts) {
                            quantity += cart.quantity;
                          }
                          if (quantity == 0) {
                            return IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartPage(),
                                  ),
                                );
                              },
                              icon: Image.asset(
                                Images.iconBuy,
                                height: 24.0,
                              ),
                            );
                          }
                          return badges.Badge(
                            badgeContent: Text(
                              quantity.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            badgeStyle: const badges.BadgeStyle(
                              badgeColor: Colors.red,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartPage(),
                                  ),
                                );
                              },
                              icon: Image.asset(
                                Images.iconBuy,
                                height: 24.0,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        Images.iconNotificationHome,
                        height: 24.0,
                      )),
                ],
              ),
            ],
          ),
          const SpaceHeight(16.0),
          SearchInput(
            controller: searchController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                context.read<SearchProductBloc>().add(
                      SearchProductEvent.searchProduct(value),
                    );
              }
              setState(() {});
            },
          ),
          const SpaceHeight(16.0),
          if (searchController.text.isEmpty) ...[
            ProductListSection(images: images),
          ] else ...[
            const ProductSearchSection(),
          ]
        ],
      ),
    );
  }
}
