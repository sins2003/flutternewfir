import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cludefire extends StatefulWidget{
  @override
  State<cludefire> createState() => _cludefireState();
}

class _cludefireState extends State<cludefire> {
  var namectr=TextEditingController();
  var passctr=TextEditingController();
  late CollectionReference userCollection;
  
  @override
  void initState() {
    userCollection=FirebaseFirestore.instance.collection("users");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Column(
        children: [
          TextField(decoration: InputDecoration(
            hintText: "Email",
            labelText: "Email"
          ),),
          TextField(
            decoration: InputDecoration(hintText: "password",labelText: "Password"),
          ),
          ElevatedButton(onPressed: () {
            addUser();
          }, child: Text("Log in"))
        ],
      ),),
    );
  }

  Future<void> addUser() async{

  }
}