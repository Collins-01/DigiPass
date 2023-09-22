// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/helpers/color.dart';
// import 'package:flutter_application_1/helpers/components/page_layout.dart';
// import 'package:flutter_application_1/helpers/text_formating.dart';
// import 'package:flutter_application_1/helpers/util.dart';
// import 'package:gap/gap.dart';
// import 'package:sizer/sizer.dart';

// class YallaPageLayoutDashboard extends StatefulWidget {
//   final pageTitle, bodyTitle, child, appBarAction, navPop;
//   YallaPageLayoutDashboard(
//       {this.pageTitle = "",
//       this.bodyTitle = "",
//       this.child,
//       this.navPop = true,
//       this.appBarAction});
//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<YallaPageLayoutDashboard> {
//   @override
//   Widget build(BuildContext context) {
//     return PageLayout(
//       noAppBar: true,
//       child: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               decoration: new BoxDecoration(
//                 color: Color(0xffFAFFFD),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey[200],
//                     blurRadius: 1.0, // has the effect of softening the shadow
//                     spreadRadius: 1.0, // has the effect of extending the shadow
//                     offset: Offset(
//                       2.0, // horizontal, move right 10
//                       1.0, // vertical, move down 10
//                     ),
//                   )
//                 ],
//               ),
//               height: 12.h,
//               child: Row(
//                 children: [
//                   Gap(5.w),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 30.0),
//                     child: Text("${widget.pageTitle}",
//                         style: headingText.copyWith(
//                             color: primaryColor, fontSize: 20.sp)),
//                   )
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 20.0,
//                 ),
//                 child: Form(
//                   child: Column(
//                     children: [
//                       Gap(widget.bodyTitle.isNotEmpty ? 26 : 8),
//                       widget.bodyTitle.isNotEmpty
//                           ? Row(
//                               children: [
//                                 Flexible(
//                                   child: Text("${widget.bodyTitle}",
//                                       style: headingText.copyWith(
//                                           color: primaryColor,
//                                           fontSize: 20.sp)),
//                                 )
//                               ],
//                             )
//                           : Text(""),
//                       Expanded(
//                         child: Container(
//                           height: 90.h,
//                           child: widget.child,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   showlo() {
//     showModalBottomSheet(
//         isDismissible: false,
//         context: context,
//         builder: (BuildContext context) {
//           return Container(
//             height: 10.h,
//             color: Colors.white,
//             child: Center(
//               child: spinkit,
//             ),
//           );
//         });
//   }
// }
