import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import 'package:untitled1/Screens/Layout/Added/Cart/CartCubit/add_cart_cubit.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/layout_cubit.dart';
import 'package:untitled1/Screens/Layout/Layout_cubit/layout_states.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/product_details_cubit.dart';
import 'package:untitled1/helper/constants.dart';
import 'package:untitled1/helper/my_colors.dart';

import '../../Drawer/ theme_provider.dart';
import '../../Layout/Added/Cart/CartCubit/add_cart_states.dart';
import 'Bloc/product_details_states.dart';

class Products2 extends StatelessWidget {
  static String id = "Products2";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? MyColors.dark_1
          : Colors.white, // لون الخلفية بناءً على الوضع
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          ProductDetailsCubit cubit =
              BlocProvider.of<ProductDetailsCubit>(context);

          if (state is GetOneProductLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetOneProductSuccessState) {
            return BlocBuilder<LayoutCubit, LayoutStates>(
              builder: (context, layoutState) {
                final favouriteCubit = BlocProvider.of<LayoutCubit>(context);

                // استدعاء fetchFavourites عند تحميل الصفحة
                if (layoutState is! FavouriteLoadedState) {
                  favouriteCubit.fetchFavourites();
                }

                // فحص null قبل الوصول إلى item['product']['id']
                bool isFavourite = favouriteCubit.favouriteProducts.any((item) {
                  if (item != null && item['product'] != null) {
                    return item['product']['id'] == cubit.product!.id;
                  }
                  return false;
                });

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 400,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          "http://$ipv4/${cubit.product!.image}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      backgroundColor: themeProvider.isDarkMode
                          ? MyColors.dark_2
                          : Colors.grey[200], // لون AppBar بناءً على الوضع
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.product!.name,
                                style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors
                                          .black, // لون النص بناءً على الوضع
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                cubit.product!.description,
                                style: TextStyle(
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors
                                          .black, // لون النص بناءً على الوضع
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "\$${cubit.product!.price}",
                                        style: TextStyle(
                                          color: themeProvider.isDarkMode
                                              ? Colors.white
                                              : Colors
                                                  .black, // لون النص بناءً على الوضع
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Quantity: ${cubit.product!.quantity}",
                                        style: TextStyle(
                                          color: themeProvider.isDarkMode
                                              ? Colors.white
                                              : Colors
                                                  .black, // لون النص بناءً على الوضع
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      if (cubit.product != null) {
                                        if (isFavourite) {
                                          await favouriteCubit
                                              .removeFromFavourites(
                                                  cubit.product!.id);
                                        } else {
                                          await favouriteCubit.addToFavourites(
                                              cubit.product!.id);
                                        }
                                        // تحديث حالة المفضلة بعد الإضافة/الإزالة
                                        favouriteCubit.fetchFavourites();
                                      } else {
                                        print('Product is null');
                                      }
                                    },
                                    icon: Icon(
                                      isFavourite
                                          ? Icons.favorite
                                          : Icons.favorite_outline_rounded,
                                      color: isFavourite
                                          ? Colors.red
                                          : (themeProvider.isDarkMode
                                              ? Colors.white
                                              : Colors
                                                  .black), // لون الأيقونة بناءً على الوضع
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Spacer(),
                                  BlocConsumer<AddCartCubit, AddCartState>(
                                    builder: (BuildContext context,
                                        AddCartState state) {
                                      if (state is AddCartLoading) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return ElevatedButton(
                                          onPressed: () {
                                            BlocProvider.of<AddCartCubit>(
                                                    context)
                                                .addToCart(cubit.product!.id);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: MyColors
                                                .buttun, // لون الزر ثابت
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            "Add to Cart",
                                            style: TextStyle(
                                              color: Colors
                                                  .white, // لون النص داخل الزر
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    listener: (BuildContext context,
                                        AddCartState state) {
                                      if (state is AddCartSuccess) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration:
                                                const Duration(seconds: 3),
                                            content: Text(state.message),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      } else if (state is AddCartError) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              duration:
                                                  const Duration(seconds: 3),
                                              content: Text(
                                                state.error,
                                              )),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ],
                );
              },
            );
          } else {
            return Center(
              child: Text(
                "Failed to load product details",
                style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? Colors.white
                      : Colors.black, // لون النص بناءً على الوضع
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
