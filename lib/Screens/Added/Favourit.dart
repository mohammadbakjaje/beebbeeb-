import 'package:flutter/material.dart';

import '../../helper/my_colors.dart';
import '../../widget/CustomBottomNavigationBar.dart';
import '../HomePage/HomePage.dart';
import '../ProductAndStore/Products2.dart';

import '../ِCustomDrawer.dart';
import 'Cart.dart';
import 'Orders.dart';

class Favourit extends StatefulWidget {
  static String id = "Favourit";

  @override
  State<Favourit> createState() => _FavouritState();
}

class _FavouritState extends State<Favourit> {
  bool lovely = false;
  Icon favorite = Icon(
    Icons.favorite,
    color: Colors.red,
  );

  void removeContainer(int i) {
    setState(() {
      bestSelling.removeAt(i);
    });
  }

  List bestSelling = [
    {
      "image": "https://m.media-amazon.com/images/I/811RreTN3rL.jpg",
      "subtitle": "Description",
      "minTitle": "350\$",
      "lovely": "true"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.4ppVpAqzHSDBBNldEhSJnAHaIk?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "400\$",
      "lovely": "true"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.KnEiGWXOl0j2Fa4IkPBy3gHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "900\$",
      "lovely": "true"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.3Ydw75bvvzclzILTwAFhvwHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "1900\$",
      "lovely": "true"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.3Ydw75bvvzclzILTwAFhvwHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "1900\$",
      "lovely": "true"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.3Ydw75bvvzclzILTwAFhvwHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "1900\$",
      "lovely": "true"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.3Ydw75bvvzclzILTwAFhvwHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "190\$",
      "lovely": "true"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.5qJYUBpSy9UCgtmGVMIUtAHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "800\$",
      "lovely": "true"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.7Z0T4E9MSIpTlpqA9UyR-AHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "150\$",
      "lovely": "true"
    },
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        appBar: AppBar(
          title: Text(
            "My Favourite things",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          foregroundColor: Colors.white,
          backgroundColor: MyColors.dark_1,
        ),
        body: Container(
          child: ListView(
            children: [
              GridView.builder(
                itemCount: bestSelling.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, mainAxisExtent: 100),
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
                          border: Border.all(
                            color: MyColors.dark_2,
                          ),
                          color: MyColors.dark_2, //
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        width: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 13),
                              child: Container(
                                height: 65,
                                width: 65,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                  child: Image.network(
                                    bestSelling[i]["image"],
                                    height: 220,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bestSelling[i]["subtitle"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    bestSelling[i]["minTitle"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40, top: 25),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.shopping_cart,
                                        size: 25,
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        removeContainer(i);
                                      },
                                      icon: Icon(
                                        size: 25,
                                        Icons.favorite,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
