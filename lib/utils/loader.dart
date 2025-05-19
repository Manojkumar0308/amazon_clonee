import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CustomButtonLoader extends StatelessWidget {
  final Color? color;
  const CustomButtonLoader({
    Key? key,
    this.color,
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
        onPressed: () {},
        child: Platform.isIOS
            ? CupertinoActivityIndicator(
                color: color,
              )
            : CircularProgressIndicator(
                color: color,
              ),
      ),
    );
  }
}
