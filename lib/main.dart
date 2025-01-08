import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Screens/Drawer/connectUs.dart';
import 'package:untitled1/Screens/Login/login_page.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/products_cubit.dart';
import 'package:untitled1/Screens/SplashScreen/SplashScreen.dart';
import 'package:untitled1/Screens/register/bloc/register_cubit.dart';
import 'package:untitled1/Screens/register/register_page.dart';
import 'package:untitled1/Screens/reset_page.dart';
import 'package:untitled1/Screens/send_email_page.dart';
import 'package:untitled1/helper/local_network.dart';
import 'Screens/Added/Cart.dart';
import 'Screens/Added/CartEmpity.dart';
import 'Screens/Added/Favourit.dart';
import 'Screens/Added/Orders.dart';
import 'Screens/Drawer/AboutUs.dart';
import 'Screens/Drawer/bloc/logout_cubit.dart';
import 'Screens/HomePage/HomePage.dart';
import 'Screens/Layout/Layout_cubit/layout_cubit.dart';
import 'Screens/Layout/Profile/Profile.dart';
import 'Screens/Login/bloc/login_cubit.dart';
import 'Screens/ProductAndStore/ProductsCubit/Products.dart';
import 'Screens/ProductAndStore/ProductsCubit/Products2.dart';
import 'Screens/ProductAndStore/Stores.dart';
import 'Screens/ProductAndStore/Stores2.dart';
import 'helper/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(BebBeb());
}

class BebBeb extends StatelessWidget {
  const BebBeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LogoutCubit()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(
            create: (BuildContext context) => LayoutCubit()..getUserData()),
        BlocProvider(
            create: (BuildContext context) => ProductCubit()..getProducts()),
      ],
      child: MaterialApp(
          routes: {
            Orders.id: (context) => Orders(),
            Favourit.id: (context) => Favourit(),
            Cart.id: (context) => Cart(),
            Products.id: (context) => Products(),
            Stores.id: (context) => Stores(),
            Stores2.id: (context) => Stores2(),
            HomePage.id: (context) => HomePage(),
            Profile.id: (context) => Profile(),
            LoginPage.id: (context) => LoginPage(),
            RegisterPage.id: (context) => RegisterPage(),
            ConnectUs.id: (context) => ConnectUs(),
            AboutUs.id: (context) => AboutUs(),
          },
          debugShowCheckedModeBanner: false,
          // home: token != null && token != "" ? HomePage() : LoginPage(),
          home: Splashscreen()),
    );
  }
}
