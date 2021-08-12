import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_shop_app/network/local/shared_preferences.dart';
import 'package:flutter_app_shop_app/shop_app/login_screen/sigin_in.dart';
import 'package:flutter_app_shop_app/widgets/widgets.dart';
import 'package:flutter_page_view_indicator/flutter_page_view_indicator.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class ObBoardingModel {
  final text;
  final url;

  ObBoardingModel({this.text, this.url});
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController controller = PageController();

  List listOfWidget = [
    ObBoardingModel(
        text: "Welcome to STORM, Let's shop",
        url: "assets/images/splash_1.png"),
    ObBoardingModel(
        text:
            "We help people conect with store\n  around United State of America.",
        url: "assets/images/splash_2.png"),
    ObBoardingModel(
        text: "We show the easy way to shop.\n    just start at home with us.",
        url: "assets/images/splash_3.png"),
  ];
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){
              submit(context);
            },
            child: Text(
              "Skip",
              style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return buildSplishScreenItem(
                    text: listOfWidget[index].text,
                    urlImage: listOfWidget[index].url);
              },
              itemCount: 3,
              controller: controller,
            ),
          ),
          Container(
            child: PageViewIndicator(
              currentSize: 15,
              orientation: Axis.horizontal,
              margin: EdgeInsets.all(5),
              currentColor: Colors.deepOrange,
              length: 3,
              currentIndex: currentIndex,
              borderRadius: 5,
              animationDuration: Duration(microseconds: 570),
            ),
          ),
          buildButtonContinue(
            context: context,
            onTap: (){
              submit(context);
            },
          ),
        ],
      ),
    );
  }

  Container buildSplishScreenItem(
      {required String text, required String urlImage}) {
    return Container(
      height: 200,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "STORM",
            style: TextStyle(
                fontSize: 36,
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 300,
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                maxLines: 2,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(height: 200, width: 200, child: Image.asset(urlImage)),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

void submit(context) {
  CacheHelper.setData(key: "onBoarding", value: true);
  navigatorToPush(context: context, screen: SignInScreen());
}
