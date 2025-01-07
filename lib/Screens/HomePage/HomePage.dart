import 'package:flutter/material.dart';

import '../../helper/my_colors.dart';
import '../../widget/CustomBottomNavigationBar.dart';
import '../../widget/coustembutonm.dart';
import '../Added/Cart.dart';
import '../Added/Favourit.dart';
import '../Added/Orders.dart';
import '../ProductAndStore/ProductsCubit/Products.dart';
import '../ProductAndStore/Products2.dart';
import '../ProductAndStore/Stores.dart';
import '../Drawer/ِCustomDrawer.dart';
import 'HomePage2.dart';
import 'Slideshow.dart';

class HomePage extends StatefulWidget {
  static String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //NaffBar
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Cart()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Orders()));
        break;
      case 3:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Favourit()));
        break;
    }
  }

  List bestSelling = [
    {
      "image": "https://m.media-amazon.com/images/I/811RreTN3rL.jpg",
      "subtitle": "Description",
      "minTitle": "350\$"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.4ppVpAqzHSDBBNldEhSJnAHaIk?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "400\$"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.KnEiGWXOl0j2Fa4IkPBy3gHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "900\$"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.3Ydw75bvvzclzILTwAFhvwHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "1900\$"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.5qJYUBpSy9UCgtmGVMIUtAHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "800\$"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.7Z0T4E9MSIpTlpqA9UyR-AHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "150\$"
    },
  ];

  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.dark_1,
          foregroundColor: Colors.white,
        ),
        drawer: CustomDrawer(),
        backgroundColor: MyColors.dark_1,
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('images/home.png')),
              label: "*",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('images/sss.png')),
              label: "*",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('images/orders.png')),
              label: "*",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('images/hhh.png')),
              label: "*",
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListView(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Image.asset("images/search.png"),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  hintText: "Search",
                  hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                  fillColor: MyColors.dark_2,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  //border: InputBorder.none,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
              ),
              Container(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14, right: 19),
                      child: CoustemButonM(
                        color: MyColors.buttun,
                        text: "Products",
                        ontap: () {
                          Navigator.of(context).pushNamed(Products.id);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 14, left: 19),
                      child: CoustemButonM(
                        color: MyColors.buttun,
                        text: "Stores",
                        ontap: () {
                          Navigator.of(context).pushNamed(Stores.id);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 20,
              ),
              Text(
                "Categories",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
              Container(
                height: 20,
              ),
              Container(height: 223, width: 324, child: Slideshow()),
              Container(height: 30),
              Text(
                "Most Requested Products",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: Colors.white),
              ),
              Container(
                height: 20,
              ),
              Container(
                height: 310,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bestSelling.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Products2(
                                  data: bestSelling[i],
                                )));
                      },
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              color: MyColors.dark_2,
                              borderRadius: BorderRadius.circular(8)),
                          height: 281,
                          width: 159,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8)),
                                child: Image.network(
                                  bestSelling[i]["image"],
                                  height: 220,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  bestSelling[i]["subtitle"],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                child: Text(
                                  bestSelling[i]["minTitle"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(height: 30),
              Text(
                "Most Populer Stores",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: Colors.white),
              ),
              Container(
                height: 20,
              ),
              Container(
                height: 310,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bestSelling.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage2(
                                  data: bestSelling[i],
                                )));
                      },
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              color: MyColors.dark_2,
                              borderRadius: BorderRadius.circular(8)),
                          height: 281,
                          width: 159,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8)),
                                child: Image.network(
                                  bestSelling[i]["image"],
                                  height: 220,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  bestSelling[i]["subtitle"],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                child: Text(
                                  bestSelling[i]["minTitle"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//MG22
