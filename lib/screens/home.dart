
import 'package:flutter/material.dart';
import 'package:phileaflorist/api/api.dart';
import 'package:phileaflorist/repository/repobunga.dart';
import 'package:phileaflorist/screens/favorite_product.dart';
import 'package:phileaflorist/screens/notifications.dart';
import 'package:phileaflorist/screens/search.dart';
import 'package:phileaflorist/utils/all_lists.dart';
import 'package:phileaflorist/utils/app_constants.dart';
import 'package:phileaflorist/widgets/Text_widget.dart';
import 'package:phileaflorist/widgets/offer_banner_widget.dart';
import 'package:phileaflorist/widgets/product_display_container_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatelessWidget {
  final _bannerController = PageController();
   repoBunga repobunga =repoBunga();
  late Future<List<Bunga>> listBunga;
  repoGaleri repogaleri=repoGaleri();
  late Future<List<Galeri>> listGaleri;
 
 
  


  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     listBunga=repobunga.getDataBunga();
     listGaleri=repogaleri.getDataGaleri();
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 28),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search()));
                        },
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppConstants.txtFieldColor)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 17,
                              ),
                              Icon(
                                Icons.search,
                                color: AppConstants.primaryColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              TextWidget(
                                txt: "Cari Produk",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                textColor: AppConstants.subTxtColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 19),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoriteProduct()));
                      },
                      child: const Icon(
                        Icons.favorite_border,
                        color: AppConstants.subTxtColor,
                      ),
                    ),
                    const SizedBox(
                      width: 22.8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Notifications()));
                      },
                      child: const Icon(
                        Icons.notifications_none_outlined,
                        color: AppConstants.subTxtColor,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(
                thickness: 1,
                height: 0,
                color: AppConstants.txtFieldColor,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 190,
                child:FutureBuilder<List<Galeri>>(
                  future: listGaleri,
                  builder: (context, snapshot) {
                    print("apa");
                    if(snapshot.hasData){
                      List<Galeri> isidata=snapshot.data!;
                      return PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _bannerController,
                    itemCount: isidata.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Stack(
                          children: [
                            Image.network(
                              "http://fajar.patusaninc.com/foto/"+isidata[index].foto,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 24, top: 32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextWidget(
                                    txt: "Philea Florist",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    textColor: AppConstants.whiteColor,
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  
                                ],
                              ),
                            ),
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
              const SizedBox(
                height: 16,
              ),
              FutureBuilder<List<Galeri>>(
                future: listGaleri,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      List<Galeri> isidata=snapshot.data!;
                      return Center(
                child: SmoothPageIndicator(
                  controller: _bannerController,
                  count: isidata.length,
                  effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Color.fromARGB(255, 40, 197, 92),
                      dotColor: AppConstants.txtFieldColor
                      // strokeWidth: 5,
                      ),
                ),
              );
              }else if (snapshot.hasError){
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
              }
              ),
              
              
              
              const SizedBox(
                height: 12,
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TextWidget(
                      txt: "Penjualan terbaik",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      textColor: AppConstants.titleTextColor,
                    ),
                    TextWidget(
                      txt: "selanjutnya",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      textColor: Color.fromARGB(255, 49, 201, 44),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: SizedBox(
                  height: 244,
                  child: FutureBuilder<List<Bunga>>(
                    future: listBunga,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        List<Bunga> isiData =snapshot.data!;
                        return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: isiData.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ProductDisplayContainer(
                          margin: 16,
                          imagePath: isiData[index].foto,
                          newPrice: isiData[index].harga_akhir.toString(),
                          oldPrice: isiData[index].harga.toString(),
                          discount: isiData[index].diskon.toString(),
                          productName: isiData[index].nama_barang,
                        );
                      });
                      }else if (snapshot.hasError){
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TextWidget(
                      txt: "Bucket",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      textColor: AppConstants.titleTextColor,
                    ),
                    TextWidget(
                      txt: "selanjutnya",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      textColor: AppConstants.primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 9),
                child: SizedBox(
                  height: 244,
                  child: FutureBuilder<List<Bunga>>(
                    future: listBunga,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        List<Bunga> isiData =snapshot.data!;
                        return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: isiData.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ProductDisplayContainer(
                          margin: 16,
                          imagePath: isiData[index].foto,
                          newPrice: isiData[index].harga_akhir.toString(),
                          oldPrice: isiData[index].harga.toString(),
                          discount:  isiData[index].diskon.toString(),
                          productName: isiData[index].nama_barang,
                        );
                      });
                      }else if (snapshot.hasError){
                        return Text("error pak"+"${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "assets/images/coba1.png",
                          height: 206,
                          width: 343,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, top: 48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              TextWidget(
                                txt: "Recomended\nProduct",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                textColor: AppConstants.whiteColor,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextWidget(
                                txt: "We recommend the best for you",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                textColor: AppConstants.whiteColor,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 16),
              //   child: FutureBuilder<List<Bunga>>(
              //       future: listBunga,
              //       builder: (context, snapshot) {
              //         if(snapshot.hasData){
              //           List<Bunga> isiData =snapshot.data!;
              //           return ListView.builder(
              //         physics: const BouncingScrollPhysics(),
              //         itemCount: isiData.length,
              //         scrollDirection: Axis.horizontal,
              //         itemBuilder: (context, index) {
              //           return Padding(
              //             padding: const EdgeInsets.only(left: 10),
              //             child: ProductDisplayContainer(
              //             margin: 16,
              //             imagePath: isiData[index].foto,
              //             newPrice: isiData[index].harga_akhir.toString(),
              //             oldPrice: isiData[index].harga.toString(),
              //             discount: isiData[index].diskon.toString(),
              //             productName: isiData[index].nama_barang,
              //           ),
                      
              //             );
              //         });}else if (snapshot.hasError){
              //           return Text("${snapshot.error}");
              //         }
              //         return const CircularProgressIndicator();
              //       }),
              // ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
