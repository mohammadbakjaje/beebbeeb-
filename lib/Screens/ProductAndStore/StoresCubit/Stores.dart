import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/my_colors.dart';
import '../../../widget/ButtonOfStore.dart';
import '../../../widget/ButtonSearch.dart';
import '../../Drawer/ِCustomDrawer.dart';
import '../ProductsCubit/Bloc/search_states.dart';
import 'Bloc/stores_State.dart';
import 'Bloc/stores_cubit.dart';
import 'Stores2.dart';

class Stores extends StatelessWidget {
  static String id = "Stores";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: MyColors.dark_1,
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: MyColors.dark_1,
          foregroundColor: Colors.white,
        ),
        body: Container(
          child: ListView(
            children: [
              ButtonSearch(
                onchanged: (data) {},
                hintText: "Search",
                prefixImage: Image.asset("images/search.png"),
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
                  builder:  (context, state) {
                    StoresCubit cubit = BlocProvider.of<StoresCubit>(context);
                    if(state is GetStoresSuccessState){
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
                                    builder: (context) => Stores2(),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                    else if(state is GetStoresLoadingState){
                      return Center(child: CircularProgressIndicator());
                    }
                    else {
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
      ),
    );
  }
}