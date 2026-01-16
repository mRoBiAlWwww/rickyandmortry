import 'package:flutter/material.dart';
import 'package:robi/core/config/assets/app_images.dart';
import 'package:robi/core/config/theme/app_colors.dart';
import 'package:robi/core/wrapper/main_wrapper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainWrapper()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInOut,
          opacity: _opacity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: const Offset(-10.0, 0.0),
                child: Image.asset(AppImages.logo, width: 150, height: 150),
              ),
              SizedBox(height: 10),
              Text(
                "Ricky and Mortry App",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
