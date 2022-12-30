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

class Offer extends StatefulWidget{
  @override 
  _Offer createState()=>_Offer();
}

class _Offer extends State<Offer> {
  
   _Offer({Key? key}) ;
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
 
repoCheckout repocheckout = repoCheckout();
  Future<List<Checkoutya>> ? listcheck;
  @override
  Widget build(BuildContext context) {
    if(userdata == null){
      userdata=this.userdata;
    }else{
    listcheck=repocheckout.getDataCheckout("${userdata['id']}");
    }
    // print(listKeranjang);
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 26, left: 16, right: 16),
                  child: Column(
                    children: [
                      TextWidget(
                        txt: "cek status order",
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
                height: 500,
                child:FutureBuilder <List<Checkoutya>>(
                  future: listcheck,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      List<Checkoutya> isidata = snapshot.data!;
                      // print(isidata.length);
                      return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: isidata.length,
                    itemBuilder: (context, index) {
                      print('http://fajar.patusaninc.com/foto/'+isidata[index].foto);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child:Container(
                              margin: EdgeInsets.only(right: 150),
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppConstants.txtFieldColor),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network('http://fajar.patusaninc.com/foto/'+isidata[index].foto, height: 109, width: 118),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextWidget(
                                      txt: isidata[index].nama_barang,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      textColor: AppConstants.titleTextColor,
                                    ),
                                    TextWidget(
                                      txt: isidata[index].harga_akhir.toString(),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      textColor: AppConstants.primaryColor,
                                    ),
                                    Row(
                                      children: [
                                        TextWidget(
                                          txt: isidata[index].status.toString(),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          textColor: AppConstants.subTxtColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            )
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
  } 
}