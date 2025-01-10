import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled1/helper/constants.dart';

class Slideshow extends StatefulWidget {
  const Slideshow({super.key, required this.images});

  final List<String> images; // قائمة روابط الصور

  @override
  _SlideshowState createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_currentPage < widget.images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.images.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
          child: Image.network(
            "http://$ipv4/${widget.images[index]}", // استخدام الصورة من القائمة
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                  child:
                      Icon(Icons.error)); // عرض أيقونة خطأ إذا فشل تحميل الصورة
            },
          ),
        );
      },
    );
  }
}
