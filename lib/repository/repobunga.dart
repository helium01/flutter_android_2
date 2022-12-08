import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:phileaflorist/api/api.dart';
class repoBunga{
  final baseUrl='http://fajar.basecampskripsi.xyz/api/v1/barang';

  Future<List<Bunga>> getDataBunga()async{
    
      final response=await http.get(Uri.parse(baseUrl));

      if(response.statusCode==200){
        List bunga=json.decode(response.body)['data'];
       
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
  final baseUrl='http://fajar.basecampskripsi.xyz/api/v1/kategori';

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
  final baseUrl='http://fajar.basecampskripsi.xyz/api/v1/keranjang';

  Future<List<Keranjang>> getDataKeranjang()async{
    
      final response=await http.get(Uri.parse(baseUrl));

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
  final baseUrl='http://fajar.basecampskripsi.xyz/api/v1/kontak';

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
  final baseUrl='http://fajar.basecampskripsi.xyz/api/v1/profil';

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
  final baseUrl='http://fajar.basecampskripsi.xyz/api/v1/galeri';

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