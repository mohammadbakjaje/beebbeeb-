import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Screens/HomePage/HomePage.dart';

import '../../helper/constants.dart';
import '../../helper/local_network.dart';
import '../Login/login_page.dart';

class MovingImage extends StatefulWidget {
  @override
  _MovingImageState createState() => _MovingImageState();
}

class _MovingImageState extends State<MovingImage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;
  AudioPlayer? _audioPlayer;
  String? token;

  @override
  void initState() {
    super.initState();

    // Initialize AudioPlayer
    _audioPlayer = AudioPlayer();

    // Initialize AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..repeat(); // Repeat the animation without reversing

    // Define the animation from left to right
    _animation = Tween<Offset>(
      begin: Offset(-1.2, 0.0), // Start from the left
      end: Offset(1.2, 0.0), // Move to the right
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeOut,
    ));

    // تشغيل الصوت فورًا عند استدعاء الواجهة
    _playSound();

    // تأخير التنقل بين الصفحات
    _navigateAfterDelay();
  }

  // تأخير التنقل بين الصفحات
  Future<void> _navigateAfterDelay() async {
    await Future.delayed(Duration(seconds: 6));
    await CacheNetwork.cacheInitialization();
    setState(() {
      token = CacheNetwork.getCacheData(key: "token");
    });
    print("token is $token");

    if (token == null || token!.isEmpty) {
      print("navigater to LoginPage");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } else {
      print("navigater to HomePage");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  // Play the sound
  Future<void> _playSound() async {
    if (_audioPlayer == null) {
      print('AudioPlayer is not initialized');
      return;
    }
    try {
      await _audioPlayer!.play(AssetSource('bebbebnew.wav'));
      print('Sound played successfully');
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    _audioPlayer!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: _animation!,
        child: Image.asset(
          'images/beeb beeb.gif',
          height: 300,
          width: 300,
        ),
      ),
    );
  }
}
