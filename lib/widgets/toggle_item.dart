import 'package:flutter/material.dart';

class ToggleItem extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool val) onChanged;

  const ToggleItem({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 300),
      child: Row(
        children: [
          Text(title),
          const Spacer(),
          Switch(
            value: value,
            onChanged: (_) {
              onChanged(!value);
            },
          ),
        ],
      ),
    );
  }
}
