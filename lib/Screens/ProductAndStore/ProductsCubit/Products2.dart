import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // تأكد من استيراد provider

import '../../../helper/constants.dart';
import '../../../helper/my_colors.dart';
import '../../Drawer/ theme_provider.dart'; // تأكد من أن هذا المسار صحيح
import '../../Layout/Added/Cart/CartCubit/add_cart_cubit.dart';
import '../../Layout/Added/Cart/CartCubit/add_cart_states.dart';
import '../../Layout/Added/Favorite/Cubit/Add_remove_favourite.dart';
import '../../Layout/Added/Favorite/Cubit/Check_if_favourite_state.dart';
import '../../Layout/Added/Favorite/Cubit/check_if_favourite_cubit.dart';
import '../../Layout/Layout_cubit/layout_cubit.dart';
import '../../Layout/Layout_cubit/layout_states.dart';
import 'Bloc/product_details_cubit.dart';
import 'Bloc/product_details_states.dart';

class Products2 extends StatefulWidget {
  static String id = "Products2";

  @override
  _Products2State createState() => _Products2State();
}

class _Products2State extends State<Products2> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = BlocProvider.of<ProductDetailsCubit>(context);
      final productId = cubit.product?.id; // استخدام ? بدلاً من !
      if (productId != null) {
        context.read<CheckIfFavouriteCubit>().checkIfFavourite(productId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return BlocListener<ProductDetailsCubit, ProductDetailsState>(
      listener: (BuildContext context, ProductDetailsState state) {
        if (state is GetOneProductSuccessState) {
          context.read<CheckIfFavouriteCubit>().checkIfFavourite(
              BlocProvider.of<ProductDetailsCubit>(context).product!.id);
        }
      },
      child: Scaffold(
        backgroundColor:
            themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            ProductDetailsCubit cubit =
                BlocProvider.of<ProductDetailsCubit>(context);

            if (state is GetOneProductLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetOneProductSuccessState) {
              if (cubit.product == null) {
                return Center(
                  child: Text("Product not found"),
                );
              }

              return BlocBuilder<LayoutCubit, LayoutStates>(
                builder: (context, layoutState) {
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
                            : Colors.grey[200],
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
                                        : Colors.black,
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
                                        : Colors.black,
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
                                                : Colors.black,
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
                                                : Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    BlocBuilder<CheckIfFavouriteCubit,
                                        CheckIfFavouriteState>(
                                      builder: (BuildContext context, state) {
                                        if (state is FavouriteChecked) {
                                          if (state.isFavourite == true) {
                                            return IconButton(
                                              onPressed: () async {
                                                await context
                                                    .read<
                                                        AddRemoveFavouriteCubit>()
                                                    .removeFromFavourites(
                                                        cubit.product!.id);
                                                context
                                                    .read<
                                                        CheckIfFavouriteCubit>()
                                                    .checkIfFavourite(
                                                        cubit.product!.id);
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 30,
                                              ),
                                            );
                                          } else {
                                            return IconButton(
                                              onPressed: () async {
                                                await context
                                                    .read<
                                                        AddRemoveFavouriteCubit>()
                                                    .addToFavourites(
                                                        cubit.product!.id);
                                                context
                                                    .read<
                                                        CheckIfFavouriteCubit>()
                                                    .checkIfFavourite(
                                                        cubit.product!.id);
                                              },
                                              icon: Icon(
                                                Icons.favorite_outline_rounded,
                                                color:
                                                    (themeProvider.isDarkMode)
                                                        ? Colors.white
                                                        : Colors.black,
                                                size: 30,
                                              ),
                                            );
                                          }
                                        } else if (state
                                            is CheckIfFavouriteLoading) {
                                          return CircularProgressIndicator();
                                        } else {
                                          return Text(".");
                                        }
                                      },
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
                                              backgroundColor: MyColors.buttun,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: Text(
                                              "Add to Cart",
                                              style: TextStyle(
                                                color: Colors.white,
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
                                              content: Text(state.error),
                                            ),
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
                    color:
                        themeProvider.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
