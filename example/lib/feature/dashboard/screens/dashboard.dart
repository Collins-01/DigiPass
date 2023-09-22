import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_nfc_kit_example/feature/dashboard/screens/home.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/snakbars.dart';



class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  CountdownTimerController? controller;
  var sd = 3600;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 50;
  void onEnd() async {
    defaultSnackyBar(context, "Sign-in Timeout.", dangerColor);
    setState(() {});
    //   await FirebaseAuth.instance.signOut();
    //   final req = await AuthServices()
    //       .logoutUser(context)
    //       .then((value) => nextPageNoPop(
    //           context, (context) => SignIn()));
    // // Navigator.pop(context);
    // print('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Container(
            //   color:primaryColor,
            //   height:50.0,
            //   child:Container(
            //     padding: EdgeInsets.only(top: 2.0, right: 8),
            //     // color:Colors.red,
            //     child: Center(
            //       child: CountdownTimer(
            //         controller: controller,
            //         onEnd: onEnd,
            //         endTime: endTime,
            //         textStyle: textStyle(
            //             color: Colors.white,
            //             fontSize: 12.0,
            //             fontWeight: FontWeight.w600),
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(child: Home()),
          ],
        ),
      ),
    );
  }
}

// class Dashboard extends StatefulWidget {

//   @override
//   _DashboardState createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {

//   int _currentIndex = 0;

//   List<Widget> currentRender = [
//     Home(),
//     Settings(),
 
//   ];
 

//   Widget build(
//     BuildContext context,
//   ) {
//     double displayWidth = MediaQuery.of(context).size.width;
//     SystemChrome.setPreferredOrientations(
//         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


//     return SafeArea(
//         child: Scaffold(
//             bottomNavigationBar: BottomNavigationBar(
//               backgroundColor: Color(0xFFF8F8F8),
//               currentIndex: _currentIndex,
//               elevation: 5,
//               onTap: (value) {
//                 setState(() {
//                   _currentIndex = value;
//                 });
//               },
//               unselectedItemColor: Colors.grey,
//               selectedItemColor: textColor,
//               unselectedLabelStyle: textStyle(fontSize: 10.0),
//               selectedLabelStyle: textStyle(fontSize: 10.0),
//               showUnselectedLabels: true,
//               items: const [
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.home),
//                     label: 'Home'),
//                 BottomNavigationBarItem(
//                     icon:Icon(Icons.settings),
//                     label: 'Settings'),
//                 // BottomNavigationBarItem(
//                 //     icon:Icon(Icons.home),
//                 //     label: 'Notifications'),
//                 // BottomNavigationBarItem(
//                 //     icon:Icon(Icons.home),
//                 //     label: 'Account'),
//               ],
//             ),
//             body: Container(
//               child: IndexedStack(
//                   index: _currentIndex,
//                   children: <Widget>[...currentRender]
//                 ),
//             )
//             )
//         // )

//         );
//   }
// }
