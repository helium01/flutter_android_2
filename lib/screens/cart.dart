
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:phileaflorist/screens/auth_screens/login.dart';
import 'package:phileaflorist/screens/keranjang/keranjang.dart';
import 'package:phileaflorist/screens/keranjang/keranjang_tampil.dart';
import 'package:phileaflorist/screens/ship_to.dart';
import 'package:phileaflorist/widgets/Text_form_field_widget.dart';
import 'package:phileaflorist/widgets/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';
import '../widgets/Text_widget.dart';
import '../widgets/cart_container.dart';

class Cart extends StatelessWidget {
  Cart({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

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
      child = keranjang();
    } else{
      child = Login();
    }

    return Scaffold(
      body: child,
    );
  }
  }
