import 'package:flutter/material.dart';
import 'package:phileaflorist/api/api.dart';

import '../models/category_model.dart';
import '../models/product_display_model.dart';
import '../models/select_colors_model.dart';
import '../models/select_sizes_model.dart';

class AllLists {
  

  List<Bunga> bungaList = [ ];
  List<Galeri> galeriList = [ ];
  List<Kategori> kategotiList = [];
  List<Keranjang> keranjangList = [];
  List<Kontak> kontakList = [];
  List<Profil> profilList = [];

  List<SelectSizesModel> sizesList = [
    SelectSizesModel(size: "6", isSelected: false),
    SelectSizesModel(size: "6.5", isSelected: false),
    SelectSizesModel(size: "7", isSelected: true),
    SelectSizesModel(size: "7.5", isSelected: false),
    SelectSizesModel(size: "8", isSelected: false),
    SelectSizesModel(size: "8.5", isSelected: false),
    SelectSizesModel(size: "9", isSelected: false),
    SelectSizesModel(size: "9.5", isSelected: false),
  ];
  List<SelectColorsModel> colorsList = [
    SelectColorsModel(color: const Color(0xffFFC833), isSelected: true),
    SelectColorsModel(color: const Color(0xff40BFFF), isSelected: false),
    SelectColorsModel(color: const Color(0xffFB7181), isSelected: false),
    SelectColorsModel(color: const Color(0xff53D1B6), isSelected: false),
    SelectColorsModel(color: const Color(0xff5C61F4), isSelected: false),
    SelectColorsModel(color: const Color(0xff223263), isSelected: false),
    SelectColorsModel(color: Colors.blueGrey, isSelected: false),
    SelectColorsModel(color: Colors.indigoAccent, isSelected: false),
  ];
  // diisikan dari gambar barang
  List<String> productImagesList = [
    "assets/images/productimage2.png",
    "assets/images/productimage3.png",
    "assets/images/productimage4.png",
  ];
  // diisikan dari kategori
  List<String> searchList = [
    "Bunga Papan ",
    "Bunga Bucket",
    "Bunga Meja",
    "Bunga Salib",
  ];
  List<String> sortByList = [
    "Time: ending soonest",
    "Time: newly listed",
    "Price + Shipping: lowest first",
    "Price + Shipping: highest first",
    "Distance: nearest first",
  ];
}
