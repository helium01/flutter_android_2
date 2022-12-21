import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:phileaflorist/repository/repobunga.dart';
import 'package:phileaflorist/screens/auth_screens/login.dart';
import 'package:phileaflorist/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './profile_model.dart';
import '../lib/colors.dart' as RecehanColors;

class ProfileView extends ProfileModel {
var userdata;
@override
void initState(){
  _getUserInfo();
  super.initState();
}

void _getUserInfo()async{
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var userJson = localStorage.getString('data');
  var user=json.decode(userJson.toString());
  print(user);
  setState(() {
    userdata=user;
  });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          ProfileViewAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: RecehanColors.red.withOpacity(.2),
                          blurRadius: 10.0)
                    ],
                    borderRadius: BorderRadius.circular(100.0),
                    gradient: LinearGradient(
                        colors: [RecehanColors.red, RecehanColors.redWarm])),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Text('P',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            
            SizedBox(height: 10.0),
            Center(
                child: Text("${userdata['name']}",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: RecehanColors.red,
                        fontWeight: FontWeight.bold))),
            Center(
                child: Text('${userdata['email']}',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black.withOpacity(.2),
                        fontWeight: FontWeight.bold))),
            SizedBox(height: 30.0),
            Center(child: ProfileRating()),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('My Task',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSans')),
                  SizedBox(height: 10.0),
                  Wrap(
                    children: List.generate(4, (_) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          leading: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60.0),
                                gradient: LinearGradient(colors: [
                                  RecehanColors.red,
                                  RecehanColors.redWarm
                                ])),
                          ),
                          title: Text('Lets Done Project'),
                          subtitle: Text('We Have More Project'),
                        ),
                      );
                    }),
                  )
                ],
              ),
            )
          ])),
        ],
      ),
    );
  }
}

class ProfileViewAppBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      leading: Container(
        padding: EdgeInsets.all(10.0),
        child: IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: (){
              logout();
            },
          ),
          
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {},
            child: Icon(Icons.bookmark, color: RecehanColors.yellowAccent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {},
            child: Icon(Icons.settings, color: RecehanColors.purple),
          ),
        ),
        SizedBox(width: 10.0)
      ],
    );
  }
  
  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    // print(body);
    //  if(body['pesan'] !=null){
      print('ok coba ya');
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context)=>Login()));
    // }
    
  }
  
}


class ProfileRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.center,
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StarRating(5, colors: [RecehanColors.red, RecehanColors.redWarm]),
          SizedBox(width: 20.0),
          StarRating(2,
              colors: [RecehanColors.purple, RecehanColors.purpleWarm]),
          SizedBox(width: 20.0),
          StarRating(3,
              colors: [RecehanColors.yellow, RecehanColors.yellowWarm])
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int star;
  final List<Color> colors;

  StarRating(this.star, {required this.colors});

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      height: 70.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(blurRadius: 5.0, color: Colors.black.withOpacity(.2))
          ],
          gradient: LinearGradient(
              colors: colors == null ? [Colors.red, Colors.white] : colors)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(star.toString() + '.0',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white.withOpacity(.7),
                  fontWeight: FontWeight.w700)),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  star,
                  (index) => Icon(Icons.star,
                      size: 10.0, color: Colors.white.withOpacity(.7))),
            ),
          )
        ],
      ),
    );
  }
  
}

