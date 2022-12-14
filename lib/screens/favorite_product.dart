
import 'package:flutter/material.dart';
import 'package:phileaflorist/screens/home.dart';
import 'package:phileaflorist/utils/app_constants.dart';

import '../utils/all_lists.dart';
import '../widgets/Text_widget.dart';
import '../widgets/product_display_container_widget.dart';

class FavoriteProduct extends StatelessWidget {
  final _lists = AllLists();

  FavoriteProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 26, left: 16, right: 16),
                child: Row(
                  children:  [
                    TextButton(
                      onPressed: (){
                           Navigator.push(
                    context,
                    // DetailPage adalah halaman yang dituju 
                    MaterialPageRoute(
                      builder: (context) => Home()
                    ),
                  );
                      }, 
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppConstants.subTxtColor,
                      size: 18,
                    ),),
                    
                    SizedBox(
                      width: 21,
                    ),
                    Expanded(
                        child: TextWidget(
                      txt: "Favorit produk ",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      textColor: AppConstants.titleTextColor,
                    )),
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
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 271,
                    ),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _lists.bungaList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: ProductDisplayContainer(
                          id: _lists.bungaList[index].id,
                          imagePath:
                              _lists.bungaList[index].foto,
                          newPrice:
                              _lists.bungaList[index].harga_akhir.toString(),
                          oldPrice:
                              _lists.bungaList[index].harga.toString(),
                          discount:
                              _lists.bungaList[index].diskon.toString(),
                          productName:
                              _lists.bungaList[index].nama_barang,
                          addRating: true,
                          addDeleteButton: true,
                          margin: 0,
                        ),
                      );
                    }),
              ),
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
