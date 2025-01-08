//import 'package:beb_beb/core/utils/size_config.dart';
//import 'package:beb_beb/core/widgets/custom_button.dart';
//import 'package:beb_beb/features/on%20Boarding/presentation/widgets/custom_indicator.dart';
//import 'package:beb_beb/features/on%20Boarding/presentation/widgets/custom_page_view.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Screens/Login/login_page.dart';

import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../helper/local_network.dart';
import 'custom_indicator.dart';
import 'custom_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  PageController? pageController;
  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
    )..addListener(() {
        setState(() {});
      });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        CustomPageView(
          pageController: pageController,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: SizeConfig.defaultSize! * 20,
          child: CustomIndicator(
            //  Exception dotIndex: pageController?.page,
            dotIndex: pageController!.hasClients ? pageController?.page : 0,
          ),
        ),
        Visibility(
          visible: pageController!.hasClients
              ? (pageController?.page == 2 ? false : true)
              : true,
          child: Positioned(
            top: SizeConfig.defaultSize! * 10,
            right: 32,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
                CacheNetwork.insertBoolToCache(
                    key: "isFirstTime", value: false);
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: SizeConfig.defaultSize! * 9,
          right: SizeConfig.defaultSize! * 9,
          bottom: SizeConfig.defaultSize! * 10,
          child: CustomGeneralButton(
            onTap: () async {
              if (pageController!.page! < 2) {
                pageController?.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              } else {
                await CacheNetwork.insertBoolToCache(
                    key: "isFirstTime", value: false);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              }
            },
            text: pageController!.hasClients
                ? (pageController?.page == 2 ? 'Get Started' : 'Next')
                : 'Next',
          ),
        ),
      ],
    );
  }
}
