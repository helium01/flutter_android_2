
import 'package:flutter/material.dart';
import 'package:phileaflorist/api/api.dart';
import 'package:phileaflorist/screens/auth_screens/akun/profile/profile.dart';
import 'package:phileaflorist/screens/auth_screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Philea Florist Bali',
      debugShowCheckedModeBanner: false,
      home: CheckAuth(),
      darkTheme: ThemeData(brightness: Brightness.dark, accentColor: Colors.blueAccent),
      themeMode: ThemeMode.dark,
    );
  }
}
class CheckAuth extends StatefulWidget{
  @override
  _CheckAuthState createState() => _CheckAuthState();
}
class _CheckAuthState extends State<CheckAuth>{
  bool isAuth = false;

  @override
  void initState(){
    super.initState();
    _checkIfLoggedIn();
  }

   void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token != null){
      if(mounted){
        setState(() {
          isAuth = true;
        });
      }
    }
  }
@override
  Widget build(BuildContext context){
    Widget child;
    if(isAuth){
      child = Profile();
    } else{
      child = Login();
    }

    return Scaffold(
      body: child,
    );
  }
}