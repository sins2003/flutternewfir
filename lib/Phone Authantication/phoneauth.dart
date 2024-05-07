import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutternewfir/main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCxLLzQPvqpdoYAKF0R6k9f5RyB2FUX82A",
          appId: "1:452429422229:android:ba8bb48dca117efcccc59c",
          projectId: "januaryfirebase-1fba9",
          messagingSenderId: ''));

  runApp(MaterialApp(
    home: PhnAuth(),
  ));
}

class PhnAuth extends StatefulWidget {
  @override
  State<PhnAuth> createState() => _PhnAuthState();
}

class _PhnAuthState extends State<PhnAuth> {
  final phoneCntr = TextEditingController();
  final otpCntr = TextEditingController();
  var otpFieldVisibility = false;
  String userNum = "";
  var recieveId = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  void verifyUserPhnNum() {
    auth.verifyPhoneNumber(
      phoneNumber: userNum,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) async {
          if (value.user != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => homepage(),
                ));
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        recieveId = verificationId;
        otpFieldVisibility = true;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
  Future<void>signuot()async{
    await auth.signOut();
  }
  Future<void> verifyOTPcode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: recieveId, smsCode: otpCntr.text);
    await auth.signInWithCredential(credential).then((value) async {
      if (value.user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => homepage(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Auth"),
      ),
      body: Container(
        child: Column(
          children: [
            IntlPhoneField(
              controller: phoneCntr,
              initialCountryCode: "IN",
              decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Phone number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {
                userNum = value.completeNumber;
              },
            ),
            Visibility(
                visible: otpFieldVisibility,
                child: TextField(
                  controller: otpCntr,
                  decoration: InputDecoration(
                      hintText: "OTP",
                      labelText: "OTP",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                )),
            ElevatedButton(
                onPressed: () {
                  if (otpFieldVisibility) {
                    verifyOTPcode();
                  } else {
                    verifyUserPhnNum();
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => homepage(),
                  //     ));
                },
                child: Text(otpFieldVisibility ? "LOGIN" : "Get OTP"))
          ],
        ),
      ),
    );
  }
}
