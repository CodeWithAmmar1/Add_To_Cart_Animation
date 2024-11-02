import 'package:flutter/material.dart';
import 'package:getx/utils/color_constrain.dart';
import 'package:getx/view/home_screen.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _showLottie = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showLottie = true;
      });

      Future.delayed(const Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstrain.primary,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: _showLottie ? 0.0 : 1.0,
                  duration: const Duration(seconds: 1),
                  child: Container(
                    width: 250,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: AssetImage("assets/Homelogo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (_showLottie)
                  Center(
                    child: Hero(
                      tag: "logo",
                      child: Container(
                        margin: EdgeInsets.only(right: 150),
                        width: 100,
                        height: 200,
                        child: Lottie.asset(
                          'assets/Animation - 1730568046767.json',
                          fit: BoxFit.cover,
                          repeat: true,
                          reverse: false,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
