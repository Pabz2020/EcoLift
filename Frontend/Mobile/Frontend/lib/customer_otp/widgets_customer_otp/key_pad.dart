import 'package:flutter/material.dart';

class KeyPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: 12,
      itemBuilder: (context, index) {
        String text = index < 9
            ? '${index + 1}'
            : index == 9
                ? '0'
                : index == 10
                    ? '←'
                    : '✔';
        return InkWell(
          onTap: () {
            // Handle key press
          },
          child: Center(child: Text(text, style: TextStyle(fontSize: 24))),
        );
      },
    );
  }
}
