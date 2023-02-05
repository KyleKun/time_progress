import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';
import 'package:time_progress/widgets/link_text.dart';

import '../constants.dart';
import '../provider.dart';
import 'toggle_item.dart';

class Fab extends StatefulWidget {
  const Fab({super.key});

  @override
  State<Fab> createState() => _FabState();
}

class _FabState extends State<Fab> {
  @override
  Widget build(BuildContext context) {
    return SpeedDialFabWidget(
      secondaryIconsList: const [
        Icons.settings,
        Icons.image,
        Icons.color_lens,
        Icons.info,
      ],
      secondaryIconsText: const [
        "Preferences",
        "Background",
        "Theme",
        "About",
      ],
      secondaryIconsOnPress: [
        () => _showPreferences(),
        () async => await _changeBackground(),
        () => _changeTheme(),
        () => _showAbout(),
      ],
      secondaryBackgroundColor: Theme.of(context).colorScheme.surface,
      secondaryForegroundColor: Theme.of(context).colorScheme.primary,
      primaryBackgroundColor: Theme.of(context).colorScheme.surface,
      primaryForegroundColor: Theme.of(context).colorScheme.primary,
    );
  }

  void _showPreferences() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Preferences'),
        content: Builder(builder: (context) {
          final provider = Provider.of<PreferencesProvider>(context);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ToggleItem(
                title: 'Show current date',
                value: provider.showCurrentDate,
                onChanged: (val) => provider.setShowCurrentDate(val),
              ),
              ToggleItem(
                title: 'Show day bar first',
                value: provider.swapBarsOrder,
                onChanged: (val) => provider.setSwapBarsOrder(val),
              ),
              ToggleItem(
                title: 'Show precise percentage',
                value: provider.showPercentageDecimals,
                onChanged: (val) => provider.setShowPercentageDecimals(val),
              ),
            ],
          );
        }),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAbout() {
    showAboutDialog(
      context: context,
      applicationIcon: const Icon(Icons.hourglass_bottom, size: 32),
      applicationName: Constants.kAppName,
      applicationVersion: Constants.kAppVersion,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              Constants.kAppDescription,
            ),
            const SizedBox(height: 8),
            const LinkText(
              text: 'Source Code',
              link: Constants.kAppRepo,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Made by '),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: LinkText(
                    text: 'KyleKun',
                    link: 'https://kylekun.com',
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  void _changeTheme() {
    Provider.of<ThemeProvider>(context, listen: false).changeTheme();
  }

  Future<void> _changeBackground() async {
    final provider = context.read<BackgroundProvider>();

    // Remove background
    if (provider.backgroundImagePath.isNotEmpty) {
      provider.setBackgroundImage('');
      return;
    }

    // Set background
    XFile? fromPicker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (fromPicker == null) return;
    final bytes = await fromPicker.readAsBytes();
    provider.setBackgroundImage(base64Encode(bytes));
  }
}
