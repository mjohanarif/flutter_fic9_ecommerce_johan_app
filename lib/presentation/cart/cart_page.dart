import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/custom_dropdown.dart';

import 'package:flutter_fic9_ecommerce_johan_app/common/components/row_text.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/spaces.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/extentions/int_ext.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/requests/order_request_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/bloc/get_cost/get_cost_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/bloc/order/order_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/models/courier.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/widgets/cart_item_widget.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/payment/payment_page.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/bloc/get_address/get_address_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/shipping_address_page.dart';

import '../../common/components/button.dart';
import '../../common/constants/colors.dart';
import 'bloc/cart/cart_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int? idAddress;
  @override
  void initState() {
    context.read<GetAddressBloc>().add(
          const GetAddressEvent.getAddressByUserId(),
        );
    super.initState();
  }

  List<Item> items = [];
  int totalPrices = 0;
  int courierPrice = 0;
  String courierName = 'jne';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loaded: (carts) {
              if (carts.isEmpty) {
                return const Center(
                  child: Text('Keranjang kosong'),
                );
              } else {
                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          loaded: (carts) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SpaceHeight(16.0),
                              itemCount: carts.length,
                              itemBuilder: (context, index) {
                                return CartItemWidget(
                                  data: carts[index],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Button.filled(
                        width: 60,
                        onPressed: () async {
                          idAddress = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ShippingAddressPage()),
                          );
                          setState(() {});
                        },
                        label: 'Pilih Alamat Pengiriman',
                      ),
                    ),
                    const SpaceHeight(16.0),
                    BlocBuilder<GetAddressBloc, GetAddressState>(
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }, loaded: (response) {
                          if (response.data.isEmpty) {
                            return const Center(
                              child: Text(
                                'Alamat belum tersedia',
                              ),
                            );
                          }
                          final data = response.data.firstWhere(
                            (element) => element.id == idAddress,
                            orElse: () => response.data.first,
                          );
                          context.read<GetCostBloc>().add(
                                GetCostEvent.getCost(
                                  origin: subdistrictOrigin,
                                  destination: data.attributes.cityId,
                                  courier: 'jne',
                                ),
                              );
                          idAddress = data.id;
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: ColorName.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Alamat Pengiriman',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SpaceHeight(16.0),
                                Text(
                                  data.attributes.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: ColorName.grey,
                                  ),
                                ),
                                const SpaceHeight(8.0),
                                Text(
                                  data.attributes.address,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: ColorName.grey,
                                  ),
                                ),
                                const SpaceHeight(8.0),
                                Text(
                                  data.attributes.phone,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: ColorName.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                      },
                    ),
                    const SpaceHeight(16.0),
                    Container(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: ColorName.border,
                        ),
                      ),
                      child: CustomDropdown<Courier>(
                        value: couriers.first,
                        items: couriers,
                        label: 'Kurir',
                        onChanged: (value) {
                          courierName = value?.code ?? '';
                          context.read<GetCostBloc>().add(
                                GetCostEvent.getCost(
                                  origin: subdistrictOrigin,
                                  destination: idAddress.toString(),
                                  courier: value!.code,
                                ),
                              );
                        },
                      ),
                    ),
                    const SpaceHeight(16.0),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: ColorName.border),
                      ),
                      child: Column(
                        children: [
                          BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return const RowText(
                                    label: 'Total Harga',
                                    value: '0',
                                  );
                                },
                                loaded: (carts) {
                                  int totalPrice = 0;
                                  for (var element in carts) {
                                    totalPrice += int.parse(
                                            element.product.attributes.price) *
                                        element.quantity;
                                  }

                                  items = carts
                                      .map(
                                        (e) => Item(
                                            id: e.product.id,
                                            productName:
                                                e.product.attributes.name,
                                            price: int.parse(
                                                e.product.attributes.price),
                                            qty: e.quantity),
                                      )
                                      .toList();
                                  return RowText(
                                    label: 'Total Harga',
                                    value: totalPrice.currencyFormatRp,
                                  );
                                },
                              );
                            },
                          ),
                          const SpaceHeight(12.0),
                          BlocBuilder<GetCostBloc, GetCostState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return RowText(
                                    label: 'Biaya Pengiriman',
                                    value: 0.currencyFormatRp,
                                  );
                                },
                                loading: () {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                loaded: (response) {
                                  return RowText(
                                    label: 'Biaya Pengiriman',
                                    value: response
                                        .rajaongkir
                                        .results
                                        .first
                                        .costs
                                        .first
                                        .cost
                                        .first
                                        .value
                                        .currencyFormatRp,
                                  );
                                },
                              );
                            },
                          ),
                          const SpaceHeight(40.0),
                          const Divider(color: ColorName.border),
                          const SpaceHeight(12.0),
                          BlocBuilder<GetCostBloc, GetCostState>(
                            builder: (context, stateCost) {
                              return BlocBuilder<CartBloc, CartState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () {
                                      return const RowText(
                                        label: 'Total Harga',
                                        value: '0',
                                      );
                                    },
                                    loaded: (carts) {
                                      final cost = stateCost.maybeWhen(
                                        orElse: () => 0,
                                        loaded: (cost) => cost
                                            .rajaongkir
                                            .results
                                            .first
                                            .costs
                                            .first
                                            .cost
                                            .first
                                            .value,
                                      );
                                      courierPrice = cost;
                                      int totalPrice = 0;
                                      for (var element in carts) {
                                        totalPrice += int.parse(element
                                                .product.attributes.price) *
                                            element.quantity;
                                      }
                                      totalPrice += cost;
                                      totalPrices = totalPrice;
                                      return RowText(
                                        label: 'Total Harga',
                                        fontWeight: FontWeight.bold,
                                        value: totalPrice.currencyFormatRp,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          const SpaceHeight(16.0),
                          BlocConsumer<OrderBloc, OrderState>(
                            listener: (context, state) {
                              state.maybeWhen(
                                orElse: () {},
                                error: (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(error),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                                success: (response) {
                                  context.read<CartBloc>().add(
                                        const CartEvent.started(),
                                      );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PaymentPage(
                                          invoiceUrl: response.invoiceUrl,
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return Button.filled(
                                    onPressed: () async {
                                      await AuthLocalDataSource()
                                          .getUser()
                                          .then(
                                            (value) => context
                                                .read<OrderBloc>()
                                                .add(
                                                  OrderEvent.order(
                                                    OrderRequestModel(
                                                      data: Data(
                                                        items: items,
                                                        totalPrice: totalPrices,
                                                        deliveryAddress:
                                                            'Jombang',
                                                        courierName:
                                                            courierName,
                                                        courierPrice:
                                                            courierPrice,
                                                        status:
                                                            'waiting-payment',
                                                        buyerId: value.id!,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          );
                                    },
                                    label: 'Bayar Sekarang',
                                  );
                                },
                                loading: () {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
