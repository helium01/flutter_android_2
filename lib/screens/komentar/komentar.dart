import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:phileaflorist/api/api.dart';
import 'package:phileaflorist/repository/repobunga.dart';
import 'package:phileaflorist/screens/home.dart';
import 'package:phileaflorist/screens/produk/produk_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class komentar extends StatefulWidget{
  @override
  final String id;
  komentar({
    required this.id
  });
  _komentar createState() => _komentar(id: id);
}

class _komentar extends State<komentar> {
  // const _komentar({super.key});
  final String id;
  _komentar({
    required this.id,
  });
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var id_user, id_barang,bintang,email,pesan,userdata;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("komentar philea florist bali"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
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
                initialValue: userdata['id'].toString(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  id_user=int.parse(value);
                  return null;
                },
              ),
              SizedBox(height: 18),
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
                  labelText: "bintang",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  bintang=int.parse(value);
                  return null;
                },
              ),
              SizedBox(height: 18),
              TextFormField(
                decoration: new InputDecoration(
                  hintText: "contoh: fajar yuris",
                  labelText: "email",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                readOnly: true,
                initialValue: userdata['email'],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  email=value;
                  return null;
                },
              ),
              SizedBox(height: 18),
              TextFormField(
                decoration: new InputDecoration(
                  hintText: "contoh: fajar yuris",
                  labelText: "pesan",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  pesan=value;
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
                    _login();
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
    );
  }
    void _login() async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'id_user':id_user,
      'id_barang':id_barang,
      'bintang': bintang,
      'email':email,
      'pesan':pesan,
    };
  print(data);
   var res = await Network().authDataPost(data, '/testimoni/tambah/post');
    var body = json.decode(res.body);
    print(body);
    print('saya');
    if(body['data'] != null){
     
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (context) => Home()
          ),
      );
    }else{
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}