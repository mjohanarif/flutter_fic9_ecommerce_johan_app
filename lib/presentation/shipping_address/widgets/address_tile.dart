import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/button.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/spaces.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/colors.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/get_address_response_model.dart';

class AddressTile extends StatelessWidget {
  final bool isSelected;
  final GetAddress data;
  final VoidCallback onTap;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;
  const AddressTile({
    Key? key,
    this.isSelected = true,
    required this.data,
    required this.onTap,
    required this.onEditTap,
    required this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(
          24,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected ? ColorName.primary : ColorName.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.attributes.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(16),
            Text(
              data.attributes.address,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorName.grey,
              ),
            ),
            const SpaceHeight(16),
            Text(
              data.attributes.phone,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorName.grey,
              ),
            ),
            const SpaceHeight(16),
            Row(
              children: [
                Button.filled(
                  onPressed: onEditTap,
                  label: 'Edit',
                  width: 80,
                ),
                const SpaceWidth(
                  16,
                ),
                IconButton(
                  onPressed: onDeleteTap,
                  icon: const ImageIcon(
                    AssetImage(
                      'assets/icons/Trash.png',
                    ),
                    color: ColorName.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
