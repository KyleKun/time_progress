import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BackgroundProvider>(
      builder: (context, provider, child) {
        if (provider.backgroundImagePath.isNotEmpty) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.memory(
                  base64Decode(
                    provider.backgroundImagePath,
                  ),
                ).image,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.80),
                  Theme.of(context).colorScheme.primary.withOpacity(0.70),
                  Theme.of(context).colorScheme.surface,
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
