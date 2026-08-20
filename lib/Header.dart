import 'package:flutter/cupertino.dart';
import 'colors.dart';

class Header extends StatelessWidget {
  final bool isXTurn;

  Header({super.key, required this.isXTurn});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.White,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        isXTurn ? "Player 1’s Turn(X)" : "Player 2’s Turn(O)",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isXTurn ? AppColors.XRed : AppColors.OGreen,
        ),
      ),
    );
  }
}
