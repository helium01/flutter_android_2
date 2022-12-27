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
  
   _keranjang({Key? key}) ;
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
  late Future<List<Keranjang>>  listKeranjang;
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
                      return PageView.builder(
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: 
                //   Column(
                //     children: [
                //       CartContainer(
                //           productName: "bunga salib ",
                //           productImagePath: "assets/bunga/bunga1.jpeg",
                //           price: "Rp. 500.000"),
                //            SizedBox(height: 16),
                   
                //       SizedBox(
                //         height: 16,
                //       ),
                //       CartContainer(
                //           productName: "bunga papan",
                //           productImagePath: "assets/images/coba1.png",
                //           price: "Rp. 300.000"),
                //              SizedBox(
                //         height: 32,
                //       ),
                      
                //       SizedBox(
                //         height: 16,
                //       ),
                //       Container(
                //         padding: EdgeInsets.symmetric(
                //             horizontal: 16.5, vertical: 16),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(5),
                //             border:
                //                 Border.all(color: AppConstants.txtFieldColor)),
                //         child: Column(
                //           children: [
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 TextWidget(
                //                   txt: "Items (2)",
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w400,
                //                   textColor: AppConstants.subTxtColor,
                //                 ),
                //                 TextWidget(
                //                   txt: "Rp. 800.000",
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w400,
                //                   textColor: AppConstants.titleTextColor,
                //                 ),
                //               ],
                //             ),
                //             SizedBox(
                //               height: 12,
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 TextWidget(
                //                   txt: "kupon",
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w400,
                //                   textColor: AppConstants.subTxtColor,
                //                 ),
                //                 TextWidget(
                //                   txt: "0",
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w400,
                //                   textColor: AppConstants.titleTextColor,
                //                 ),
                //               ],
                //             ),
                //             SizedBox(
                //               height: 12,
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 TextWidget(
                //                   txt: "ongkos kirim",
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w400,
                //                   textColor: AppConstants.subTxtColor,
                //                 ),
                //                 TextWidget(
                //                   txt: "0",
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w400,
                //                   textColor: AppConstants.titleTextColor,
                //                 ),
                //               ],
                //             ),
                //             SizedBox(
                //               height: 12,
                //             ),
                //             DottedLine(
                //               dashColor: AppConstants.txtFieldColor,
                //               dashLength: 5,
                //             ),
                //             SizedBox(
                //               height: 12,
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 TextWidget(
                //                   txt: "Total harga",
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w700,
                //                   textColor: AppConstants.titleTextColor,
                //                 ),
                //                 TextWidget(
                //                   txt: "Rp. 800.000",
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w700,
                //                   textColor: AppConstants.primaryColor,
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                     
                //       SizedBox(height: 16),
                //     ],
                //   ),
                // )
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