import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  const PrimaryButton({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
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
      child: Text(title, style: TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}
