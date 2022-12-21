
import 'package:flutter/material.dart';
import 'package:phileaflorist/screens/auth_screens/login.dart';
import 'package:phileaflorist/screens/cart.dart';
import 'package:phileaflorist/screens/home.dart';
import 'package:phileaflorist/screens/produk/produk_detail.dart';
import 'package:phileaflorist/screens/review_product.dart';
import 'package:phileaflorist/screens/ship_to.dart';
import 'package:phileaflorist/widgets/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/all_lists.dart';
import '../utils/app_constants.dart';
import '../widgets/Text_widget.dart';
import '../widgets/product_display_container_widget.dart';
import '../widgets/four_ratings_widget.dart';
import '../widgets/single_review.dart';

class ProductDetail extends StatelessWidget {
  final String id;

  ProductDetail(
    { required this.id,
      Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Philea Florist Bali',
      debugShowCheckedModeBanner: false,
      home: CheckAuth(id: id,),
      darkTheme: ThemeData(brightness: Brightness.dark, accentColor: Colors.blueAccent),
      themeMode: ThemeMode.dark,
    );
  }
}
class CheckAuth extends StatefulWidget{
  final String id;
  CheckAuth({
    required this.id,
  });
  @override
  _CheckAuthState createState() => _CheckAuthState(id: id);
}
class _CheckAuthState extends State<CheckAuth>{
  bool isAuth = false;
  final String id;
  _CheckAuthState({
    required this.id,
  });

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
      child = produk_detail(id: id,);
    } else{
      child = Login();
    }

    return Scaffold(
      body: child,
    );
  }
}
