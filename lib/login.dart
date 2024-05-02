import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternewfir/Database/FireBaseHelper.dart';
import 'package:flutternewfir/main.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? lemail;
  String? lpass;
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
                "LOGIN",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              )),
              TextFormField(
                validator: (email) {
                  if (email!.isEmpty ||
                      !email.contains(".") ||
                      !email.contains("@")) {
                    return "Please enter valid email";
                  }else{
                    return null;
                  }
                },
                onSaved: (eemail) {
                  lemail = eemail;
                },
                decoration: InputDecoration(
                    labelText: "E-mail",
                    hintText: "E-mail",
                    prefixIcon: Icon(Icons.email)),
              ),
              TextFormField(
                validator: (password) {
                  if(password!.isEmpty||password.length<6){
                    return "Please enter valid passord";
                  }else{
                    return null;
                  }
                },
                onSaved: (epass) {
                  lpass = epass;
                },
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    prefixIcon: Icon(Icons.password)),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(onPressed: () {
                if(formkey.currentState!.validate()){
                  formkey.currentState!.save();
                  firebaseHelper().signin(mail: lemail!, password: lpass!).then((value){
                    if(value==null){
                      Get.to(homepage());
                    }else{
                      Get.snackbar("error", value);
                    }
                  });
                }
              }, child: Text("LOG IN")),
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
