import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/extentions/date_time_ext.dart';

import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/buyer_order_response.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/order/bloc/cek_resi/cek_resi_bloc.dart';

class ManifestDeliveryPage extends StatefulWidget {
  final BuyerOrder data;
  const ManifestDeliveryPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ManifestDeliveryPage> createState() => _ManifestDeliveryPageState();
}

class _ManifestDeliveryPageState extends State<ManifestDeliveryPage> {
  @override
  void initState() {
    context.read<CekResiBloc>().add(
          CekResiEvent.getCekResi(
            courier: widget.data.attributes.courierName,
            waybill: widget.data.attributes.noResi,
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lacak Pengiriman'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          child: BlocBuilder<CekResiBloc, CekResiState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: Text('Resi Not Found'),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (response) {
                  return AnotherStepper(
                    stepperList: response.rajaongkir.result.manifest
                        .asMap()
                        .entries
                        .map((e) {
                      int index = e.key;
                      var data = e.value;
                      return StepperData(
                          title: StepperText(
                            data.manifestCode,
                            textStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          subtitle: StepperText(
                            '${data.manifestDate.toFormattedDateWithDay()} ${data.manifestTime}\n${data.manifestDescription}',
                          ),
                          iconWidget: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(
                                30,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                index.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ));
                    }).toList(),
                    stepperDirection: Axis.vertical,
                    iconWidth: 40,
                    iconHeight: 40,
                  );
                },
                error: (error) {
                  return Center(
                    child: Text(error.rajaongkir.status.description),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
