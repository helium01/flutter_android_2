import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phileaflorist/repository/repobunga.dart';
import 'package:phileaflorist/screens/cart.dart';
import 'package:phileaflorist/screens/home.dart';
import 'package:phileaflorist/screens/keranjang/keranjang_tambah.dart';
import 'package:phileaflorist/screens/keranjang/tambah_keranjang.dart';
import 'package:phileaflorist/screens/komentar/komentar.dart';
import 'package:phileaflorist/utils/app_constants.dart';
import 'package:phileaflorist/widgets/button_widget.dart';
import 'package:phileaflorist/widgets/four_ratings_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../api/api.dart';
import '../../utils/all_lists.dart';
import '../../widgets/Text_widget.dart';
import '../../widgets/single_review.dart';
import '../review_product.dart';
import '../search.dart';

class produk_detail extends StatefulWidget{
  @override
  final String id;
  produk_detail({
    required this.id
  });
  _produk_detail createState()=>_produk_detail(id: id);
}


class _produk_detail extends State<produk_detail> {
  bool _secureText = true;
  bool _isLoading = false;
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

  var listbunga;
  final String id;
  final _productImageController = PageController();
  final _lists = AllLists();
  _produk_detail({
    required  this.id});

  @override
  Widget build(BuildContext context) {
    if(userdata==null){
        return const CircularProgressIndicator();
      }
    // print(userdata['id']);
    var iconSize = 20;
     final Urll='http://fajar.patusaninc.com/api/v1/barang/cek/'+userdata['id'].toString()+"/"+id;
  Future<Data> getDetailData()async{
  // print(Urll);
    final response=await http.get(Uri.parse(Urll));
    print(response.statusCode);
     if(response.statusCode==200){
        //  kategori=json.decode(response.body);
       
        // print(kategori);
        // Iterable it =jsonDecode(response.body);
        // List<Bunga> bunga=it.map((e)=>Bunga.fromJson(e)).toList();
        return Data.fromJson(jsonDecode(response.body));
      }else{
        throw Exception('failed to load data');
      }

  }
  late Future<Data> coba3;
  coba3=getDetailData();
    final baseUrll='http://fajar.patusaninc.com/api/v1/testimoni/'+id;
  Future<List<Testimonii>> getDetailBungaa()async{
  // print(baseUrl+id);
    final response=await http.get(Uri.parse(baseUrll));
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
  late Future<List<Testimonii>> coba2;
  coba2=getDetailBungaa();
    
  final baseUrl='http://fajar.patusaninc.com/api/v1/barang/'+id;
  Future<Bunga2> getDetailBunga()async{
  // print(baseUrl+id);
    final response=await http.get(Uri.parse(baseUrl));
     if(response.statusCode==200){
        var populer=json.decode(response.body)['data'];
      //  print(populer);
        // // print(response);
        // Iterable it =jsonDecode(response.body);
        // List<Bunga> bunga=it.map((e)=>Bunga.fromJson(e)).toList();
        return Bunga2.fromJson(jsonDecode(response.body)['data']);
      }else{
        throw Exception('failed to load data');
      }

  }
  late Future<Bunga2> coba;
  coba=getDetailBunga();
  // print(baseUrl);
    // repoDetail repodetail= repoDetail(id: id);
    // listbunga=repodetail.getDetailBunga();
    return Scaffold(
      
      backgroundColor: AppConstants.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 26, left: 16, right: 16),
                child: FutureBuilder<Bunga2>(
                    future: coba,
                    builder: (context, snapshot) {
                      // print("kok bisa ya");
                      // print(snapshot.hasData);
                      if (snapshot.hasData) {
                        return Row(
                  children: [
                    TextButton(onPressed: (){
                        Navigator.push(
                    context,
                    // DetailPage adalah halaman yang dituju 
                    MaterialPageRoute(
                      builder: (context) => Home()
                    ),
                  );
                    }, child:  Icon(
                      Icons.arrow_back_ios,
                      color: AppConstants.subTxtColor,
                      size: 18,
                    ),),
                    
                    SizedBox(
                      width: 21,
                    ),
                    Expanded(
                        child: TextWidget(
                      txt: "${snapshot.data!.nama_barang}",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      textColor: AppConstants.titleTextColor,
                    )),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search()));
                        },
                        child: Icon(
                      Icons.search,
                      color: AppConstants.subTxtColor,
                      size: 24,
                    ),
                      ),
                  ],
                );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },

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
              SizedBox(
                height: 228,
                child: FutureBuilder<Bunga2>(
                    future: coba,
                    builder: (context, snapshot) {
                      // print("kok bisa ya");
                      // print(snapshot.hasData);
                      if (snapshot.hasData) {
                        return  PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _productImageController,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Image.network("http://fajar.patusaninc.com/foto/"+snapshot.data!.foto);
                    });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },

              ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: _productImageController,
                  count: 5,
                  effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: AppConstants.primaryColor,
                      dotColor: AppConstants.txtFieldColor
                      // strokeWidth: 5,
                      ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16),
                child: FutureBuilder<Bunga2>(
                  
                    future: coba,
                    builder: (context, snapshot) {
                      // print(snapshot.hasData);
                      if (snapshot.hasData) {
                        return   Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextWidget(
                            txt: "${snapshot.data!.nama_barang}",
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            textColor: AppConstants.titleTextColor,
                          ),
                        ),
                        SizedBox(
                          width: 44,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const FourRating(),
                   
                     TextWidget(
                      txt: "Stok : ${snapshot.data!.stok}",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      textColor: Color.fromARGB(255, 8, 11, 12),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextWidget(
                      txt: "Rp. ${snapshot.data!.harga_akhir}",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      textColor: AppConstants.primaryColor,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // const TextWidget(
                    //   txt: "Select Size",
                    //   fontSize: 14,
                    //   fontWeight: FontWeight.w700,
                    //   textColor: AppConstants.titleTextColor,
                    // ),
                  ],
                );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },

              ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 12),
                child: FutureBuilder<Bunga2>(
                    future: coba,
                    builder: (context, snapshot) {
                      // print("kok bisa ya");
                      // print(snapshot.hasData);
                      if (snapshot.hasData) {
                        return  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ButtonWidget(
                          buttonText: "Tambah ke keranjang",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => tambah_keranjang(id: snapshot.data!.id.toString(),)));
                          }),
                    const SizedBox(
                      height: 24,
                    ),
                    TextWidget(
                      txt: "Detail",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      textColor: AppConstants.titleTextColor,
                    ),
                    TextWidget(
                      txt:
                          "${snapshot.data!.deskripsi}",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textColor: AppConstants.subTxtColor,
                    ),
                     Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      child: FutureBuilder <Data>(
                        future: coba3,
                        builder: (context, snapshot) {
                          print(snapshot);
                        if(snapshot.hasData){
                          print(snapshot.data!.data);
                          if(snapshot.data!.data !=0){
                            return ButtonWidget(
                          buttonText: "masukan komentar",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => komentar(id: id.toString(),)));
                          });
                          }else{
                            return GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewProduct(id: id,)));
                          },
                          child: TextWidget(
                            txt: "lihat detail produk",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            textColor: AppConstants.primaryColor,
                          ),
                        );
                          }
                        }else if(snapshot.hasError){
                          return Text("${snapshot.error}");
                        }
                        return const CircularProgressIndicator();
                      },),
                    ),
                     
                          const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        TextWidget(
                          txt: "Review Product",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          textColor: AppConstants.titleTextColor,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewProduct(id: id,)));
                          },
                          child: TextWidget(
                            txt: "lihat review produk",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            textColor: AppConstants.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder<List<Testimonii>>(
                    future: coba2,
                    builder: (context, snapshot) {
                      // print("kok bisa ya");
                      print(snapshot.data!.length);
                      if (snapshot.hasData) {
                        if(snapshot.data!.length!=0){
                          print('object');
                      List<Testimonii> isiData =snapshot.data!;
                           return Column(
            children: [
              SizedBox(
                height: 1000,
                child:FutureBuilder <List<Testimonii>>(
                  future: coba2,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      List<Testimonii> isidata = snapshot.data!;
                      return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 1,
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
                        }else{
                          return Text("belum ada komentar silahka menjadi komentator pertama");
                        }
                       
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
                  ],
                ),
              ),
                  ],
                );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },

              ),
              ),
             
             
            ],
          ),
        ),
      ),
    );
  }
}