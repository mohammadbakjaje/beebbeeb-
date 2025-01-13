import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import 'package:untitled1/Screens/HomePage/MostSells/most_sell_cubit.dart';
import 'package:untitled1/Screens/HomePage/MostSells/most_sell_state.dart';
import 'package:untitled1/Screens/HomePage/MostStores/most_stores_cubit.dart';
import 'package:untitled1/Screens/HomePage/MostStores/most_stores_state.dart';
import 'package:untitled1/helper/constants.dart';
import 'package:untitled1/helper/my_colors.dart';
import 'package:untitled1/widget/ButtonSearch.dart';
import 'package:untitled1/widget/coustembutonm.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/product_details_cubit.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/search_cubit.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/search_states.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Products.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Products2.dart';
import 'package:untitled1/Screens/ProductAndStore/StoresCubit/Stores.dart';
import 'package:untitled1/Screens/Drawer/ِCustomDrawer.dart';
import '../Drawer/ theme_provider.dart';
import '../ProductAndStore/StoresCubit/Bloc/store_details_cubit.dart';
import '../ProductAndStore/StoresCubit/Stores2.dart';
import 'Ads/ad_product_cubit.dart';
import 'Ads/ad_product_state.dart';
import 'Slideshow.dart';

class HomePage extends StatefulWidget {
  static String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white70,
          foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
          elevation: 0,
        ),
        drawer: CustomDrawer(),
        backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white70,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: themeProvider.isDarkMode
                  ? [MyColors.dark_1, MyColors.dark_2]
                  : [Colors.white, Colors.grey[200]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                child: BlocBuilder<SearchCubit, SearchStates>(
                  builder: (context, state) {
                    return ButtonSearch(
                      hintText: "Search for products",
                      onchanged: (query) {
                        context
                            .read<SearchCubit>()
                            .search(query: query, type: productsSearch);
                      },
                      prefixImage: Image.asset("images/search.png"),
                    );
                  },
                ),
              ),
              // نتائج البحث
              BlocBuilder<SearchCubit, SearchStates>(
                builder: (context, state) {
                  if (state is SearchSuccess) {
                    if (state.data.isEmpty) {
                      return Center(
                        child: Text(
                          "No results found",
                          style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.data.length,
                            itemBuilder: (context, index) {
                              final product = state.data[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: themeProvider.isDarkMode
                                            ? [
                                          MyColors.dark_2.withOpacity(0.8),
                                          MyColors.dark_1.withOpacity(0.8),
                                        ]
                                            : [
                                          Colors.grey[200]!,
                                          Colors.grey[300]!,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (context) =>
                                              ProductDetailsCubit()
                                                ..getOneProduct(
                                                    product["id"]),
                                              child: Products2(),
                                            ),
                                          ),
                                        );
                                      },
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "http://$ipv4/${product["image"]}"),
                                        radius: 30,
                                      ),
                                      title: Text(
                                        product["name"],
                                        style: TextStyle(
                                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "\$${product["price"]}",
                                        style: TextStyle(
                                          color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54,
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  } else if (state is SearchError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              // الأزرار الرئيسية
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14, right: 19),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: themeProvider.isDarkMode
                                ? [
                              MyColors.buttun.withOpacity(0.8),
                              MyColors.buttun.withOpacity(0.6),
                            ]
                                : [
                              Colors.grey.withOpacity(0.8),
                              Colors.grey.withOpacity(0.6),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Products.id);
                            setState(() {});
                          },
                          child: Text(
                            "Products",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 14, left: 19),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: themeProvider.isDarkMode
                                ? [
                              MyColors.buttun.withOpacity(0.8),
                              MyColors.buttun.withOpacity(0.6),
                            ]
                                : [
                              Colors.grey.withOpacity(0.8),
                              Colors.grey.withOpacity(0.6),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Stores.id);
                            setState(() {});
                          },
                          child: Text(
                            "Stores",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // العنوان: Categories
              Expanded(child: Padding(
                padding: const EdgeInsets.only(left: 230),
                child: Text("Sale 50%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.orange),),
              )),
              SizedBox(height: 10),
              // Slideshow
              Container(
                height: 340,
                width: 324,
                child:  Slideshow(
                  images: [
                    "images/Picsart_25-01-11_21-09-43-611.jpg",
                    "images/Picsart_25-01-11_21-12-20-017.jpg",
                    "images/Picsart_25-01-11_21-14-53-173.jpg",
                    "images/Picsart_25-01-11_21-22-38-802.jpg",
                    "images/Picsart_25-01-11_21-11-21-699.jpg",
                    "images/Picsart_25-01-11_21-15-24-192.jpg",
                    "images/Picsart_25-01-11_21-16-07-052.jpg",
                    "images/Picsart_25-01-11_21-17-36-397.jpg",
                    "images/Picsart_25-01-11_21-21-39-517.jpg",
                    "images/Picsart_25-01-11_21-24-48-411.jpg",
                  ],
                ),
              ),
              SizedBox(height: 20),
              // العنوان: Most Requested Products
              Text(
                "Most Requested Products",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 20),
              // قائمة المنتجات الأكثر طلبًا
              Container(
                height: 310,
                child: BlocBuilder<MostSellCubit, MostSellState>(
                  builder: (BuildContext context, MostSellState state) {
                    if (state is MostSellLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is MostSellLoaded) {
                      final products = state.products;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => ProductDetailsCubit()
                                      ..getOneProduct(products[i]["id"]),
                                    child: Products2(),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: themeProvider.isDarkMode
                                        ? [
                                      MyColors.dark_2.withOpacity(0.8),
                                      MyColors.dark_1.withOpacity(0.8),
                                    ]
                                        : [
                                      Colors.grey[200]!,
                                      Colors.grey[300]!,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 281,
                                width: 159,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                      ),
                                      child: Image.network(
                                        "http://$ipv4/${products[i]["image"]}",
                                        height: 220,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        products[i]["name"],
                                        style: TextStyle(
                                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 10),
                                      child: Text(
                                        products[i]["price"],
                                        style: TextStyle(
                                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
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
                    } else if (state is MostSellError) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
              SizedBox(height: 30),
              // العنوان: Most Popular Stores
              Text(
                "Most Popular Stores",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 20),
              // قائمة المتاجر الأكثر شعبية
              Container(
                height: 310,
                child: BlocBuilder<MostStoresCubit, MostStoresState>(
                  builder: (BuildContext context, MostStoresState state) {
                    if (state is StoresLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is StoresLoaded) {
                      final stores = state.stores;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: stores.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => StoreDetailsCubit()
                                      ..fetchStoreDetails(stores[i]["id"]),
                                    child: Stores2(),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: themeProvider.isDarkMode
                                        ? [
                                      MyColors.dark_2.withOpacity(0.8),
                                      MyColors.dark_1.withOpacity(0.8),
                                    ]
                                        : [
                                      Colors.grey[200]!,
                                      Colors.grey[300]!,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 281,
                                width: 159,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                      ),
                                      child: Image.network(
                                          "http://$ipv4/${stores[i]['logo']}"),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        stores[i]['name'],
                                        style: TextStyle(
                                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 10),
                                      child: Text(
                                        stores[i]["address"],
                                        style: TextStyle(
                                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
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
                    } else {
                      return Text("cant fetch data");
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}