import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/button.dart';

import 'package:flutter_fic9_ecommerce_johan_app/common/components/row_text.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/spaces.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/colors.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/images.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/extentions/date_time_ext.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/extentions/int_ext.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/buyer_order_response.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/order/models/order_product_model.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/order/widgets/order_product_tile.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/order/widgets/order_status.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/payment/payment_page.dart';

class OrderDetailPage extends StatefulWidget {
  final BuyerOrder data;
  const OrderDetailPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final List<OrderProductModel> products = [
    const OrderProductModel(
      imagePath: Images.product1,
      name: 'Tas Kekinian',
      price: 200000,
    ),
    const OrderProductModel(
      imagePath: Images.product2,
      name: 'Earphone',
      price: 199999,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    int totalItem = 0;
    for (var element in widget.data.attributes.items) {
      totalItem += element.price;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
      ),
      bottomSheet: widget.data.attributes.invoiceUrl != '-' &&
              (widget.data.attributes.status.contains('waiting'))
          ? Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Button.filled(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PaymentPage(
                          invoiceUrl: widget.data.attributes.invoiceUrl,
                        );
                      },
                    ),
                  );
                },
                label: 'Pay Now',
              ),
            )
          : const SizedBox(),
      body: ListView(
        padding: const EdgeInsets.all(
          16,
        ),
        children: [
          const OrderStatus(
            status: ['Dikemas'],
          ),
          const SpaceHeight(
            24,
          ),
          const Text(
            'Produk',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SpaceHeight(
            14,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.data.attributes.items.length,
            itemBuilder: (context, index) => OrderProductTile(
              data: widget.data.attributes.items[index],
            ),
          ),
          const SpaceHeight(24.0),
          const Text(
            'Detail Pengiriman',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SpaceHeight(14.0),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(color: ColorName.border),
            ),
            child: Column(
              children: [
                RowText(
                  label: 'Waktu Pengiriman',
                  value:
                      widget.data.attributes.createdAt.toFormattedDateWithDay(),
                ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'Ekspedisi Pengiriman',
                  value: widget.data.attributes.courierName,
                ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'No. Resi',
                  value: widget.data.attributes.noResi,
                ),
                const SpaceHeight(12.0),
              ],
            ),
          ),
          const SpaceHeight(24.0),
          const Text(
            'Detail Pembayaran',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SpaceHeight(14.0),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(color: ColorName.border),
            ),
            child: Column(
              children: [
                RowText(
                  label: 'Total Item ${widget.data.attributes.items.length}',
                  value: totalItem.currencyFormatRp,
                ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'Ongkir',
                  value: widget.data.attributes.courierPrice.currencyFormatRp,
                ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'Total ',
                  value: widget.data.attributes.totalPrice.currencyFormatRp,
                  valueColor: ColorName.primary,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
