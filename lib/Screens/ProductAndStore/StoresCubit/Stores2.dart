import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Screens/ProductAndStore/StoresCubit/Bloc/store_details_cubit.dart';
import 'package:untitled1/Screens/ProductAndStore/StoresCubit/Bloc/store_details_states.dart';
import '../../../helper/constants.dart';
import '../../../helper/my_colors.dart';
import '../../../widget/ButtonStores.dart';
import '../ProductsCubit/Products2.dart';

class Stores2 extends StatefulWidget {
  static String id = "Stores2";

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

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      backgroundColor: MyColors.dark_1,
      appBar: AppBar(
        backgroundColor: MyColors.dark_1,
        foregroundColor: Colors.white,
        elevation: 0, // إزالة الظل من AppBar
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<StoreDetailsCubit, StoreDetailsState>(
                  builder: (BuildContext context, StoreDetailsState state) {
                    StoreDetailsCubit cubit =
                        BlocProvider.of<StoreDetailsCubit>(context);
                    if (state is GetOneStoreLoadingState)
                      return Center(child: CircularProgressIndicator());
                    else if (state is GetOneStoreSuccessState) {
                      return Card(
                        elevation: 5, // إضافة ظل للبطاقة
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 210,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [MyColors.dark_2, MyColors.dark_1],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.store!.name,
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      cubit.store!.address,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      cubit.store!.phone,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    "http://$ipv4/${cubit.store!.logo}",
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "Failed to get Store",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      SizedBox(width: 8),
                      ButtonStores(
                        index: 1,
                        text: 'Button 2',
                        onPressed: () {
                          print('Button 2 pressed');
                        },
                        activeButtonIndex: activeButtonIndex,
                        onButtonPressed: _onButtonPressed,
                      ),
                      SizedBox(width: 8),
                      ButtonStores(
                        index: 2,
                        text: 'Button 3',
                        onPressed: () {
                          print('Button 3 pressed');
                        },
                        activeButtonIndex: activeButtonIndex,
                        onButtonPressed: _onButtonPressed,
                      ),
                      SizedBox(width: 8),
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
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: containerHeight,
              decoration: BoxDecoration(
                color: MyColors.dark_1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  GridView.builder(
                    itemCount: bestSelling.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 250,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, i) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Products2()));
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [MyColors.dark_2, MyColors.dark_1],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.network(
                                    bestSelling[i]["image"],
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    bestSelling[i]["subtitle"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        bestSelling[i]["minTitle"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (bestSelling[i]["lovely"] ==
                                                "false") {
                                              bestSelling[i]["lovely"] = "true";
                                            } else {
                                              bestSelling[i]["lovely"] =
                                                  "false";
                                            }
                                          });
                                        },
                                        icon: bestSelling[i]["lovely"] == "true"
                                            ? Icon(Icons.favorite,
                                                color: Colors.red)
                                            : Icon(Icons.favorite_outline,
                                                color: Colors.white),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
