import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phileaflorist/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:phileaflorist/repository/repobunga.dart';
import 'package:phileaflorist/screens/keranjang/keranjang.dart';
import 'package:phileaflorist/screens/pay_by_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkout extends StatefulWidget{
  final String id;
  Checkout({
    required this.id,
  });

@override
  _Checkout createState() => _Checkout(id: id);
}

class _Checkout extends State<Checkout> {
  // const _Checkout({super.key});
  final String id;
  _Checkout({
    required this.id,
  });
  bool _isLoading = false;
  late int id_user,id_barang,jumlah_barang,harga,id_keranjang;
 late String kode_barang,nama_barang,tanggal,kurir,kota,kabupaten;
 bool _secureText = true;
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

showHide(){
    setState(() {
      _secureText = !_secureText;
    });
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



  @override
  Widget build(BuildContext context) {
    if(userdata==null){
      return const CircularProgressIndicator();
    }
    print(id);
    final baseUrl='http://fajar.patusaninc.com/api/v1/order/'+id;
  Future<List<Checkoutt>> getDetailBunga()async{
  // print(baseUrl+id);
    final response=await http.get(Uri.parse(baseUrl));
     if(response.statusCode==200){
         List kategori=json.decode(response.body)['data'];
       
        // // print(response);
        // Iterable it =jsonDecode(response.body);
        // List<Bunga> bunga=it.map((e)=>Bunga.fromJson(e)).toList();
        return kategori.map((data) => Checkoutt.fromJson(data)).toList();
      }else{
        throw Exception('failed to load data');
      }

  }
  late Future<List<Checkoutt>> coba;
  coba=getDetailBunga();
  
     final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("checkout philea florist bali"),
      ),
      body: Stack(children: [
        ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: FutureBuilder<List<Checkoutt>>(
                    future: coba,
                    builder: (context, snapshot) {
                      List<Checkoutt> isidata=snapshot.data!;
                      // print("kok bisa ya");
                      if (snapshot.hasData) {
                        return Column(
            children: [
              // TextField(),
              TextFormField(
                decoration: new InputDecoration(
                  
                  hintText: "contoh: 1",
                  labelText: "id keranjang",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                readOnly: true,
                initialValue: "${isidata[0].id}",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  id_keranjang=int.parse(value);
                  return null;
                },
              ),

              SizedBox(height: 18,),
              TextFormField(
                decoration: new InputDecoration(
                  
                  hintText: "contoh: 1",
                  labelText: "id user",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                readOnly: true,
                initialValue: "${userdata['id']}",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  id_user=int.parse(value);
                  return null;
                },
              ),
              SizedBox(height: 18,),
               TextFormField(
                decoration: new InputDecoration(
                  hintText: "contoh: fajar yuris",
                  labelText: "id barang",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                readOnly: true,
                initialValue: isidata[0].id_barang,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  id_barang=int.parse(value);
                  return null;
                },
              ),
              SizedBox(height: 18),
              TextFormField(
                decoration: new InputDecoration(
                  hintText: "contoh: fajar yuris",
                  labelText: "kode barang",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                readOnly: true,
                initialValue: isidata[0].kode_barang,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  kode_barang=value;
                  return null;
                },
              ),
              SizedBox(height: 18),
              TextFormField(
                decoration: new InputDecoration(
                  hintText: "contoh: fajar yuris",
                  labelText: "nama barang",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                readOnly: true,
                initialValue: isidata[0].nama_barang,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  nama_barang=value;
                  return null;
                },
              ),
              SizedBox(height: 18),
              TextFormField(
                decoration: new InputDecoration(
                  hintText: "contoh: fajar yuris",
                  labelText: "jenis pengiriman",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                readOnly: true,
                initialValue: "jne",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  kurir=value;
                  return null;
                },
              ),  
              SizedBox(height: 18),
              TextFormField(
                decoration: new InputDecoration(
                  hintText: "contoh: fajar yuris",
                  labelText: "kota",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  kota=value;
                  return null;
                },
              ),
              SizedBox(height: 18),
              TextFormField(
                decoration: new InputDecoration(
                  hintText: "contoh: fajar yuris",
                  labelText: "kabupaten",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  kabupaten=value;
                  return null;
                },
              ),
              SizedBox(height: 18),
              TextFormField(
                decoration: new InputDecoration(
                  hintText: "contoh: fajar yuris",
                  labelText: "total_harga",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                readOnly: true,
                initialValue: isidata[0].harga_akhir,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  harga=int.parse(value);
                  return null;
                },
              ),
              SizedBox(height: 18),
              TextFormField(
                decoration: new InputDecoration(
                  hintText: "contoh: fajar yuris",
                  labelText: "tanggal",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                readOnly: true , 
                 initialValue: DateTime.now().toString(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  tanggal=value;
                  return null;
                },
              ),
              SizedBox(height: 18),
              TextFormField(
                decoration: new InputDecoration(
                  hintText: "contoh: fajar yuris",
                  labelText: "jumlah barang",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                readOnly: true,
                initialValue: isidata[0].jumlah_keranjang,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  jumlah_barang=int.parse(value);
                  return null;
                },
              ),
              SizedBox(height: 18),
              ElevatedButton(
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _checkoutt();
                  }
                },
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
      ),
          ],
        ),
      ],)
      
      
      
      
      
      
    );
  }
  void _checkoutt()async{
    // print("sampe sini");
    setState(() {
      _isLoading=true;
    });
    var data = {
      'id_user' : id_user,
      'id_barang' : id_barang,
      'kode_barang' : kode_barang,
      'nama_barang' :nama_barang,
      'kurir' : kurir,
      'kota' : kota,
      'kabupaten' :kota,
      'total_harga' :harga,
      'tanggal' :tanggal,
      'jumlah_barang' :jumlah_barang,
      'id_keranjang':id_keranjang
    };
    // print(data);
    var res = await Network().authDataPost(data, '/post/checkout');
    var body = json.decode(res.body);
   print(body);
    // if(body['data'] !=null){
//  print(body);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PayByCard()
          ),
      );
    // }else{
    //   if(body['message']['name'] != null){
    //     _showMsg(body['message']['name'][0].toString());
    //   }
    //   else if(body['message']['email'] != null){
    //     _showMsg(body['message']['email'][0].toString());
    //   }
    //   else if(body['message']['password'] != null){
    //     _showMsg(body['message']['password'][0].toString());
    //   }
    // }

    setState(() {
      _isLoading = false;
    });
  }
}