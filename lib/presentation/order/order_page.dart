import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/spaces.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/order/bloc/buyer_order/buyer_order_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/order/models/transaction_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/order/widgets/order_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final List<TransactionModel> transactions = [
    TransactionModel(
      noResi: 'QQNSU346JK',
      status: 'Dikirim',
      quantity: 2,
      price: 1900000,
    ),
    TransactionModel(
      noResi: 'SDG1345KJD',
      status: 'Diterima',
      quantity: 2,
      price: 900000,
    ),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan'),
      ),
      body: BlocBuilder<BuyerOrderBloc, BuyerOrderState>(
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
              if (response.isEmpty) {
                return const Center(
                  child: Text('Tidak ada data'),
                );
              }
              return ListView.separated(
                itemBuilder: (context, index) => OrderCard(
                  data: response[index],
                ),
                separatorBuilder: (context, index) => const SpaceHeight(16),
                itemCount: response.length,
              );
            },
          );
        },
      ),
    );
  }
}
