import 'package:flutter/material.dart';

class ListItemRow extends StatelessWidget {
  const ListItemRow({
    super.key,
    required this.label,
    required this.data,
  });

  final Widget label;
  final Widget data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          label,
          data,
        ],
      ),
    );
  }
}
