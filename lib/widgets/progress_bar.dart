import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class ProgressBar extends StatelessWidget {
  final String title;
  final double percent;

  const ProgressBar({
    super.key,
    required this.title,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.40,
      child: Column(
        children: [
          Consumer<PreferencesProvider>(
            builder: (context, provider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  if (provider.showPercentageDecimals)
                    Text('${(percent * 100).toStringAsFixed(4)}%')
                  else
                    Text('${(percent * 100).floor().toStringAsFixed(0)}%'),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  value: percent,
                  minHeight: 10.0,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
