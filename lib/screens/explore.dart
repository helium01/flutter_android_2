
import 'package:flutter/material.dart';
import 'package:phileaflorist/api/api.dart';
import 'package:phileaflorist/repository/repobunga.dart';
import 'package:phileaflorist/screens/search.dart';

import '../utils/all_lists.dart';
import '../utils/app_constants.dart';
import '../widgets/Text_widget.dart';
import '../widgets/category_container_widget.dart';
import '../widgets/product_display_container_widget.dart';
import 'favorite_product.dart';
import 'notifications.dart';

class Explore extends StatelessWidget {
  final _lists = AllLists();
   repoBunga repobunga =repoBunga();
  late Future<List<Bunga>> listBunga;

 
 
  Explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     listBunga=repobunga.getDataBunga();
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                            children: const [
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
                                builder: (context) => const Notifications()));
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWidget(
                      txt: "Bunga",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      textColor: AppConstants.titleTextColor,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SingleChildScrollView(
                child:Container(
                
                child: FutureBuilder<List<Bunga>>(
                    future: listBunga,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        List<Bunga> isiData =snapshot.data!;
                        return GridView.builder(
                          
                          shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300-4,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: isiData.length,
            itemBuilder: (BuildContext ctx, index) {
              return ProductDisplayContainer(
                
                          id: isiData[index].id.toString(),
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
                
                
                
              )
              ),
                    const SizedBox(
                      height: 24,
                    ),
                   
                    const SizedBox(
                      height: 16,
                    ),
                   
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
