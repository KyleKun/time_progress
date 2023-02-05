import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkText extends StatelessWidget {
  final String text;
  final String link;

  const LinkText({
    super.key,
    required this.text,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.transparent,
              decoration: TextDecoration.underline,
              decorationColor: Colors.blue,
              decorationThickness: 2,
              shadows: [
                const Shadow(color: Colors.blue, offset: Offset(0, -2.5))
              ],
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrlString(
                  link,
                );
              },
          ),
        ],
      ),
    );
  }
}
