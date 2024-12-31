import 'package:flutter/material.dart';

//todo
class HomePage2 extends StatefulWidget {
  final data;

  const HomePage2({super.key, this.data});

  @override
  State<HomePage2> createState() => HomePage2State();
}

class HomePage2State extends State<HomePage2> {
  String? color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.network(widget.data['image']),
          Container(
            height: 15,
          ),
          Container(
              child: Text(
            widget.data['title'],
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
          )),
          Container(
            height: 10,
          ),
          Container(
              child: Text(
            widget.data['subtitle'],
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          )),
          Container(
            height: 10,
          ),
          Container(
              child: Text(
            widget.data['minTitle'],
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.orange,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          )),
          Container(
            height: 30,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 100),
              ),
              Text(
                "Color:",
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1000),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 7),
              ),
              Text(
                "Grey",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(1000),
                ),
              ),
              Container(
                height: 100,
              ),
              Container(
                padding: EdgeInsets.only(left: 7),
              ),
              Text(
                "Black",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 10,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 150),
            child: Row(
              children: [
                Text(
                  "Size:    ",
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "M    L   XL",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            padding: EdgeInsets.symmetric(vertical: 15),
            child: MaterialButton(
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () {},
              child: Text("Add your Card"),
            ),
          )
        ],
      ),
    );
  }
}
