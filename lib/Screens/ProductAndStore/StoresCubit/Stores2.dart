import 'package:flutter/material.dart';
import '../../../helper/my_colors.dart';
import '../../../widget/ButtonStores.dart';
import '../ProductsCubit/Products2.dart';

class Stores2 extends StatefulWidget {
  static String id = "Stores2";
  final data;

  const Stores2({super.key, this.data});

  @override
  State<Stores2> createState() => Stores2State();
}

class Stores2State extends State<Stores2> {
  int activeButtonIndex = -1;

  double containerHeight = 0.0;

  void _onButtonPressed(int index) {
    setState(() {
      activeButtonIndex = index;
      containerHeight = MediaQuery.of(context).size.height * 0.55;
    });
  }

  String? color;
  bool lovely = false;
  Icon favorite = Icon(
    Icons.favorite,
    color: Colors.red,
  );
  List bestSelling = [
    {
      "image": "https://m.media-amazon.com/images/I/811RreTN3rL.jpg",
      "subtitle": "Description",
      "minTitle": "350\$",
      "lovely": "false"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.5qJYUBpSy9UCgtmGVMIUtAHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "800\$",
      "lovely": "false"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.4ppVpAqzHSDBBNldEhSJnAHaIk?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "400\$",
      "lovely": "false"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.5qJYUBpSy9UCgtmGVMIUtAHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "800\$",
      "lovely": "false"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.KnEiGWXOl0j2Fa4IkPBy3gHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "900\$",
      "lovely": "false"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.3Ydw75bvvzclzILTwAFhvwHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "1900\$",
      "lovely": "false"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.5qJYUBpSy9UCgtmGVMIUtAHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "800\$",
      "lovely": "false"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.7Z0T4E9MSIpTlpqA9UyR-AHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "150\$",
      "lovely": "false"
    },
    {
      "image":
          "https://th.bing.com/th/id/OIP.7Z0T4E9MSIpTlpqA9UyR-AHaHa?rs=1&pid=ImgDetMain",
      "subtitle": "Description",
      "minTitle": "150\$",
      "lovely": "false"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark_1,
      appBar: AppBar(
        backgroundColor: MyColors.dark_1,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          ListView(
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
                  child: Container(
                    width: 200,
                    height: 210,
                    color: Colors.grey[400],
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Adidas",
                                style: TextStyle(
                                    fontSize: 22, color: MyColors.dark_2),
                              ),
                              Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: 22, color: MyColors.dark_2),
                              ),
                              Text(
                                "Phone Number",
                                style: TextStyle(
                                    fontSize: 22, color: MyColors.dark_2),
                              ),
                              Text(
                                "******",
                                style: TextStyle(
                                    fontSize: 22, color: MyColors.dark_2),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            height: 170,
                            width: 170,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                              child:
                                  Image.asset('images/400094500264_505652.jpg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ButtonStores(
                        index: 0,
                        text: 'Button 1',
                        onPressed: () {},
                        activeButtonIndex: activeButtonIndex,
                        onButtonPressed: _onButtonPressed,
                      ),
                      ButtonStores(
                        index: 1,
                        text: 'Button 2',
                        onPressed: () {
                          print('Button 2 pressed');
                        },
                        activeButtonIndex: activeButtonIndex,
                        onButtonPressed: _onButtonPressed,
                      ),
                      ButtonStores(
                        index: 2,
                        text: 'Button 3',
                        onPressed: () {
                          print('Button 3 pressed');
                        },
                        activeButtonIndex: activeButtonIndex,
                        onButtonPressed: _onButtonPressed,
                      ),
                      ButtonStores(
                        index: 3,
                        text: 'Button 4',
                        onPressed: () {
                          print('Button 4 pressed');
                        },
                        activeButtonIndex: activeButtonIndex,
                        onButtonPressed: _onButtonPressed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(microseconds: 300),
                  curve: Curves.easeInOut,
                  height: containerHeight,
                  color: MyColors.dark_1,
                  child: ListView(
                    children: [
                      GridView.builder(
                        itemCount: bestSelling.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 307),
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Products2()));
                            },
                            child: Card(
                              child: Container(
                                color: MyColors.dark_2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 220,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            topLeft: Radius.circular(8)),
                                        child: Image.network(
                                          bestSelling[i]["image"],
                                          height: 220,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
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
                                      height: 0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            bestSelling[i]["minTitle"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {});
                                              if (bestSelling[i]["lovely"] ==
                                                  "false") {
                                                bestSelling[i]["lovely"] =
                                                    "true";
                                              } else {
                                                bestSelling[i]["lovely"] =
                                                    "false";
                                              }
                                              ;
                                            },
                                            icon: bestSelling[i]["lovely"] ==
                                                    "true"
                                                ? favorite
                                                : Icon(Icons
                                                    .favorite_outline_rounded)),
                                      ],
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
