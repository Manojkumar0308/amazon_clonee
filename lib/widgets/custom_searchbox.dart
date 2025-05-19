import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchBox({
    Key? key,
    required this.onChanged,
    this.hintText = 'Search by name or category',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:5.0),
      child: Container(
        height: 42,
        width: double.infinity,
        // margin: const EdgeInsets.symmetric(horizontal: 2,vertical: 0),
        // padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
  borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey),

        ),
        child: Center(
          child: TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,

              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search, color: Colors.black, size: 25,),


            ),
          ),
        ),
      ),
    );
  }
}
