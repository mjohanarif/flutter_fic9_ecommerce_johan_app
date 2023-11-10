import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/spaces.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/colors.dart';

class OrderStatus extends StatelessWidget {
  final List<String> status;
  const OrderStatus({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Status(
          label: 'Dikemas',
          isActive: status.contains(
            'Dikemas',
          ),
          isFirst: true,
        ),
        _Status(
          label: 'Dikirim',
          isActive: status.contains(
            'Dikirim',
          ),
        ),
        _Status(
          label: 'Diterima',
          isActive: status.contains(
            'Diterima',
          ),
          isLast: true,
        ),
      ],
    );
  }
}

class _Status extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isFirst;
  final bool isLast;
  const _Status({
    required this.label,
    required this.isActive,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              color: isFirst
                  ? Colors.transparent
                  : isActive
                      ? ColorName.primary
                      : ColorName.border,
              height: 2,
              width: MediaQuery.of(context).size.width / 11.88,
            ),
            Icon(
              Icons.check_circle,
              color: isActive ? ColorName.primary : ColorName.border,
            ),
            Container(
              color: isLast
                  ? Colors.transparent
                  : isActive
                      ? ColorName.primary
                      : ColorName.border,
              height: 2,
              width: MediaQuery.of(context).size.width / 11.88,
            ),
          ],
        ),
        const SpaceHeight(
          12,
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: ColorName.grey),
        ),
      ],
    );
  }
}
