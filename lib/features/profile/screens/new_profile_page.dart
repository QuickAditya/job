// import 'dart:developer';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get_it/get_it.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:job/utils/custombutton.dart';

// class UserProfile extends StatefulWidget {
//   const UserProfile({super.key});

//   @override
//   State<UserProfile> createState() => _UserProfileState();
// }

// class _UserProfileState extends State<UserProfile> {
//   final getStorage = GetIt.instance<GetStorage>();
//   @override
//   Widget build(BuildContext context) {
//     final email = getStorage.read<String>('email') ?? 'No email available';
//     final name = getStorage.read<String>('name') ?? 'No name available';
//     final number = getStorage.read<String>('number') ?? 'No name available';
//     var siz = MediaQuery.of(context).size;
//     return CupertinoPageScaffold(
//         child: SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: siz.height * 0.02,
//             ),
//             Container(
//               padding: const EdgeInsets.only(right: 20, left: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'My Profile',
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: Color(0xff1452B5),
//                         fontWeight: FontWeight.w600),
//                   ),
//                   // Image(
//                   //   image: AssetImage('assets/images/change_pass.png'),
//                   //   height: 21,
//                   //   width: 85,
//                   //   fit: BoxFit.cover,
//                   // )
//                 ],
//               ),
//             ),
//             // SizedBox(
//             //   height: siz.height * 0.03,
//             // ),
//             // Stack(
//             //   children: [
//             //     Image(
//             //       image: AssetImage('assets/images/profile_image.png'),
//             //       height: siz.height * 0.15,
//             //       width: siz.width * 0.3,
//             //       alignment: Alignment.center,
//             //     ),
//             //     Positioned(
//             //       right: 0,
//             //       top: siz.height * 0.1,
//             //       child: GestureDetector(
//             //         onTap: () {
//             //           log('tapping on camera');
//             //         },
//             //         child: Container(
//             //           padding: EdgeInsets.all(6),
//             //           height: 30,
//             //           width: 30,
//             //           decoration: ShapeDecoration(
//             //               color: Colors.black,
//             //               shape: RoundedRectangleBorder(
//             //                   borderRadius: BorderRadius.circular(24),
//             //                   side: BorderSide(color: Colors.white, width: 2))),
//             //           child:
//             //               Image(image: AssetImage('assets/images/camera.png')),
//             //         ),
//             //       ),
//             //     )
//             //   ],
//             // ),
//             SizedBox(
//               height: siz.height * 0.06,
//             ),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 20),
//               child: Text(
//                 'Full name' ?? '',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontSize: 12),
//               ),
//             ),
//             textfield(name ?? 'Full name'),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 20),
//               child: Text(
//                 'Email',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontSize: 12),
//               ),
//             ),
//             textfield(email ?? 'Email'),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.only(left: 20),
//               child: Text(
//                 'Phone no.',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontSize: 12),
//               ),
//             ),
//             textfield(number ?? 'Phone no.'),
//             SizedBox(
//               height: siz.height * 0.04,
//             ),
//             CustomButton2(
//               width: siz.width * 0.8,
//               text: 'Logout',
//               onPressed: () async {
//                 showCupertinoLogoutDialog(context);
//               },
//             )
//           ],
//         ),
//       ),
//     ));
//   }

//   textfield(String place) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       // decoration: ShapeDecoration(
//       //     shape: RoundedRectangleBorder(
//       //         borderRadius: BorderRadius.circular(10),
//       //         side: BorderSide(width: 1, color: Colors.white))),
//       child: CupertinoTextField(
//         readOnly: true,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black26),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         placeholder: place,
//         // placeholderStyle: TextStyle(color: Colors.black87),
//       ),
//       // child: Text(place,style: TextStyle(
//       //   color: Colors.black87
//       // ),),
//     );
//   }

//   showCupertinoLogoutDialog(BuildContext context) {
//     showCupertinoDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return CupertinoAlertDialog(
//           title: Text('Logout'),
//           content: Text('Are you sure you want to log out?'),
//           actions: [
//             CupertinoDialogAction(
//               isDefaultAction: true,
//               onPressed: () async {
//                 await getStorage.erase();
//                 Navigator.pushNamedAndRemoveUntil(
//                   context,
//                   '/login',
//                   (route) => false,
//                 );
//               },
//               child: Text(
//                 'Logout',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//             CupertinoDialogAction(
//               onPressed: () {
//                 // Handle logout logic here
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
