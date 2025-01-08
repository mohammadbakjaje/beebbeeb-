import 'package:flutter/material.dart';

import '../../../helper/my_colors.dart';
import 'Widgets/on_boarding_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark_1,
      body: OnBoardingViewBody(),
    );
  }
}
