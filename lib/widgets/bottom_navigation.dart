
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phileaflorist/repository/repobunga.dart';
import 'package:phileaflorist/utils/all_lists.dart';
import 'package:phileaflorist/utils/app_constants.dart';

import '../api/api.dart';
import '../screens/account.dart';
import '../screens/cart.dart';
import '../screens/explore.dart';
import '../screens/home.dart';
import '../screens/offer.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<Widget> screenList = [
    Home(),
    Explore(),
    Cart(),
    Offer(),
    Account(),
  ];
  final _lists = AllLists();

  repoBunga repobunga =repoBunga();
  late Future<List<Bunga>> listBunga;
  getDataB()async{
    _lists.bungaList=await repobunga.getDataBunga();
    
  }
  repoGaleri repogaleri = repoGaleri();
  getDataG()async{
    _lists.galeriList= await repogaleri.getDataGaleri();
  }

  repoKategori repokategori =repoKategori();
  getDataK()async{
    _lists.kategotiList=await repokategori.getDataKategori();
  }
  repoKeranjang repokeranjang =repoKeranjang();
 
  repoProfil repoprofil =repoProfil();
  getDataP()async{
    _lists.profilList=await repoprofil.getDataProfil();
  }

@override
void initState() { 
  getDataB();
  getDataG();
  getDataK();
  getDataP();
  super.initState();
  listBunga=repobunga.getDataBunga();
  
}

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppConstants.whiteColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color.fromARGB(255, 55, 218, 49),
        unselectedItemColor: AppConstants.subTxtColor,
        elevation: 5,
        selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: Color.fromARGB(255, 114, 204, 40)),
        unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            color: AppConstants.subTxtColor),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pencarian',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined),
            label: 'Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Akun',
          ),
        ],
      ),
      body: screenList.elementAt(_selectedIndex),
    );
  }
}
