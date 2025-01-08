import 'package:flutter/material.dart';

import '../../helper/my_colors.dart';
import '../../widget/ButtonOfOrders.dart';
import '../HomePage/HomePage.dart';

import '../Drawer/ِCustomDrawer.dart';
import 'Cart.dart';
import 'Favourit.dart';

class Orders extends StatefulWidget {
  static String id = "Orders";

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // App Bar
  void _showRightPanel(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.topRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: EdgeInsets.only(top: 30, right: 10),
              width: MediaQuery.of(context).size.width * 0.6,
              height: 150,
              decoration: BoxDecoration(
                color: MyColors.dark_2,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'Status Colors:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.red, width: 2),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Order is being prepared',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.orange, width: 2),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Order is out for delivery',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.green, width: 2),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Order has arrived',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: MyColors.dark_1,
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: MyColors.dark_1,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showRightPanel(context);
            },
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
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
                      child: ButtonOfOrders(
                        date: '8/12/2024',
                        clock: '6:25',
                        onPressed: () {},
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
