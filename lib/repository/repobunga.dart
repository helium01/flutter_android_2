import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:phileaflorist/api/api.dart';
class repoBunga{
  final baseUrl='http://fajar.patusaninc.com/api/v1/barang';

  Future<List<Bunga>> getDataBunga()async{
    
      final response=await http.get(Uri.parse(baseUrl));

      if(response.statusCode==200){
        List bunga=json.decode(response.body)['data'];
      //  print(bunga);
        // // print(response);
        // Iterable it =jsonDecode(response.body);
        // List<Bunga> bunga=it.map((e)=>Bunga.fromJson(e)).toList();
        return bunga.map((data) => Bunga.fromJson(data)).toList();
      }else{
        throw Exception('failed to load data');
      }
  }
}
class repoKategori{
  final baseUrl='http://fajar.patusaninc.com/api/v1/kategori';

  Future<List<Kategori>> getDataKategori()async{
    
      final response=await http.get(Uri.parse(baseUrl));

      if(response.statusCode==200){
        List kategori=json.decode(response.body)['data'];
       
        // // print(response);
        // Iterable it =jsonDecode(response.body);
        // List<Bunga> bunga=it.map((e)=>Bunga.fromJson(e)).toList();
        return kategori.map((data) => Kategori.fromJson(data)).toList();
      }else{
        throw Exception('failed to load data');
      }
  }
}
class repoKeranjang{
  final baseUrl='http://fajar.patusaninc.com/api/v1/keranjang';

  Future<List<Keranjang>> getDataKeranjang(apiUrl)async{
    
      final response=await http.get(Uri.parse(baseUrl+apiUrl));

      if(response.statusCode==200){
        List keranjang=json.decode(response.body)['data'];
       
        // // print(response);
        // Iterable it =jsonDecode(response.body);
        // List<Bunga> bunga=it.map((e)=>Bunga.fromJson(e)).toList();
        return keranjang.map((data) => Keranjang.fromJson(data)).toList();
      }else{
        throw Exception('failed to load data');
      }
  }
}
class repoKontak{
  final baseUrl='http://fajar.patusaninc.com/api/v1/kontak';

  Future<List<Kontak>> getDataKontak()async{
    
      final response=await http.get(Uri.parse(baseUrl));

      if(response.statusCode==200){
        List kontak=json.decode(response.body)['data'];
       
        // // print(response);
        // Iterable it =jsonDecode(response.body);
        // List<Bunga> bunga=it.map((e)=>Bunga.fromJson(e)).toList();
        return kontak.map((data) => Kontak.fromJson(data)).toList();
      }else{
        throw Exception('failed to load data');
      }
  }
}
class repoProfil{
  final baseUrl='http://fajar.patusaninc.com/api/v1/profil';

  Future<List<Profil>> getDataProfil()async{
    
      final response=await http.get(Uri.parse(baseUrl));

      if(response.statusCode==200){
        List profil=json.decode(response.body)['data'];
       
        // // print(response);
        // Iterable it =jsonDecode(response.body);
        // List<Bunga> bunga=it.map((e)=>Bunga.fromJson(e)).toList();
        return profil.map((data) => Profil.fromJson(data)).toList();
      }else{
        throw Exception('failed to load data');
      }
  }
}
class repoGaleri{
  final baseUrl='http://fajar.patusaninc.com/api/v1/galeri';

  Future<List<Galeri>> getDataGaleri()async{
    
      final response=await http.get(Uri.parse(baseUrl));

      if(response.statusCode==200){
        List galeri=json.decode(response.body)['data'];
       
        // // print(response);
        // Iterable it =jsonDecode(response.body);
        // List<Bunga> bunga=it.map((e)=>Bunga.fromJson(e)).toList();
        return galeri.map((data) => Galeri.fromJson(data)).toList();
      }else{
        throw Exception('failed to load data');
      }
  }
}
class Network{
  final String _url = 'http://fajar.patusaninc.com/api/v1/auth';
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
  var userJson = localStorage.getString('token');
    // token = json.decode(userJson.toString());
  token = localStorage.getString('token');
    print(token);
  }

  authDataPost(data, apiUrl) async {
    // print("indonesia merdeka");
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }
  authDataGet(apiUrl) async{
    var fulUrl=_url+apiUrl;
    return await http.post(
      Uri.parse(fulUrl),
      headers: _setHeaders(),
      );
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    // print(fullUrl);
    await _getToken();
    print(_setHeaders());
    return await http.post(
         Uri.parse(fullUrl),
        headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

}
