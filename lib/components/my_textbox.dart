import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback? onPressed;
  const MyTextBox({
    super.key,
    required this.text,
    required this.imagePath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(imagePath),
                const SizedBox(width: 10),
                Text(text),
              ],
            ),
            IconButton(
              iconSize: 18.0,
              onPressed: onPressed,
              icon: Image.asset(
                'lib/icons/edit.png',
              ),
            ),
          ],
        )
      ]),
    );
  }
}
