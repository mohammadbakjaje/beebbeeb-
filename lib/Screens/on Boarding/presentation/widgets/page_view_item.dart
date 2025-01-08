//import 'package:beb_beb/core/utils/size_config.dart';
//import 'package:beb_beb/features/on%20Boarding/presentation/widgets/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/Screens/on%20Boarding/presentation/widgets/space_widget.dart';

import '../../../../core/utils/size_config.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, this.title, this.subTitle, this.image});
  final String? title;
  final String? subTitle;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpace(20),
        SizedBox(
          height: SizeConfig.defaultSize! * 35,
          child: Lottie.asset(image!),
        ),
        VerticalSpace(0.5),
        Text(
          title!,
          style: TextStyle(
            fontSize: 20,
            color: Color(0xffffffff),
            fontWeight: FontWeight.w600,
          ),
        ),
        VerticalSpace(1),
        Text(
          subTitle!,
          style: TextStyle(
            fontSize: 15,
            color: Color(0xffffffff),
          ),
        )
      ],
    );
  }
}
