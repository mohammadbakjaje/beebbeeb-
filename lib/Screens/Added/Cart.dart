import 'package:flutter/material.dart';

import '../../helper/my_colors.dart';
import '../../widget/CustomBottomNavigationBar.dart';
import '../../widget/coustembutonm.dart';
import '../HomePage/HomePage.dart';
import '../ProductAndStore/Products2.dart';
import '../Drawer/ِCustomDrawer.dart';
import 'Favourit.dart';
import 'Orders.dart';

class Cart extends StatefulWidget {
  static String id = "Cart";

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int currentValue = 0;
  double price = 0;

  void inCrement() {
    setState(() {
      currentValue++;
    });
  }

  void decrement() {
    setState(() {
      currentValue--;
    });
  }

  List bestSelling = [
    {
      "image": "https://m.media-amazon.com/images/I/811RreTN3rL.jpg",
      "subtitle": "Description",
      "minTitle": "350\$",
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.4ppVpAqzHSDBBNldEhSJnAHaIk?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "400\$",
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.KnEiGWXOl0j2Fa4IkPBy3gHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "900\$",
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.3Ydw75bvvzclzILTwAFhvwHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "1900\$",
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.3Ydw75bvvzclzILTwAFhvwHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "1900\$",
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.3Ydw75bvvzclzILTwAFhvwHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "1900\$",
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.3Ydw75bvvzclzILTwAFhvwHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "190\$",
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.5qJYUBpSy9UCgtmGVMIUtAHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "800\$",
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.7Z0T4E9MSIpTlpqA9UyR-AHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "150\$",
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
      backgroundColor: MyColors.dark_1,
      drawer: CustomDrawer(),
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
          "My Cart",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, left: 8),
                                child: Text(
                                  bestSelling[i]["subtitle"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 8),
                                child: Text(
                                  bestSelling[i]["minTitle"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 17, left: 45),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 70),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: MyColors.dark_2,
                                      borderRadius: BorderRadius.circular(1),
                                      boxShadow: [
                                        BoxShadow(
                                          color: MyColors.dark_2,
                                        )
                                      ]),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: decrement,
                                        icon: Icon(
                                          Icons.remove,
                                          size: 20,
                                        ),
                                        color: Colors.white,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 7),
                                        child: Text(
                                          "$currentValue",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: inCrement,
                                        icon: Icon(
                                          Icons.add,
                                          size: 20,
                                        ),
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
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
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Row(
                children: [
                  Text(
                    "    Price of all cart is:",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Text(
                    "       $price",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 5, bottom: 10),
                    child: CoustemButonM(
                      color: MyColors.buttun,
                      text: "Confirm",
                      ontap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: MyColors.dark_2,
                                title: Text(
                                  "Confirm ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                content: Text(
                                  "Are you sure you want to buy all items ?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Sure")),
                                ],
                              );
                            });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 5, right: 10, bottom: 10),
                    child: CoustemButonM(
                      color: Colors.red,
                      text: "Remove All",
                      ontap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: MyColors.dark_2,
                                title: Text(
                                  "Confirm Deletion",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                content: Text(
                                  "Are you sure you want to delete all items ?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Delete")),
                                ],
                              );
                            });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
