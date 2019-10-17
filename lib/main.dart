import 'package:flutter/material.dart';
import 'package:hackerkernel/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'home.dart';

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(MaterialApp(home: email == null ? Login() : Home()));
}

