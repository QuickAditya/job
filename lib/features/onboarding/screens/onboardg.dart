// import 'package:flutter/material.dart';
// import 'package:job/features/auth/screens/login_page.dart';

// class OnBoarding extends StatefulWidget {
//   @override
//   _OnBoardingState createState() => _OnBoardingState();
// }

// class _OnBoardingState extends State<OnBoarding> {
// //List<SliderModel> slides = new List<SliderModel>();

//   List<Map<String, dynamic>> slides = [
//     {
//       'image': 'assets/images/slider_image1.png',
//       'title': 'Find your dream job now Here'
//     },
//     {
//       'image': 'assets/images/slider_image2.png',
//       'title': 'Easy To Apply on Mobile App'
//     }
//   ];
//   int currentIndex = 0;
//   late PageController _controller;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller = PageController(initialPage: 0);
// //	slides = getSlides();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Geeks for Geeks"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView.builder(
//                 scrollDirection: Axis.horizontal,
//                 controller: _controller,
//                 onPageChanged: (value) {
//                   setState(() {
//                     currentIndex = value;
//                   });
//                 },
//                 itemCount: slides.length,
//                 itemBuilder: (context, index) {
//                   // contents of slider
//                   return Slider(
//                     image: slides[index]['image'].toString(),
//                   );
//                 }),
//           ),
//           Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 slides.length,
//                 (index) => buildDot(index, context),
//               ),
//             ),
//           ),
//           Container(
//             height: 60,
//             margin: EdgeInsets.all(40),
//             width: double.infinity,
//             color: Colors.green,
//             child: GestureDetector(
//               child:
//                   Text(currentIndex == slides.length - 1 ? "Continue" : "Next"),
//               onTap: () {
//                 if (currentIndex == slides.length - 1) {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginPage()),
//                   );
//                 }
//                 _controller.nextPage(
//                     duration: Duration(milliseconds: 100),
//                     curve: Curves.bounceIn);
//               },
//               // textColor: Colors.white,
//               // shape: RoundedRectangleBorder(
//               // 	borderRadius: BorderRadius.circular(25),
//               // ),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.white,
//     );
//   }

// // container created for dots
//   Container buildDot(int index, BuildContext context) {
//     return Container(
//       height: 10,
//       width: currentIndex == index ? 25 : 10,
//       margin: EdgeInsets.only(right: 5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.green,
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// // slider declared
// class Slider extends StatelessWidget {
//   String image;

//   Slider({required this.image});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       // contains container
//       child: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // image given in slider
//             Image(image: AssetImage(image)),
//             SizedBox(height: 25),
//           ],
//         ),
//       ),
//     );
//   }
// }
