import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Login_form_validate.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDOiYKfXSM2dXsFJ16-7oUVgRZvXuBBTIY",
          appId: "1:146481697476:web:4b045f7ce22f394a48ef91",
          messagingSenderId: "146481697476",
          projectId: "chapter-4-firebase-aaf0c")
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.orange,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginFormValidation(),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return DefaultTabController(
  //       length: 2,
  //       child: Scaffold(
  //         backgroundColor: Colors.blue,
  //         bottomNavigationBar: TabBar(
  //           tabs: [
  //             Tab(child: Text("Form See data")),
  //             Tab(child: Text("Score edit data")),
  //           ],
  //         ),
  //         body: TabBarView(
  //           children: [
  //             LoginFormValidation(),
  //             // HomePage(),
  //             Container(
  //               child: Text("หน้าช้อมูลตะแนน"),
  //             ),
  //           ],
  //         ),
  //       ));
  // }

}

