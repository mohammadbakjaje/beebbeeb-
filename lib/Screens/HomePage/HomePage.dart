import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/Screens/HomePage/MostSells/most_sell_cubit.dart';
import 'package:untitled1/Screens/HomePage/MostSells/most_sell_state.dart';
import 'package:untitled1/Screens/HomePage/MostStores/most_stores_cubit.dart';
import 'package:untitled1/Screens/HomePage/MostStores/most_stores_state.dart';
import 'package:untitled1/helper/constants.dart';
import 'package:untitled1/helper/my_colors.dart';
import 'package:untitled1/widget/ButtonSearch.dart';
import 'package:untitled1/widget/coustembutonm.dart';
import 'package:untitled1/Screens/Added/Cart.dart';
import 'package:untitled1/Screens/Added/Favourit.dart';
import 'package:untitled1/Screens/Added/Orders.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/product_details_cubit.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/search_cubit.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/search_states.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Products.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Products2.dart';
import 'package:untitled1/Screens/ProductAndStore/StoresCubit/Stores.dart';
import 'package:untitled1/Screens/Drawer/ِCustomDrawer.dart';

import '../ProductAndStore/StoresCubit/Bloc/store_details_cubit.dart';
import '../ProductAndStore/StoresCubit/Stores2.dart';
import 'Ads/ad_product_cubit.dart';
import 'Ads/ad_product_state.dart';
import 'HomePage2.dart';
import 'Slideshow.dart';

class HomePage extends StatefulWidget {
  static String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.dark_1,
          foregroundColor: Colors.white,
          elevation: 0, // إزالة الظل من AppBar
        ),
        drawer: CustomDrawer(),
        backgroundColor: MyColors.dark_1,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyColors.dark_1, MyColors.dark_2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListView(
            children: [
              // حقل البحث
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                          style: TextStyle(color: Colors.white),
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
                                        colors: [
                                          MyColors.dark_2.withOpacity(0.8),
                                          MyColors.dark_1.withOpacity(0.8),
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
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "\$${product["price"]}",
                                        style: TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white70,
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
                        style: TextStyle(color: Colors.white),
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
                            colors: [
                              MyColors.buttun.withOpacity(0.8),
                              MyColors.buttun.withOpacity(0.6),
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
                            colors: [
                              MyColors.buttun.withOpacity(0.8),
                              MyColors.buttun.withOpacity(0.6),
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
              Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              // Slideshow
              Container(
                height: 223,
                width: 324,
                child: BlocProvider(
                  create: (context) => AdProductCubit()..fetchAdProducts(),
                  child: BlocBuilder<AdProductCubit, AdProductState>(
                    builder: (BuildContext context, AdProductState state) {
                      if (state is AdProductLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is AdProductLoaded) {
                        final images = state.images; // الحصول على قائمة الصور
                        return Slideshow(
                            images: images); // تمرير الصور إلى العرض الشرائح
                      } else if (state is AdProductError) {
                        return Center(child: Text(state.message));
                      } else {
                        return Center(child: Text('No data available'));
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 30),
              // العنوان: Most Requested Products
              Text(
                "Most Requested Products",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Colors.white,
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
                                    colors: [
                                      MyColors.dark_2.withOpacity(0.8),
                                      MyColors.dark_1.withOpacity(0.8),
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
                                          color: Colors.white,
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
                                          color: Colors.white,
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
                  color: Colors.white,
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
                                      ..getOneStore(stores[i]["id"]),
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
                                    colors: [
                                      MyColors.dark_2.withOpacity(0.8),
                                      MyColors.dark_1.withOpacity(0.8),
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
                                          color: Colors.white,
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
                                          color: Colors.white,
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
