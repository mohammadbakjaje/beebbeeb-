import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/constants.dart';
import '../../../helper/my_colors.dart';
import '../../../widget/ButtonOfStore.dart';
import '../../../widget/ButtonSearch.dart';
import '../../Drawer/ِCustomDrawer.dart';
import '../ProductsCubit/Bloc/search_cubit.dart';
import '../ProductsCubit/Bloc/search_states.dart';
import 'Bloc/store_details_cubit.dart';
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
      ),
      body: Container(
        child: ListView(
          children: [
            BlocBuilder<SearchCubit, SearchStates>(
              builder: (context, state) {
                return ButtonSearch(
                  hintText: "Search for stores",
                  onchanged: (query) {
                    context
                        .read<SearchCubit>()
                        .search(query: query, type: storesSearch);
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
                              padding: const EdgeInsets.only(top: 10),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "http://$ipv4/${store["logo"]}"),
                                  radius: 30, //
                                ),
                                title: Text(
                                  store["name"],
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: Text(
                                  "${store["address"]}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                } else if (state is SearchError) {
                  return Center(child: Text(state.message));
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
                        mainAxisExtent: 100,
                      ),
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 13, right: 13, top: 10),
                          child: ButtonOfStore(
                            text: cubit.data![i]['name'],
                            imagePath: cubit.data![i]['logo'],
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => StoreDetailsCubit()
                                      ..getOneStore(cubit.data![i]['id']),
                                    child: Stores2(),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is GetStoresLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(child: Text("Failed to get data"));
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
