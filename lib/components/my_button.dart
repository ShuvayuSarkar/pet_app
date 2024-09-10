import 'package:flutter/material.dart';

//a simple button to login

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //Padding inside
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          //curved corners
          borderRadius: BorderRadius.circular(12),
          //color of button
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
