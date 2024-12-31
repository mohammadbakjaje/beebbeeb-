import 'package:flutter/material.dart';

import '../../helper/my_colors.dart';
import '../../widget/ButtonOfStore.dart';
import '../../widget/ButtonSearch.dart';
import '../ِCustomDrawer.dart';
import 'Stores2.dart';

class Stores extends StatefulWidget {
  static String id = "Stores";

  @override
  State<Stores> createState() => StoresState();
}

class StoresState extends State<Stores> {
  List Stores = [
    {
      "image": "images/400094500264_505652.jpg",
      "subtitle": "Description",
    },
    {
      "image": "images/400094500264_505652.jpg",
      "subtitle": "Description",
    },
    {
      "image": "images/400094500264_505652.jpg",
      "subtitle": "Description",
    },
    {
      "image": "images/400094500264_505652.jpg",
      "subtitle": "Description",
    },
    {
      "image": "images/400094500264_505652.jpg",
      "subtitle": "Description",
    },
    {
      "image": "images/400094500264_505652.jpg",
      "subtitle": "Description",
    },
    {
      "image": "images/400094500264_505652.jpg",
      "subtitle": "Description",
    },
    {
      "image": "images/400094500264_505652.jpg",
      "subtitle": "Description",
    },
    {
      "image": "images/400094500264_505652.jpg",
      "subtitle": "Description",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: MyColors.dark_1,
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: MyColors.dark_1,
          foregroundColor: Colors.white,
        ),
        body: Container(
          child: ListView(
            children: [
              ButtonSearch(
                  hintText: "Search",
                  prefixImage: Image.asset("images/search.png")),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  "All Stores",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              Container(
                height: 1000,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, mainAxisExtent: 100),
                    itemBuilder: (context, i) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 13, right: 13, top: 10),
                        child: ButtonOfStore(
                            text: "Hammdoon",
                            imagePath: "images/400094500264_505652.jpg",
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Stores2()));
                            }),
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
//MG22
