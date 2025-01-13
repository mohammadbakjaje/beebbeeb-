import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Screens/Layout/Added/Cart/add_cart_cubit.dart';
import 'package:untitled1/helper/constants.dart';
import 'package:untitled1/helper/my_colors.dart';
import 'package:untitled1/Screens/Drawer/ِCustomDrawer.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Products2.dart';
import '../../../Drawer/ theme_provider.dart';
import '../../../ProductAndStore/ProductsCubit/Bloc/product_details_cubit.dart';
import '../../Layout_cubit/layout_cubit.dart';
import '../../Layout_cubit/layout_states.dart';

class Favourit extends StatefulWidget {
  static String id = "Favourit";

  @override
  State<Favourit> createState() => _FavouritState();
}

class _FavouritState extends State<Favourit> {
  bool lovely = false;
  Icon favorite = Icon(
    Icons.favorite,
    color: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
      appBar: AppBar(
        title: Text(
          "My Favourite things",
          style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.white,
        backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : MyColors.buttun,
      ),
      body: BlocBuilder<LayoutCubit, LayoutStates>(
        builder: (BuildContext context, LayoutStates state) {
          if (state is FavouriteLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavouriteLoadedState) {
            final favourites = state.favouriteProducts;
            return ListView(
              children: [
                GridView.builder(
                  itemCount: favourites.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, mainAxisExtent: 100),
                  itemBuilder: (context, i) {
                    final product =
                    favourites[i]["product"];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => ProductDetailsCubit()
                                ..getOneProduct(product["id"]),
                              child: Products2(),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[300]!,
                            ),
                            color: themeProvider.isDarkMode ? MyColors.dark_2 : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 100,
                          width: 100,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Container(
                                      height: 65,
                                      width: 65,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                        child: Image.network(
                                          "http://$ipv4/${product["image"]}",
                                          height: 220,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product["name"],
                                          style: TextStyle(
                                              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${product["price"]}\$",
                                          style: TextStyle(
                                            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              BlocProvider.of<AddCartCubit>(
                                                  context)
                                                  .addToCart(product["id"]);
                                            },
                                            icon: Icon(
                                              Icons.shopping_cart,
                                              size: 25,
                                            ),
                                            color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون الأيقونة بناءً على الوضع
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                {
                                                  // إزالة المنتج من المفضلة
                                                  final productId =
                                                  product["id"];
                                                  context
                                                      .read<LayoutCubit>()
                                                      .removeFromFavourites(
                                                      productId);
                                                }
                                              },
                                              icon: Icon(
                                                size: 25,
                                                Icons.favorite,
                                                color: Colors.red, // لون الأيقونة بناءً على الوضع
                                              )),
                                        ],
                                      ),
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
            );
          } else if (state is FavouriteErrorState) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}