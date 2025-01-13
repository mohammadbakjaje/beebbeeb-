import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import '../../../helper/constants.dart';
import '../../../helper/my_colors.dart';
import '../../../widget/ButtonSearch.dart';
import '../../Drawer/ theme_provider.dart';
import '../../Drawer/ِCustomDrawer.dart';
import 'Bloc/product_details_cubit.dart';
import 'Bloc/products_cubit.dart';
import 'Bloc/prooducts_states.dart';
import 'Bloc/search_cubit.dart';
import 'Bloc/search_states.dart';
import 'Products2.dart';


class Products extends StatefulWidget {
  static String id = "Products";

  @override
  State<Products> createState() => _ProductsOfStoresState();
}

class _ProductsOfStoresState extends State<Products> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // الوصول إلى ThemeProvider

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit()..getProducts()),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
          foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
          elevation: 0, // إزالة الظل من AppBar
        ),
        backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white,
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
          child: Padding(
            padding: EdgeInsets.only(right: 14, left: 14),
            child: Container(
              child: ListView(
                children: [
                  BlocBuilder<SearchCubit, SearchStates>(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "All Products",
                      style: TextStyle(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  BlocBuilder<ProductCubit, ProductsState>(
                    builder: (context, state) {
                      ProductCubit cubit =
                      BlocProvider.of<ProductCubit>(context);

                      if (state is GetProductsLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                          ),
                        );
                      } else if (state is GetProductsSuccessState) {
                        return GridView.builder(
                          itemCount: cubit.data!.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 307,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
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
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 220,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15),
                                          ),
                                          child: Image.network(
                                            "http://$ipv4/${cubit.data![i]["image"]}",
                                            height: 220,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 10),
                                        child: Text(
                                          cubit.data![i]["name"],
                                          style: TextStyle(
                                            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "\$${cubit.data![i]["price"]}",
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
                        return Center(
                          child: Text(
                            "Failed to get data",
                            style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}