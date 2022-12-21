import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phileaflorist/repository/repobunga.dart';
import 'package:phileaflorist/screens/keranjang/keranjang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class tambah_keranjang extends StatefulWidget{
  _tambah_keranjang createState() => _tambah_keranjang();
}

class _tambah_keranjang extends State<tambah_keranjang> {
  // const tambah_keranjang({super.key});
  bool _isLoading = false;
 late int id_user,id_barang,jumlah_barang;
 late String kode_barang,nama_barang,tanggal;
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
     final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("keranjang philea florist bali"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
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
                    _keranjang(id_user);
                  }
                },
              ),
            ],
          ),
        ),
      ),
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
    }else{
      if(body['message']['name'] != null){
        _showMsg(body['message']['name'][0].toString());
      }
      else if(body['message']['email'] != null){
        _showMsg(body['message']['email'][0].toString());
      }
      else if(body['message']['password'] != null){
        _showMsg(body['message']['password'][0].toString());
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
}