import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      height: 50,
      width: size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.0), color: color),
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black12.withOpacity(0.03),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
