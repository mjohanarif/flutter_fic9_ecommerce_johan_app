import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/spaces.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/requests/add_address_request.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/city_response_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/province_response_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/subdistrict_response_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/bloc/add_address/add_address_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/bloc/city/city_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/bloc/province/province_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/bloc/subdistrict/subdistrict_bloc.dart';

import '../../common/components/button.dart';
import '../../common/components/custom_dropdown.dart';
import '../../common/components/custom_text_field2.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  bool isDefault = false;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  Province? selectedProvince;

  City? selectedCity;

  Subdistrict? selectedSubdistrict;

  @override
  void initState() {
    context.read<ProvinceBloc>().add(
          const ProvinceEvent.getAll(),
        );
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    zipCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Alamat'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: nameController,
            label: 'Nama Lengkap',
            keyboardType: TextInputType.name,
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: addressController,
            label: 'Alamat Jalan',
            maxLines: 3,
            keyboardType: TextInputType.multiline,
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: phoneNumberController,
            label: 'No Handphone',
            keyboardType: TextInputType.phone,
          ),
          const SpaceHeight(24.0),
          BlocBuilder<ProvinceBloc, ProvinceState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (provinces) {
                  return CustomDropdown<Province>(
                    value: selectedProvince,
                    items: provinces,
                    label: 'Provinsi',
                    onChanged: (value) {
                      context.read<CityBloc>().add(
                            CityEvent.getAllCyProvinceId(value!.provinceId),
                          );
                      selectedProvince = value;
                      setState(() {});
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          BlocBuilder<CityBloc, CityState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const CustomDropdown(
                    value: '-',
                    items: ['-'],
                    label: 'Kota/Kabupaten',
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (cities) {
                  return CustomDropdown<City>(
                    value: selectedCity,
                    items: cities,
                    label: 'Kota/Kabupaten',
                    onChanged: (value) {
                      selectedCity = value;
                      context.read<SubdistrictBloc>().add(
                            SubdistrictEvent.getSubdistrictByCityId(
                                value!.cityId),
                          );
                      setState(() {});
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          BlocBuilder<SubdistrictBloc, SubdistrictState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const CustomDropdown(
                    value: '-',
                    items: ['-'],
                    label: 'Kecamatan',
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (subdistrict) {
                  return CustomDropdown<Subdistrict>(
                    value: selectedSubdistrict,
                    items: subdistrict,
                    label: 'Kecamatan',
                    onChanged: (value) {
                      selectedSubdistrict = value;

                      setState(() {});
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: zipCodeController,
            label: 'Kode Pos',
            keyboardType: TextInputType.number,
          ),
          const SpaceHeight(24.0),
          CheckboxListTile(
            title: const Text('Simpan sebagai alamat utama'),
            value: isDefault,
            onChanged: (value) {
              setState(() {
                isDefault = !isDefault;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AddAddressBloc, AddAddressState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (response) => Navigator.pop(context, response),
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Button.filled(
                  onPressed: () async {
                    final userId = (await AuthLocalDataSource().getUser()).id;
                    context.read<AddAddressBloc>().add(
                          AddAddressEvent.addAddress(
                            request: AddAddressRequestModel(
                              data: AddAddress(
                                name: nameController.text,
                                address:
                                    '${addressController.text}, ${selectedSubdistrict?.subdistrictName}, ${selectedCity?.cityName}, ${selectedProvince?.province}, ${zipCodeController.text}',
                                phone: phoneNumberController.text,
                                provId: selectedProvince?.provinceId ?? '',
                                cityId: selectedCity?.cityId ?? '',
                                subdistrictId:
                                    selectedSubdistrict?.subdistrictId ?? '',
                                codePos: zipCodeController.text,
                                userId: userId.toString(),
                                isDefault: isDefault,
                              ),
                            ),
                          ),
                        );
                  },
                  label: 'Tambah Alamat',
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (message) {
                return Button.filled(onPressed: () {}, label: 'Error');
              },
            );
          },
        ),
      ),
    );
  }
}
