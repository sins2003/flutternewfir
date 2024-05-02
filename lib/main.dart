import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternewfir/Database/FireBaseHelper.dart';
import 'package:flutternewfir/login.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class homepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ElevatedButton(onPressed: () {firebaseHelper().signuot().then((value){
          Get.to(LoginPage());
        });  }, child: Text("Sign out"),),
      ),
    );
  }
}