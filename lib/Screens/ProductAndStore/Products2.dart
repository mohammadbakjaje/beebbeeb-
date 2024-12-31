import 'package:flutter/material.dart';

import '../../helper/my_colors.dart';

class Products2 extends StatefulWidget {
  static String id = "Products2";
  final data;

  const Products2({super.key, this.data});

  @override
  State<Products2> createState() => Products2State();
}

class Products2State extends State<Products2> {
  String? color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark_1,
      appBar: AppBar(
        backgroundColor: MyColors.dark_1,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
              child: Image.network(widget.data['image']),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              widget.data['subtitle'],
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              widget.data['minTitle'],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 270),
            child: IconButton(
              onPressed: () {
                setState(() {
                  widget.data['lovely'] =
                      widget.data['lovely'] == "true" ? "false" : "true";
                });
              },
              icon: widget.data['lovely'] == "true"
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_outline_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
