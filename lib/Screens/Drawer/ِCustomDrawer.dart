import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Screens/Drawer/AboutUs.dart';
import 'package:untitled1/Screens/Drawer/bloc/logout_state.dart';
import 'package:untitled1/Screens/Drawer/connectUs.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/layout_cubit.dart';
import 'package:untitled1/Screens/Login/login_page.dart';

import '../../helper/constants.dart';
import '../../helper/local_network.dart';
import '../../helper/my_colors.dart';
import '../Layout/Layout_cubit/layout_states.dart';
import '../Layout/Profile/Profile.dart';
import 'bloc/logout_cubit.dart';
import ' theme_provider.dart';


class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String token = CacheNetwork.getCacheData(key: "token");
    final themeProvider = Provider.of<ThemeProvider>(context);

    return BlocProvider(
      create: (BuildContext context) => LayoutCubit()..getUserData(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        builder: (BuildContext context, state) {
          return GestureDetector(
            onTap: () {
              BlocProvider.of<LayoutCubit>(context).getUserData();
            },
            child: Container(
              child: Drawer(
                backgroundColor: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkMode ? Colors.grey : MyColors.buttun,
                      ),
                      child: BlocBuilder<LayoutCubit, LayoutStates>(
                        builder: (context, state) {
                          var cubit = BlocProvider.of<LayoutCubit>(context);
                          if (state is GetUserDataSuccsesState) {
                            return Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                          "http://$ipv4/${cubit.userModel!.image!}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "${cubit.userModel!.firstname!} ${cubit.userModel!.lastname!}",
                                        style: TextStyle(
                                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${cubit.userModel!.phone!}',
                                      style: TextStyle(
                                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(
                                      themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                                      color: themeProvider.isDarkMode ? Colors.black : Colors.white,
                                    ),
                                    onPressed: () {
                                      themeProvider.toggleTheme();
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else if (state is GetUserDataLoadingState) {
                            return CircularProgressIndicator(
                              color: Colors.white,
                            );
                          } else {
                            return Text("Hello");
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, top: 7),
                      child: ListTile(
                        leading: Icon(Icons.person, color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                        title: Text('My Profile',
                            style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Profile()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, top: 7),
                      child: ListTile(
                        leading: Icon(Icons.info, color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                        title: Text('About Us',
                            style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AboutUs()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, top: 7),
                      child: ListTile(
                        leading: Icon(Icons.contact_mail, color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                        title: Text('Contact Us',
                            style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ConnectUs()));
                        },
                      ),
                    ),
                    BlocConsumer<LogoutCubit, LogoutState>(
                      builder: (BuildContext context, LogoutState state) {
                        if (state is LogoutLoadingState) {
                          return CircularProgressIndicator(
                            color: Colors.white,
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(left: 14, top: 7),
                            child: ListTile(
                              leading:
                              Icon(Icons.exit_to_app, color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                              title: Text('Logout',
                                  style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
                              onTap: () {

                                context.read<LogoutCubit>().logoutBloc(
                                    CacheNetwork.getCacheData(key: "token"));
                              },
                            ),
                          );
                        }
                      },
                      listener: (BuildContext context, LogoutState state) {
                        if (state is LogoutErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.errorMsg),
                          ));
                        }
                        if (state is LogoutSuccessState) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, top: 7),
                      child: ListTile(
                        leading:
                        Icon(Icons.cleaning_services, color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                        title: Text('Clear Cache',
                            style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
                        onTap: () async {
                          await CacheNetwork.clearCache();
                          SystemNavigator.pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, LayoutStates state) {},
      ),
    );
  }
}