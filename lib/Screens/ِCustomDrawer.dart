import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper/local_network.dart';
import '../helper/my_colors.dart';
import 'Profile.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyColors.dark_2,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('images/20190327_201348.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'Malak Mobark',
                    style: TextStyle(
                      color: MyColors.dark_2,
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  '0995658340',
                  style: TextStyle(
                    color: MyColors.dark_2,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 7),
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text('My Profile', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 7),
            child: ListTile(
              leading: Icon(Icons.info, color: Colors.white),
              title: Text('About Us', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 7),
            child: ListTile(
              leading: Icon(Icons.contact_mail, color: Colors.white),
              title: Text('Contact Us', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 7),
            child: ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.white),
              title: Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 7),
            child: ListTile(
              leading: Icon(Icons.cleaning_services, color: Colors.white),
              title: Text('Clear Cache', style: TextStyle(color: Colors.white)),
              onTap: () async {
                await CacheNetwork.clearCache();
                SystemNavigator.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
