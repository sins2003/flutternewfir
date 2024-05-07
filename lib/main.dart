import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternewfir/login.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class homepage extends StatelessWidget{
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(onPressed: () {
            Future<void>signuot()async{
              await auth.signOut();
            } signuot().then((value){

            Get.to(LoginPage());
          });  }, child: Text("Sign out"),),
        ),
      ),
    );
  }
}