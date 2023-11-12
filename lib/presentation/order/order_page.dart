import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/spaces.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/order/bloc/buyer_order/buyer_order_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/order/widgets/order_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<String> status = [
    "waiting-payment",
    "packaging",
    "on-delivery",
    "done",
    "cancel"
  ];

  @override
  void initState() {
    context.read<BuyerOrderBloc>().add(
          const BuyerOrderEvent.getBuyerOrder(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: status.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pesanan'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: TabBar(
              tabs: status
                  .map((e) => Text(
                        e,
                        style: const TextStyle(fontSize: 16),
                      ))
                  .toList(),
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
            ),
          ),
        ),
        body: TabBarView(
            children: status
                .map(
                  (e) => BlocBuilder<BuyerOrderBloc, BuyerOrderState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const SizedBox();
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (message) => Center(
                          child: Text(message),
                        ),
                        loaded: (response) {
                          final data = response
                              .where(
                                  (element) => element.attributes.status == e)
                              .toList();
                          if (response.isEmpty || data.isEmpty) {
                            return const Center(
                              child: Text('Tidak ada data'),
                            );
                          }

                          return ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemBuilder: (context, index) => OrderCard(
                              data: data[index],
                            ),
                            separatorBuilder: (context, index) =>
                                const SpaceHeight(16),
                            itemCount: data.length,
                          );
                        },
                      );
                    },
                  ),
                )
                .toList()),
      ),
    );
  }
}
