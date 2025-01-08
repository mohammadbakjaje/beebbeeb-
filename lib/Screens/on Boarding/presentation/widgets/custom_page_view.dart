import 'package:flutter/widgets.dart';
import 'package:untitled1/Screens/on%20Boarding/presentation/widgets/page_view_item.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({super.key, @required this.pageController});
  final PageController? pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        PageViewItem(
          image: 'images/Cart_pageView.json',
          title: 'E Shopping',
          subTitle: 'Find it all ,Get it delivered',
        ),
        PageViewItem(
          image: 'images/deliveryonway_PageView.json',
          title: 'On its Way',
          subTitle: 'Your Order Moving',
        ),
        PageViewItem(
          image: 'images/deliverednew_PageView.json',
          title: 'Delivered!',
          subTitle: 'Enjoy Your Purchase!',
        ),
      ],
    );
  }
}
