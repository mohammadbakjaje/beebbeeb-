import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/constants.dart';
import '../../../helper/my_colors.dart';
import '../../../widget/ButtonOfStore.dart';
import '../../../widget/ButtonSearch.dart';
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
    return Scaffold(
      backgroundColor: MyColors.dark_1,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: MyColors.dark_1,
        foregroundColor: Colors.white,
        elevation: 0, // إزالة الظل من AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [MyColors.dark_1, MyColors.dark_2],
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
                        style: TextStyle(color: Colors.white),
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
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        MyColors.dark_2.withOpacity(0.8),
                                        MyColors.dark_1.withOpacity(0.8),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
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
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      store["address"],
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white70,
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
                      style: TextStyle(color: Colors.white),
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
                  color: Colors.white,
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
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Failed to get data",
                        style: TextStyle(color: Colors.white),
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
