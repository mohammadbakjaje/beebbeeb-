import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/my_colors.dart';
import 'Bloc/product_details_cubit.dart';
import 'Bloc/product_details_states.dart';

class Products2 extends StatelessWidget {
  static String id = "Products2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark_1,
      appBar: AppBar(
        backgroundColor: MyColors.dark_1,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          ProductDetailsCubit cubit =
              BlocProvider.of<ProductDetailsCubit>(context);

          if (state is GetOneProductLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetOneProductSuccessState) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                    child: Image.network(
                      cubit.product!.image,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    cubit.product!.description,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    cubit.product!.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 270),
                  child: IconButton(
                    onPressed: () {
                      // تغيير حالة الإعجاب
                    },
                    icon: Icon(Icons.favorite_outline_rounded),
                  ),
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
