import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/button.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/row_text.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/spaces.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/colors.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/extentions/int_ext.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/buyer_order_response.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/order/manifest_delivery_page.dart';

import 'package:flutter_fic9_ecommerce_johan_app/presentation/order/order_detail_page.dart';

class OrderCard extends StatelessWidget {
  final BuyerOrder data;
  const OrderCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return OrderDetailPage(
                data: data,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            5,
          ),
          border: Border.all(
            color: ColorName.border,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No Resi: ${data.attributes.noResi}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Button.filled(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ManifestDeliveryPage(
                            data: data,
                          );
                        },
                      ),
                    );
                  },
                  label: 'lacak',
                  height: 20,
                  width: 94,
                  fontSize: 11,
                ),
              ],
            ),
            const SpaceHeight(24),
            RowText(label: 'Status', value: data.attributes.status),
            const SpaceHeight(12.0),
            RowText(
              label: 'Harga',
              value: data.attributes.totalPrice.currencyFormatRp,
            ),
          ],
        ),
      ),
    );
  }
}
