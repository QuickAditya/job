import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:job/features/auth/controllers/auth_controller.dart';
import 'package:job/features/auth/screens/login_page.dart';
import 'package:job/features/onboarding/conotrollers/onboardcontroller.dart';
import 'package:provider/provider.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController pagecontroller;
  // List<SliderModel> slides = new List<SliderModel>();
  int currentIndex = 0;

  List<Map<String, dynamic>> imageList = [
    {
      'image': 'assets/images/slider_image1.png',
      'title': 'Find your dream job\nnow Here'
    },
    {
      'image': 'assets/images/slider_image2.png',
      'title': 'Easy To Apply on\nMobile App'
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pagecontroller = PageController(
      initialPage: 0,
    );
//slides = getSlides();
  }

  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final onboardcontroller =
    //     Provider.of<Onboardcontroller>(context, listen: false);
    var siz = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: siz.height * 0.1,
            ),
            SizedBox(
              height: siz.height * 0.62,
              width: double.infinity,
              child: PageView.builder(
                // allowImplicitScrolling: true,
                itemCount: imageList.length,
                scrollDirection: Axis.horizontal,
                controller: pagecontroller,
                onPageChanged: (value) {
                  // onboardcontroller.changeindex(value);
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  // return Slider(
                  //   image: imageList[index]['image'].toString(),
                  //   title: imageList[index]['title'].toString(),
                  // );
                  return Column(
                    children: [
                      Image(
                        image: AssetImage(imageList[index]['image'].toString()),
                        // fit: BoxFit.fill,
                        height: siz.height * 0.5,
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Container(
                        // padding: EdgeInsets.symmetric(horizontal: 5),
                        alignment: Alignment.center,
                        child: Text(
                          imageList[index]['title'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xff1452B5),
                              fontSize: 30,
                              fontWeight: FontWeight.w900),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: siz.height * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  for (var i = 0; i < imageList.length; i++)
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: buildIndicator(currentIndex == i)),
                ]),
                GestureDetector(
                  onTap: () {
                    if (currentIndex < imageList.length - 1) {
                      // Move to the next page
                      currentIndex++;
                      pagecontroller.animateToPage(
                        currentIndex,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // Navigate to the login page when the last page is reached
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => LoginPage()),
                      // );
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    margin: EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Image(image: AssetImage('assets/images/arrow.png')),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(bool isSelected) {
    log('isSelected' + isSelected.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12 : 8,
        width: isSelected ? 12 : 8,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.black : Colors.grey),
      ),
    );
  }
}

class Slider extends StatelessWidget {
  String image, title;

  //Constructor created
  Slider({
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var siz = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        // column containing image
        // title and description
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(image),
              height: siz.height * 3,
              width: siz.width,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
