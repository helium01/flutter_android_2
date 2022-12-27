import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phileaflorist/repository/repobunga.dart';
import 'package:phileaflorist/screens/home.dart';

import '../../api/api.dart';
import '../../widgets/product_display_container_widget.dart';

class Populer extends StatelessWidget {
  Populer({super.key});
  repoPopuler repopopuler =repoPopuler();
  late Future<List<BungaPopuler>> listPopuler;

  @override
  Widget build(BuildContext context) {
    listPopuler=repopopuler.getDataBungaPopuler();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: TextButton(
              style: TextButton.styleFrom(
                        backgroundColor: Color(0xffF18265)),
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home()));
                    },
                    child: Icon(Icons.home),
                  ),
            
            title: Text("populer"),
          ),
          body: Container(
                
                child: FutureBuilder<List<BungaPopuler>>(
                    future: listPopuler,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        List<BungaPopuler> isiData =snapshot.data!;
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
              )
    );
  }
}