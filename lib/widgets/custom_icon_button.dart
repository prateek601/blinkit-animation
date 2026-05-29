import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final void Function()? onTap;
  final IconData icon;
  const CustomIconButton({super.key, this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        // Transparent so glass effect shows through
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
        shape: CircleBorder(),
        elevation: 0,
      ),
      child: Ink(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Glass effect layers
          color: Colors.white.withValues(alpha: 0.08),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.15),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: SizedBox(
          width: 46,
          height: 46,
          child: Center(
            child: Icon(
              icon,
              color: Colors.white.withValues(alpha: 0.85),
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
