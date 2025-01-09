import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:untitled1/Screens/ProductAndStore/ProductsCubit/Bloc/product_details_cubit.dart';

import '../../../helper/constants.dart';
import '../../../helper/my_colors.dart';
import 'Bloc/product_details_states.dart';



class Products2 extends StatelessWidget {
  static String id = "Products2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark_1, // استخدام اللون dark_1
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          ProductDetailsCubit cubit = BlocProvider.of<ProductDetailsCubit>(context);

          if (state is GetOneProductLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetOneProductSuccessState) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      "http://$ipv4/${cubit.product!.image}"
                     ,
                      fit: BoxFit.cover,
                    ),
                  ),
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
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            cubit.product!.description,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 20),
                          // نقل السعر وزر الإعجاب إلى هنا
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$${cubit.product!.price}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Quantity: ${cubit.product!.quantity}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              AnimatedOpacity(
                                opacity: cubit.isLiked ? 1.0 : 0.5,
                                duration: Duration(milliseconds: 300),
                                child: IconButton(
                                  onPressed: () {
                                    cubit.toggleLike();
                                  },
                                  icon: Icon(
                                    cubit.isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_outline_rounded,
                                    color: cubit.isLiked
                                        ? Colors.red
                                        : Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Product added to cart!"),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.buttun,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
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
          } else {
            return Center(child: Text("Failed to load product details"));
          }
        },
      ),
    );
  }
}