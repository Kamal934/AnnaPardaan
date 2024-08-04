import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width; 

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width ?? double.infinity, 
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(  
          disabledBackgroundColor:Colors.transparent,
          backgroundColor: TColors.primaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
            
          ),
          maxLines:1,
        ),
      ),
    );
  }
}
