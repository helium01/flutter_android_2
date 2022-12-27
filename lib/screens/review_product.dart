
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phileaflorist/api/api.dart';
import 'package:phileaflorist/screens/home.dart';
import 'package:phileaflorist/screens/write_review.dart';
import 'package:http/http.dart' as http;
import 'package:phileaflorist/widgets/button_widget.dart';
import 'package:phileaflorist/widgets/rating_container.dart';

import '../utils/all_lists.dart';
import '../utils/app_constants.dart';
import '../widgets/Text_widget.dart';
import '../widgets/single_review.dart';


class ReviewProduct extends StatefulWidget{
  final String id;
  ReviewProduct({
    required this.id,
  });
  @override
  _ReviewProduct createState()=>_ReviewProduct(id: id);
}

class _ReviewProduct extends State<ReviewProduct> {
  final _lists = AllLists();
  final String id;
   var iconSize;
  _ReviewProduct({
    required this.id,
  });


  @override
  Widget build(BuildContext context) {
    iconSize = 20;
    final baseUrl='http://fajar.patusaninc.com/api/v1/testimoni/'+id;
  Future<List<Testimonii>> getDetailBunga()async{
  // print(baseUrl+id);
    final response=await http.get(Uri.parse(baseUrl));
     if(response.statusCode==200){
         List kategori=json.decode(response.body)['data'];
       
        // // print(response);
        // Iterable it =jsonDecode(response.body);
        // List<Bunga> bunga=it.map((e)=>Bunga.fromJson(e)).toList();
        return kategori.map((data) => Testimonii.fromJson(data)).toList();
      }else{
        throw Exception('failed to load data');
      }

  }
  late Future<List<Testimonii>> coba;
  coba=getDetailBunga();
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder<List<Testimonii>>(
                    future: coba,
                    builder: (context, snapshot) {
                      // print("kok bisa ya");
                      print(snapshot.hasData);
                      if (snapshot.hasData) {
                      List<Testimonii> isiData =snapshot.data!;
                        return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 26, left: 16, right: 16),
                child: Row(
                  children:  [
                    TextButton(onPressed: (){
                      Navigator.pop(context,
                      MaterialPageRoute(builder: (context)=>Home()));
                    }, child: Icon(
                      Icons.arrow_back_ios,
                      color: AppConstants.subTxtColor,
                      size: 18,
                    ),),
                    SizedBox(
                      width: 21,
                    ),
                    TextWidget(
                      txt: " ${isiData.length} Review",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      textColor: AppConstants.titleTextColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              const Divider(
                thickness: 1,
                height: 0,
                color: AppConstants.txtFieldColor,
              ),
              const SizedBox(
                height: 16,
              ),
              
              const SizedBox(
                height: 24,
              ),

              SizedBox(
                height: 1000,
                child:FutureBuilder <List<Testimonii>>(
                  future: coba,
                  builder: (context, snapshot) {
                    print(isiData.length);
                    if(snapshot.hasData){
                      List<Testimonii> isidata = snapshot.data!;
                      return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: isidata.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Stack(
                          children: [
                    Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 25, backgroundImage: AssetImage("assets/images/logoblue.png")),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                txt: "${isiData[index].name}",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                textColor: AppConstants.titleTextColor,
                              ),
                              
                            ],
                          )
                        ],
                      ),
                      
                      const SizedBox(height: 15,),
                      
                      const SizedBox(
                        height: 16,
                      ),
                      TextWidget(
                        txt: "${isiData[index].pesan}",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textColor: AppConstants.subTxtColor,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                  ],
                        )
                      );
                    });
                    }else if (snapshot.hasError){
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                  },)
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: 
                
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                ),
              ),
            ],
          );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }else{
                    return Text("data kosong");
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },

              ),
        ),
      ),
    );
  }

}
