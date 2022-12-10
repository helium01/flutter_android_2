import 'package:flutter/material.dart';
import './profile.dart';

abstract class ProfileModel extends State<Profile> {
  late String nama;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      nama = 'Shodiqul Muzaki';
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}