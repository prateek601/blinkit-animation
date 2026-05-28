import 'package:flutter/material.dart';

class ClaimGiftCard extends StatelessWidget {
  const ClaimGiftCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[800],
      ),
      child: Row(
        children: [
          Image.asset("assets/images/wallet.png", height: 30, width: 30),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "Claim Gift Card",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Enter gift card details to claim your gift card",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_right, color: Colors.white),
        ],
      ),
    );
  }
}
