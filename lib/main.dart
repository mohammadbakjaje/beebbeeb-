import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import 'package:untitled1/Screens/Drawer/connectUs.dart';
import 'package:untitled1/Screens/HomePage/Ads/ad_product_cubit.dart';
import 'package:untitled1/Screens/HomePage/MostSells/most_sell_cubit.dart';
import 'package:untitled1/Screens/Layout/Added/Cart/add_cart_cubit.dart';
import 'package:untitled1/Screens/Layout/Added/Cart/delete_cart_cubit.dart';
import 'package:untitled1/Screens/Layout/Added/FavouriteEmpity.dart';
import 'package:untitled1/Screens/Layout/layout_screen.dart';
import 'package:untitled1/Screens/Login/login_page.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/products_cubit.dart';
import 'package:untitled1/Screens/SplashScreen/SplashScreen.dart';
import 'package:untitled1/Screens/register/bloc/register_cubit.dart';
import 'package:untitled1/Screens/register/register_page.dart';
import 'package:untitled1/Screens/reset_page.dart';
import 'package:untitled1/Screens/send_email_page.dart';
import 'package:untitled1/helper/local_network.dart';
import 'Screens/Drawer/ theme_provider.dart';
import 'Screens/Drawer/AboutUs.dart';
import 'Screens/Drawer/bloc/logout_cubit.dart';
import 'Screens/HomePage/HomePage.dart';
import 'Screens/HomePage/MostStores/most_stores_cubit.dart';
import 'Screens/Layout/Added/Cart.dart';
import 'Screens/Layout/Added/Cart/show_cart_cubit.dart';
import 'Screens/Layout/Added/Favorite/Favourit.dart';
import 'Screens/Layout/Added/Orders.dart';
import 'Screens/Layout/Layout_cubit/change_password_cubit.dart';
import 'Screens/Layout/Layout_cubit/layout_cubit.dart';
import 'Screens/Layout/Profile/Profile.dart';
import 'Screens/Layout/Profile/update_image_cubit/update_image_cubit.dart';
import 'Screens/Layout/Profile/update_user_cubit/update_user_cubit.dart';
import 'Screens/Login/bloc/login_cubit.dart';
import 'Screens/ProductAndStore/ProductsCubit/Bloc/search_cubit.dart';
import 'Screens/ProductAndStore/ProductsCubit/Products.dart';
import 'Screens/ProductAndStore/ProductsCubit/Products2.dart';
import 'Screens/ProductAndStore/StoresCubit/Bloc/products_by_catigories_cubit.dart';
import 'Screens/ProductAndStore/StoresCubit/Bloc/store_search_cubit.dart';
import 'Screens/ProductAndStore/StoresCubit/Bloc/stores_cubit.dart';
import 'Screens/ProductAndStore/StoresCubit/Stores.dart';
import 'Screens/ProductAndStore/StoresCubit/Stores2.dart';
import 'helper/constants.dart';
import 'helper/my_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cacheInitialization();
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
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => SearchStoreCubit()),
        BlocProvider(create: (context) => StoresCubit()..getStores()),
        BlocProvider(create: (context) => ChangePasswordCubit()),
        BlocProvider(create: (context) => UpdateUserCubit()),
        BlocProvider(create: (context) => UploadImageCubit()),
        BlocProvider(create: (context) => AdProductCubit()..fetchAdProducts()),
        BlocProvider(create: (context) => MostStoresCubit()..fetchStores()),
        BlocProvider(
            create: (context) => MostSellCubit()..fetchMostSellProducts()),
        BlocProvider(create: (context) => ProductsByCatigoriesCubit()),
        BlocProvider(create: (context) => AddCartCubit()),
        BlocProvider(create: (context) => ShowCartCubit()),
        BlocProvider(create: (context) => DeleteCartCubit()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // إضافة ThemeProvider
      ],
      child: MaterialApp(
        color: MyColors.dark_1,
        routes: {
          Orders.id: (context) => Orders(),
          Favourit.id: (context) => Favourit(),
          Cart.id: (context) => Cart(),
          Products.id: (context) => Products(),
          Stores.id: (context) => Stores(),
          HomePage.id: (context) => HomePage(),
          Profile.id: (context) => Profile(),
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ConnectUs.id: (context) => ConnectUs(),
          AboutUs.id: (context) => AboutUs(),
        },
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      ),
    );
  }
}