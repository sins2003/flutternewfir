import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternewfir/Database/FireBaseHelper.dart';
import 'package:flutternewfir/login.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? sname;
  String? semail;
  String? spass;
  String? sconpass;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FIREBASE"),
      ),
      body: Container(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Center(
                  child: Text(
                "SIGN UP",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              )),
              TextFormField(
                validator: (name) {
                  if (name!.isEmpty) {
                    return "enter a name";
                  } else {
                    return null;
                  }
                },
                onSaved: (ename) {
                  sname = ename;
                },
                decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Name",
                    prefixIcon: Icon(Icons.person)),
              ),
              TextFormField(
                validator: (email) {
                  if (email!.isEmpty ||
                      !email.contains(".") ||
                      !email.contains("@")) {
                    return "Please enter valid email";
                  } else {
                    return null;
                  }
                },
                onSaved: (eemail) {
                  semail = eemail;
                },
                decoration: InputDecoration(
                    labelText: "E-mail",
                    hintText: "E-mail",
                    prefixIcon: Icon(Icons.email)),
              ),
              TextFormField(
                validator: (password) {
                  if (password!.isEmpty || password.length < 6) {
                    return "please enter valid password";
                  } else {
                    return null;
                  }
                },
                onSaved: (epass) {
                  spass = epass;
                },
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    prefixIcon: Icon(Icons.password)),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      firebaseHelper()
                          .SignUp(mail: semail!, password: spass!)
                          .then((value) {
                        if (value == null) {
                          Get.to(LoginPage());
                        } else {
                          Get.snackbar("Error", value);
                        }
                      });
                    } else {}
                  },
                  child: Text("LOG IN")),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text("dont have a account? Create an account"))
            ],
          ),
        ),
      ),
    );
  }
}
