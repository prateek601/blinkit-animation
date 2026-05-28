import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        textStyle: WidgetStateTextStyle.resolveWith(
          (_) => TextStyle(fontSize: 16),
        ),
        backgroundColor: WidgetStateColor.resolveWith(
          (_) => const Color.fromARGB(255, 6, 165, 11),
        ),
        foregroundColor: WidgetStateColor.resolveWith((_) => Colors.white),
        minimumSize: WidgetStateProperty.all(Size(double.infinity, 50)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      child: Text("Add Money", style: TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}
