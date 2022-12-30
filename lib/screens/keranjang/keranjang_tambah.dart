import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:phileaflorist/api/api.dart';
import 'package:phileaflorist/repository/repobunga.dart';
import 'package:phileaflorist/screens/keranjang/keranjang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class tambah_keranjang extends StatefulWidget{
  final String id;
  tambah_keranjang({
    required this.id,
  });
  @override
  _tambah_keranjang createState() => _tambah_keranjang(id: id);
}

class _tambah_keranjang extends State<tambah_keranjang> {
  // const _tambah_keranjang({super.key});
  int dataint=0;
  bool _isLoading = false;
 late int id_user,id_barang,jumlah_barang;
 late String kode_barang,nama_barang,tanggal;
  bool _secureText = true;
  var userdata;
  final String id;
  _tambah_keranjang({
    required this.id,
    // super.key
  });
@override
void initState(){
  _getUserInfo();
  super.initState();
}
void _menambah(){
  setState(() {
    dataint++;
    // dataint.toUnsigned(64);
  });
}
void _mengurang(){
  setState(() {
    dataint--;
    if(dataint<=0){
      dataint=0;
    }
    // dataint.toUnsigned(64);
  });
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
     final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("keranjang philea florist bali"),
      ),
      body: ListView(
        children: <Widget>[
Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: FutureBuilder<Bunga2>(
                    future: coba,
                    builder: (context, snapshot) {
                      // print("kok bisa ya");
                      // print(snapshot.hasData);
                      if (snapshot.hasData) {
                        return Column(
            children: [
              // TextField(),
              TextFormField(
                decoration: new InputDecoration(
                  
                  hintText: "contoh: fajar yuris",
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
                initialValue: snapshot.data!.id.toString(),
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
                initialValue: snapshot.data!.kode_barang,
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
                initialValue: snapshot.data!.nama_barang,
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
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  hintText: "contoh: fajar yuris",
                  labelText: "jumlah barang",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                readOnly: true , 
                initialValue: dataint.toString(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  jumlah_barang=int.parse(value);
                  return null;
                },
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      FloatingActionButton(
                onPressed: _menambah,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
              // SizedBox(width: 50,),
              FloatingActionButton(
                onPressed: _mengurang,
                tooltip: 'Increment',
                child: const Icon(Icons.do_disturb_on_outlined),
              ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            child: Text(
                              _isLoading? 'Proccessing..' : 'submit',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _keranjang(id_user);
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
              )
            ],
          )
          
          
          
          
          
        ),
        )
      ),
        ],
      )
      
    );
  }
  void _keranjang(id)async{
     setState(() {
      _isLoading = true;
    });
    var data = {
      'id_user' : id_user,
      'id_barang' : id_barang,
      'kode_barang' : kode_barang,
      'nama_barang' :nama_barang,
      'tanggal' :tanggal,
      'jumlah_barang' :jumlah_barang
    };
    print(data);
    var res = await Network().authDataPost(data, '/keranjang/tambah/post/'+id.toString());
    var body = json.decode(res.body);
   print(body);
    if(body['data'] !=null){
 print(body);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => keranjang()
          ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}