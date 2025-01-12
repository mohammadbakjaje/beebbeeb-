import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../helper/constants.dart';
import '../../../helper/my_colors.dart';
import '../../../widget/ButtonStores.dart';
import '../ProductsCubit/Bloc/product_details_cubit.dart';
import '../ProductsCubit/Products2.dart';
import 'Bloc/products_by_catigories_cubit.dart';
import 'Bloc/products_by_catigories_states.dart';
import 'Bloc/store_details_cubit.dart';
import 'Bloc/store_details_states.dart';

class Stores2 extends StatefulWidget {
  static String id = "Stores2";

  @override
  State<Stores2> createState() => Stores2State();
}

class Stores2State extends State<Stores2> {
  int activeButtonIndex = -1;
  double containerHeight = 0.0;

  void _onButtonPressed(int index, int categoryId) {
    setState(() {
      activeButtonIndex = index;
      containerHeight = MediaQuery.of(context).size.height * 0.55;
    });

    // جلب منتجات الفئة باستخدام الـ Cubit الجديد
    context
        .read<ProductsByCatigoriesCubit>()
        .fetchProductsByCategory(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark_1,
      appBar: AppBar(
        backgroundColor: MyColors.dark_1,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                child: BlocBuilder<StoreDetailsCubit, StoreDetailsState>(
                  builder: (BuildContext context, StoreDetailsState state) {
                    if (state is GetStoreDetailsLoadingState)
                      return Center(child: CircularProgressIndicator());
                    else if (state is GetStoreDetailsSuccessState) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [MyColors.dark_2, MyColors.dark_1],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // صورة المتجر
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "http://$ipv4/${state.store.logo}",
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.store,
                                        size: 100,
                                        color: Colors.white,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 16),
                                // معلومات المتجر
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.store.name,
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        state.store.address,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                        ),
                                        maxLines: 2, // تحديد عدد الأسطر
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Phone: ${state.store.phone}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
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
                    } else {
                      return Center(
                        child: Text(
                          "Failed to get Store",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: BlocBuilder<StoreDetailsCubit, StoreDetailsState>(
                    builder: (context, state) {
                      if (state is GetStoreDetailsSuccessState) {
                        return Row(
                          children: List.generate(
                            state.store.categories.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ButtonStores(
                                index: index,
                                text: state.store.categories[index].name,
                                onPressed: () {
                                  _onButtonPressed(
                                      index, state.store.categories[index].id);
                                },
                                activeButtonIndex: activeButtonIndex,
                                onButtonPressed: (index) {
                                  _onButtonPressed(
                                      index, state.store.categories[index].id);
                                },
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: containerHeight,
              decoration: BoxDecoration(
                color: MyColors.dark_1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: BlocBuilder<ProductsByCatigoriesCubit,
                  ProductsByCatigoriesStatesState>(
                builder: (context, state) {
                  if (state is GetProductsByCatigoriesLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GetProductsByCatigoriesSuccessState) {
                    return ListView(
                      padding: EdgeInsets.all(16),
                      children: [
                        GridView.builder(
                          itemCount: state.products.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemBuilder: (context, i) {
                            final product = state.products[i];
                            return Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) =>
                                            ProductDetailsCubit()
                                              ..getOneProduct(product.id),
                                        child: Products2(),
                                      ),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        MyColors.dark_2,
                                        MyColors.dark_1
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        child: Image.network(
                                          "http://$ipv4/${product.image}",
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          product.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${product.price}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            /* IconButton(
                                              onPressed: () {
                                                // إضافة أو إزالة المنتج من المفضلة
                                              },
                                              icon: Icon(Icons.favorite_outline,
                                                  color: Colors.white),
                                            ),*/
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
                  } else if (state is GetProductsByCatigoriesErrorState) {
                    return Center(
                      child: Text(
                        state.error,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
