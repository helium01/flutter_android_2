import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phileaflorist/repository/repobunga.dart';
import 'package:phileaflorist/screens/cart.dart';
import 'package:phileaflorist/screens/home.dart';
import 'package:phileaflorist/screens/keranjang/tambah_keranjang.dart';
import 'package:phileaflorist/screens/komentar/komentar.dart';
import 'package:phileaflorist/utils/app_constants.dart';
import 'package:phileaflorist/widgets/button_widget.dart';
import 'package:phileaflorist/widgets/four_ratings_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../api/api.dart';
import '../../utils/all_lists.dart';
import '../../widgets/Text_widget.dart';
import '../../widgets/single_review.dart';
import '../review_product.dart';

class produk_detail extends StatelessWidget {
  var listbunga;
  final String id;
  final _productImageController = PageController();
  final _lists = AllLists();
  produk_detail({
    required  this.id,
    super.key});

  @override
  Widget build(BuildContext context) {
    print(id);
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
                    Icon(
                      Icons.search,
                      color: AppConstants.subTxtColor,
                      size: 24,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Icon(
                      Icons.more_vert,
                      color: AppConstants.subTxtColor,
                      size: 24,
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
                        Icon(
                          Icons.favorite_border,
                          color: AppConstants.subTxtColor,
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
                          "Bunga papan ini blablabla.",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textColor: AppConstants.subTxtColor,
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
                     ButtonWidget(
                          buttonText: "masukan komentar",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => komentar()));
                          }),
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
                            txt: "See More",
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
                    Row(
                      children: const [
                        FourRating(),
                        SizedBox(
                          width: 8,
                        ),
                        TextWidget(
                          txt: "4.5 (5 Review)",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          textColor: AppConstants.subTxtColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SingleReview(
                        profileImagePath: "assets/images/userimage1.png",
                        name: "James Lawson",
                        isFullRating: false,
                        review:
                            "bunga papan ini keren."),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 16, top: 16),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       SizedBox(
              //         height: 72,
              //         child: ListView.builder(
              //             physics: const BouncingScrollPhysics(),
              //             scrollDirection: Axis.horizontal,
              //             itemCount: _lists.productImagesList.length,
              //             itemBuilder: (context, index) {
              //               return Container(
              //                 margin: const EdgeInsets.only(right: 12),
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(8),
              //                 ),
              //                 child:
              //                     Image.asset(_lists.productImagesList[index]),
              //               );
              //             }),
              //       ),
              //       const SizedBox(
              //         height: 16,
              //       ),
              //       const TextWidget(
              //         txt: "December 10, 2022",
              //         fontSize: 10,
              //         fontWeight: FontWeight.w400,
              //         textColor: AppConstants.subTxtColor,
              //       ),
              //       const SizedBox(
              //         height: 23,
              //       ),
              //       const TextWidget(
              //         txt: "barang lain yang di cari",
              //         fontSize: 14,
              //         fontWeight: FontWeight.w700,
              //         textColor: AppConstants.titleTextColor,
              //       ),
              //       const SizedBox(
              //         height: 12,
              //       ),
              //       SizedBox(
              //         height: 244,
              //         child: ListView.builder(
              //             physics: const BouncingScrollPhysics(),
              //             itemCount: _lists.flashSaleList.length,
              //             scrollDirection: Axis.horizontal,
              //             itemBuilder: (context, index) {
              //               return ProductDisplayContainer(
              //                 margin: 16,
              //                 imagePath: _lists.flashSaleList[index].imagePath,
              //                 newPrice: _lists.flashSaleList[index].newPrice,
              //                 oldPrice: _lists.flashSaleList[index].oldPrice,
              //                 discount: _lists.flashSaleList[index].discount,
              //                 productName:
              //                     _lists.flashSaleList[index].productName,
              //               );
              //             }),
              //       ),
              //       const SizedBox(
              //         height: 21,
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(right: 16),
              //         child: ButtonWidget(
              //             buttonText: "Add To Cart", onPressed: () {}),
              //       ),
              //       const SizedBox(
              //         height: 37,
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}