import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../helper/my_colors.dart';

class ProductDetails extends Cubit<ProductDetailsState> {
  ProductDetails() : super(GetOneProductLoadingState());

  bool isLiked = false;
  int quantity = 1;
  Product? product;

  void toggleLike() {
    isLiked = !isLiked;
    emit(GetOneProductSuccessState());
  }

  void increaseQuantity() {
    quantity++;
    emit(GetOneProductSuccessState());
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
      emit(GetOneProductSuccessState());
    }
  }

  void fetchProduct() async {

    await Future.delayed(Duration(seconds: 2));
    product = Product(
      name: "Product Name",
      description: "This is a sample product description.",
      price: 99.99,
      image: "https://via.placeholder.com/400",
    );
    emit(GetOneProductSuccessState());
  }
}


abstract class ProductDetailsState {}

class GetOneProductLoadingState extends ProductDetailsState {}

class GetOneProductSuccessState extends ProductDetailsState {}


class Product {
  final String name;
  final String description;
  final double price;
  final String image;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });
}

// واجهة المستخدم
class Products2 extends StatelessWidget {
  static String id = "Products2";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetails()..fetchProduct(),
      child: Scaffold(
        backgroundColor: MyColors.dark_1, // استخدام اللون dark_1
        body: BlocBuilder<ProductDetails, ProductDetailsState>(
          builder: (context, state) {
            ProductDetails cubit = BlocProvider.of<ProductDetails>(context);

            if (state is GetOneProductLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetOneProductSuccessState) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 250,
                    flexibleSpace: FlexibleSpaceBar(
                      background: CachedNetworkImage(
                        imageUrl: cubit.product!.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
                                      "Quantity: ${cubit.quantity}",
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
      ),
    );
  }
}