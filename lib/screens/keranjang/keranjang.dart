import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phileaflorist/api/api.dart';
import 'package:phileaflorist/repository/repobunga.dart';
import 'package:phileaflorist/widgets/Text_widget.dart';
import 'package:phileaflorist/widgets/cart_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';

class keranjang extends StatefulWidget{
  @override 
  _keranjang createState()=>_keranjang();
}

class _keranjang extends State<keranjang> {
  
  //  _keranjang({Key? key}) ;
  final _formKey = GlobalKey<FormState>();
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
  // print(user);
  setState(() {
    userdata=user;
  });
}
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
 
repoKeranjang repokeranjang = repoKeranjang();
   Future<List<Keranjang>> ? listKeranjang;
  @override
  Widget build(BuildContext context) {
    if(userdata == null){
      userdata=this.userdata;
    }else{
    listKeranjang=repokeranjang.getDataKeranjang("${userdata['id']}");
    }
    // print(listKeranjang);
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: SafeArea(
        child: FutureBuilder <List<Keranjang>>(
          future: listKeranjang,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List<Keranjang> isidata = snapshot.data!;
              return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 26, left: 16, right: 16),
                  child: Column(
                    children: [
                      TextWidget(
                        txt: "Keranjang",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        textColor: AppConstants.titleTextColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Divider(
                  thickness: 1,
                  height: 0,
                  color: AppConstants.txtFieldColor,
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                height: 190,
                child:FutureBuilder <List<Keranjang>>(
                  future: listKeranjang,
                  builder: (context, snapshot) {
                    // print("apa");
                    if(snapshot.hasData){
                      List<Keranjang> isidata = snapshot.data!;
                      return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: isidata.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Stack(
                          children: [
                            CartContainer(
                              id: isidata[index].id,
                          productName: "${isidata[index].nama_barang}",
                          productImagePath: "${isidata[index].foto}",
                          price: "Rp. ${isidata[index].harga}"),
                          ],
                        ),
                      );
                    });
                    }else if (snapshot.hasError){
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                  },)
              ),
               
              ],
            ),
          ),
        );
            }else if(snapshot.hasError){
              return Text("error pak ${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },),
        
        
        
      ),
    );
  }
  
  
}