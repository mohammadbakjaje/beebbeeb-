import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // أضف هذا الاستيراد
import '../../../helper/constants.dart';
import '../../../helper/my_colors.dart';
import '../../../widget/ButtonOfStore.dart';
import '../../../widget/ButtonSearch.dart';
import '../../Drawer/ theme_provider.dart';
import '../../Drawer/ِCustomDrawer.dart';
import 'Bloc/store_details_cubit.dart';
import 'Bloc/store_search_cubit.dart';
import 'Bloc/store_search_states.dart';
import 'Bloc/stores_State.dart';
import 'Bloc/stores_cubit.dart';
import 'Stores2.dart';

class Stores extends StatelessWidget {
  static String id = "Stores";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // استخدم ThemeProvider

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white, // لون الخلفية بناءً على الوضع
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? MyColors.dark_1 : Colors.white, // لون AppBar بناءً على الوضع
        foregroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون العناصر الأمامية بناءً على الوضع
        elevation: 0, // إزالة الظل من AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: themeProvider.isDarkMode
                ? [MyColors.dark_1, MyColors.dark_2] // الألوان في الوضع الليلي
                : [Colors.white, Colors.grey[300]!], // الألوان في الوضع النهاري
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<SearchStoreCubit, SearchStoreStates>(
                builder: (context, state) {
                  return ButtonSearch(
                    hintText: "Search for stores",
                    onchanged: (query) {
                      context
                          .read<SearchStoreCubit>()
                          .searchStore(query: query);
                    },
                    prefixImage: Image.asset("images/search.png"),
                  );
                },
              ),
            ),
            BlocBuilder<SearchStoreCubit, SearchStoreStates>(
              builder: (context, state) {
                if (state is SearchStoreSuccess) {
                  if (state.data.isEmpty) {
                    return Center(
                      child: Text(
                        "No results found",
                        style: TextStyle(
                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            final store = state.data[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Card(
                                color: themeProvider.isDarkMode
                                    ? MyColors.dark_2
                                    :  Colors.grey[700],
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: themeProvider.isDarkMode
                                        ? MyColors.dark_2
                                        :  Colors.grey[700],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "http://$ipv4/${store["logo"]}"),
                                      radius: 30,
                                    ),
                                    title: Text(
                                      store["name"],
                                      style: TextStyle(
                                        color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون النص بناءً على الوضع
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      store["address"],
                                      style: TextStyle(
                                        color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54, // لون النص بناءً على الوضع
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54, // لون الأيقونة بناءً على الوضع
                                    ),
                                    onTap: () {
                                      // الانتقال إلى صفحة تفاصيل المتجر
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) =>
                                            StoreDetailsCubit()
                                              ..fetchStoreDetails(
                                                  store["id"]),
                                            child: Stores2(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                } else if (state is SearchStoreError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون النص بناءً على الوضع
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "All Stores",
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون النص بناءً على الوضع
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              height: 1000,
              child: BlocBuilder<StoresCubit, StoresState>(
                builder: (context, state) {
                  StoresCubit cubit = BlocProvider.of<StoresCubit>(context);
                  if (state is GetStoresSuccessState) {
                    return GridView.builder(
                      itemCount: cubit.data!.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisExtent: 120,
                      ),
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ButtonOfStore(
                              text: cubit.data![i]['name'],
                              imagePath: cubit.data![i]['logo'],
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => StoreDetailsCubit()
                                        ..fetchStoreDetails(
                                            cubit.data![i]['id']),
                                      child: Stores2(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is GetStoresLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون الـ CircularProgressIndicator بناءً على الوضع
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Failed to get data",
                        style: TextStyle(
                          color: themeProvider.isDarkMode ? Colors.white : Colors.black, // لون النص بناءً على الوضع
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}