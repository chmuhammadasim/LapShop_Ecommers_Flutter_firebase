import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flapshopadmin/const/firebase_const.dart';
import 'package:flapshopadmin/views/auth_Screen/login_screen.dart';
import 'package:flapshopadmin/views/home_Screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkuser();
  }

  var isloggedin = false;
  checkuser() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        isloggedin = false;
      } else {
        isloggedin = true;
      }
      setState(() {});
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LapShop Admin',
      home: isloggedin ? const Home() : const LoginScreen(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent, elevation: 0.0),
      ),
    );
  }
}
