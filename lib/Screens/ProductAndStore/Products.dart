// import 'package:flutter/material.dart';
// import 'package:untitled11/helps/ButtonSearch.dart';
//
// import '../helps/ButtonStores.dart';
//
// class Product extends StatefulWidget {
//   static String id = "Product";
//
//   @override
//   State<Product> createState() => _ProductState();
// }
//
// class _ProductState extends State<Product> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         drawer: Drawer(),
//         appBar: AppBar(
//           backgroundColor: Color(0xff1D182A),
//           foregroundColor: Colors.white,
//         ),
//         body: Container(
//           color: Color(0xff1d182a),
//           child: ListView(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 80),
//                 child: Text(
//                   "Products",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 42,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Container(
//                 height: 20,
//               ),
//               ButtonSearch(
//                   hintText: "Search",
//                   prefixImage: Image.asset("images/search.png")),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: <Widget>[
//                       ButtonProductStores(
//                         text: 'shoses',
//                         onPressed: () {},
//                       ),
//                       ButtonProductStores(
//                         text: 'Clothes',
//                         onPressed: () {},
//                       ),
//                       ButtonProductStores(
//                         text: 'Makeup',
//                         onPressed: () {},
//                       ),
//                       ButtonProductStores(
//                         text: 'Button 4',
//                         onPressed: () {},
//                       ),
//                       ButtonProductStores(
//                         text: 'Button 5',
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';







import '../../helper/my_colors.dart';
import '../../widget/ButtonSearch.dart';
import '../ِCustomDrawer.dart';
import 'Products2.dart';

class Products extends StatefulWidget {
  static String id = "Products";

  @override
  State<Products> createState() => _ProductsOfStoresState();
}

class _ProductsOfStoresState extends State<Products> {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: MyColors.dark_1,
          foregroundColor: Colors.white,
        ),
        //drawer: Drawer(),
        backgroundColor: MyColors.dark_1,
        body: Padding(
          padding: EdgeInsets.only(right: 14, left: 14),
          child: Container(
            child: ListView(
              children: [
                ButtonSearch(
                    hintText: "Search",
                    prefixImage: Image.asset("images/search.png")),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "All Products",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Container(
                  height: 10,
                ),
                GridView.builder(
                  itemCount: bestSelling.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 307),
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
                                    padding: const EdgeInsets.only(left: 10),
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
                                          bestSelling[i]["lovely"] = "true";
                                        } else {
                                          bestSelling[i]["lovely"] = "false";
                                        }
                                        ;
                                      },
                                      icon: bestSelling[i]["lovely"] == "true"
                                          ? favorite
                                          : Icon(
                                              Icons.favorite_outline_rounded)),
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
        ),
      ),
    );
  }
}
