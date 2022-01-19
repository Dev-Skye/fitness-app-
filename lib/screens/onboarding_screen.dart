import 'package:fitnessapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pages = [
    PageViewModel(
      title: "Aerobics",
      body:
          "Aerobic activities condition your heart and lungs. The purpose of aerobic conditioning is to increase the amount of oxygen that is delivered to your muscles, which allows them to work longer.",
      image: Center(child: Image.asset("assets/screen01.jpg", height: 175.0)),
      decoration: const PageDecoration(
          pageColor: Color(0xFF151c52),
          bodyTextStyle: TextStyle(color: Colors.white, fontSize: 16),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24)),
    ),
    PageViewModel(
      title: "Strengthening",
      body:
          "Muscle Strengthening builds endurance. Weight training or simple exercises such as push-ups are two examples.",
      image: Center(child: Image.asset("assets/screen02.jpg", height: 175.0)),
      decoration: const PageDecoration(
          pageColor: Color(0xFF151c52),
          bodyTextStyle: TextStyle(color: Colors.white, fontSize: 16),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24)),
    ),
    PageViewModel(
      title: "Flexibility",
      body:
          "Flexibility is a result of physical activity. Flexibility comes from stretching.",
      image: Center(child: Image.asset("assets/screen03.jpg", height: 175.0)),
      decoration: const PageDecoration(
          pageColor: Color(0xFF151c52),
          bodyTextStyle: TextStyle(color: Colors.white, fontSize: 16),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24)),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //  title: Text('Fitness App'),
            ),
        body: IntroductionScreen(
          pages: pages,
          onDone: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          onSkip: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          showSkipButton: true,
          skip: Icon(Icons.skip_next, color: Colors.white),
          next: Icon(Icons.arrow_right, color: Colors.white),
          done: const Text("Done",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: Colors.deepOrange,
              color: Colors.black26,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0))),
        ));
  }
}
