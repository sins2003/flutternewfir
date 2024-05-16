import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCxLLzQPvqpdoYAKF0R6k9f5RyB2FUX82A",
          appId: "1:452429422229:android:ba8bb48dca117efcccc59c",
          projectId: "januaryfirebase-1fba9",
          messagingSenderId: '',
          storageBucket: "januaryfirebase-1fba9.appspot.com"));
  runApp(MaterialApp(
    home: cludefire(),
  ));
}

class cludefire extends StatefulWidget {
  @override
  State<cludefire> createState() => _cludefireState();
}

class _cludefireState extends State<cludefire> {
  var namectr = TextEditingController();
  var passctr = TextEditingController();
  late CollectionReference userCollection;

  @override
  void initState() {
    userCollection = FirebaseFirestore.instance.collection("users");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: namectr,
              decoration:
                  InputDecoration(hintText: "Email", labelText: "Email"),
            ),
            TextField(
              controller: passctr,
              decoration:
                  InputDecoration(hintText: "password", labelText: "Password"),
            ),
            ElevatedButton(
                onPressed: () {
                  addUser();
                  namectr.text = '';
                  passctr.text = '';
                },
                child: Text("Log in")),
            StreamBuilder<QuerySnapshot>(
              stream: getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                final users = snapshot.data!.docs;
                return Expanded(
                    child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final userid = user.id;
                    final useremail = user['email'];
                    final userpass = user['password'];
                    return ListTile(
                      title: Text('$useremail'),
                      subtitle: Text('$userpass'),
                      trailing: Wrap(
                        children: [
                          IconButton(
                              onPressed: () {
                                editUser(userid);
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                // deleteuser(userid);
                              },
                              icon: Icon(CupertinoIcons.delete))
                        ],
                      ),
                    );
                  },
                ));
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> addUser() async {
    userCollection.add({
      'email': namectr.text,
      'password': passctr.text,
    }).then((value) {
      print("user add successfully");
      namectr.clear();
      passctr.clear();
    }).catchError((error) {
      print("failed to add user $error");
    });
  }

  Stream<QuerySnapshot> getUser() {
    return userCollection.snapshots();
  }

  void editUser(var id) {
    showDialog(context: context, builder: (context) {
      final newname_cntr=TextEditingController();
      final newemail_cnt=TextEditingController();

      return AlertDialog(
        title: Text("Update User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newname_cntr,
              decoration: InputDecoration(
                hintText: "Enter name",border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: newemail_cnt,
              decoration: InputDecoration(
                hintText: "Ente email",border: OutlineInputBorder()
              ),
            )
          ],
        ),
        actions: [
          TextButton(onPressed: () {
            updateUser(id,newname_cntr.text,newemail_cnt.text).then((value){
              Navigator.pop(context);
            });
          }, child: Text("Update"))
        ],
      );
    },);
  }
}
