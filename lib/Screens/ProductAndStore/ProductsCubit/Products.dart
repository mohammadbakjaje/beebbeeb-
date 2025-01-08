import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/my_colors.dart';
import '../../../widget/ButtonSearch.dart';
import '../../Drawer/ِCustomDrawer.dart';
import 'Bloc/product_details_cubit.dart';
import 'Bloc/products_cubit.dart';
import 'Bloc/prooducts_states.dart';
import 'Products2.dart';

class Products extends StatefulWidget {
  static String id = "Products";

  @override
  State<Products> createState() => _ProductsOfStoresState();
}

class _ProductsOfStoresState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getProducts(),
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: MyColors.dark_1,
          foregroundColor: Colors.white,
        ),
        backgroundColor: MyColors.dark_1,
        body: Padding(
          padding: EdgeInsets.only(right: 14, left: 14),
          child: Container(
            child: ListView(
              children: [
                ButtonSearch(
                    hintText: "Search",
                    prefixImage: Image.asset("images/search.png")),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "All Products",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Container(
                  height: 10,
                ),
                BlocBuilder<ProductCubit, ProductsState>(
                  builder: (context, state) {
                    ProductCubit cubit = BlocProvider.of<ProductCubit>(context);

                    if (state is GetProductsLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is GetProductsSuccessState) {
                      return GridView.builder(
                        itemCount: cubit.data!.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, mainAxisExtent: 307),
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => ProductDetailsCubit()
                                      ..getOneProduct(cubit.data![i]["id"]),
                                    child: Products2(),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.dark_2,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 220,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            topLeft: Radius.circular(8)),
                                        child: Image.network(
                                          cubit.data![i]["image"],
                                          height: 220,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        cubit.data![i]["description"],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            cubit.data![i]["price"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text("Failed to get data"));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
