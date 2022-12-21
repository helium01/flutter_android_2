import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phileaflorist/api/api.dart';
import 'package:phileaflorist/repository/repobunga.dart';
import 'package:phileaflorist/screens/keranjang/keranjang.dart';
import 'package:phileaflorist/utils/app_constants.dart';
import 'package:phileaflorist/widgets/Text_widget.dart';
import 'package:phileaflorist/widgets/cart_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_screens/akun/lib/colors.dart' as RecehanColors;
import '../auth_screens/akun/profile/profile_view.dart';

class TampilKeranjang extends StatefulWidget {

  @override
  KeranjangView createState() => KeranjangView();
}
abstract class keranjangModel extends State<TampilKeranjang> {
  late String nama;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      nama = 'Shodiqul Muzaki';
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
class KeranjangView extends keranjangModel {
  final _formKey = GlobalKey<FormState>();
var userdata;
  repoKeranjang repokeranjang=repoKeranjang();
  late Future<List<Keranjang>>  listKeranjang;
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
    print(userdata['id']);
    listKeranjang=repokeranjang.getDataKeranjang("12");
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: FutureBuilder<List<Keranjang>>(
                //     future: listKeranjang,
                //     builder: (context,snapshot){
                //       if(snapshot.hasData){
                //         List<Keranjang> isidata=snapshot.data!;
                //       return PageView.builder(
                //         physics: BouncingScrollPhysics(),
                //         itemCount: isidata.length,
                //         itemBuilder: (context,index){
                //           return Column(
                //     children: [
                //       CartContainer(
                //           productName: isidata[index].nama_barang,
                //           productImagePath: isidata[index].foto,
                //           price: isidata[index].jumlah_keranjang.toString()),
                //            SizedBox(height: 16),
                //       SizedBox(
                //         height: 16,
                //       ),
                      
                     
                //       SizedBox(height: 16),
                //     ],
                //   );
                //         });
                //       }else if(snapshot.hasError){
                //         return Text("${snapshot.error}");
                //       }
                //       return const CircularProgressIndicator();
                //     },)
                  
                  
                  
                  
                  
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
