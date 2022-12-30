
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/product_display_container_widget.dart';

class Search extends StatefulWidget {
  Search() : super();

  @override
  JobsState createState() => JobsState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class JobsState extends State<Search> {
  final _debouncer = Debouncer();

  List<Subject> ulist = [];
  List<Subject> userLists = [];
  //API call for All Subject List

  String url = 'http://fajar.patusaninc.com/api/v1/barang';

  Future<List<Subject>> getAllulistList() async {
    final response=await http.get(Uri.parse(url));
     if(response.statusCode==200){
        List bunga=json.decode(response.body)['data'];
      //  print(bunga);
        // // print(response);
        // Iterable it =jsonDecode(response.body);
        // List<Bunga> bunga=it.map((e)=>Bunga.fromJson(e)).toList();
        return bunga.map((data) => Subject.fromJson(data)).toList();
      }else{
        throw Exception('failed to load data');
      }
  }

  // static List<Subject> parseAgents(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<Subject>((json) => Subject.fromJson(json)).toList();
  // }

  @override
  void initState() {
    super.initState();
    getAllulistList().then((subjectFromServer) {
      setState(() {
        ulist = subjectFromServer;
        userLists = ulist;
      });
    });
  }

  //Main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'bunga philea florist',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Column(
        children: <Widget>[
          //Search Bar to List of typed Subject
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                suffixIcon: InkWell(
                  child: Icon(Icons.search),
                ),
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Search ',
              ),
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    userLists = ulist
                        .where(
                          (u) => (u.nama_barang.toLowerCase().contains(
                                string.toLowerCase(),
                              )),
                        )
                        .toList();
                  });
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.all(5),
              itemCount: userLists.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ProductDisplayContainer(
                          id: userLists[index].id.toString(),
                          margin: 16,
                          imagePath: userLists[index].foto,
                          newPrice: userLists[index].harga_akhir.toString(),
                          oldPrice: userLists[index].harga.toString(),
                          discount: userLists[index].diskon.toString(),
                          productName: userLists[index].nama_barang,
                        )
                        
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//Declare Subject class for json data or parameters of json string/data
//Class For Subject
class Subject {
  final String id;
  final String id_kategori;
  final String nama_barang;
  final String foto;
  final String deskripsi;
  final String diskon;
  final String harga;
  final String stok;
  final String harga_akhir;
  final String nama_kategori;
  Subject({
   required this.id,
    required this.id_kategori,
    required this.nama_barang,
    required this.deskripsi,
    required this.diskon,
    required this.foto,
    required this.harga,
    required this.harga_akhir,
    required this.nama_kategori,
    required this.stok,
  });

  factory Subject.fromJson(Map<dynamic, dynamic> json) {
    print(json);
    return Subject(id: json['id'], id_kategori: json['id_kategori'], 
    nama_barang: json['nama_barang'], deskripsi: json['deskripsi'], diskon: json['diskon'], foto: json['foto'], 
    harga: json['harga'], harga_akhir: json['harga_akhir'], nama_kategori: json['nama_kategori'], stok: json['stok']);
  }
}
