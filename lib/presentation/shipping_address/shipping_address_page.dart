import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/button.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/spaces.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/add_address_page.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/bloc/get_address/get_address_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/models/address_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/widgets/address_tile.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  final List<AddressModel> addresses = [
    const AddressModel(
      name: 'Abdul Rozak',
      address: 'Jl. suka cita, no 17. kelurahan sukses maju',
      phoneNumber: '08566688686868',
    ),
    const AddressModel(
      name: 'Abdul Manaf',
      address: 'Jalan lorem ipsum situ',
      phoneNumber: '08565658888976',
    ),
  ];
  @override
  void initState() {
    context.read<GetAddressBloc>().add(
          const GetAddressEvent.getAddressByUserId(),
        );
    super.initState();
  }

  int? idAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengiriman'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AddAddressPage();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: BlocBuilder<GetAddressBloc, GetAddressState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
                child: Text('No data'),
              );
            },
            loaded: (response) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) => AddressTile(
                  isSelected: idAddress == response.data[index].id,
                  data: response.data[index],
                  onTap: () {
                    idAddress = response.data[index].id;
                    setState(() {});
                  },
                  onEditTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return EditAddressPage(
                    //         data: addresses[index],
                    //       );
                    //     },
                    //   ),
                    // );
                  },
                  onDeleteTap: () {},
                ),
                separatorBuilder: (context, index) => const SpaceHeight(
                  16,
                ),
                itemCount: response.data.length,
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Button.filled(
          disabled: idAddress == null,
          onPressed: () {
            Navigator.pop(context, idAddress);
          },
          label: 'pilih',
        ),
      ),
    );
  }
}
