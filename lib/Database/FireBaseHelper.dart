import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class firebaseHelper{
  final FirebaseAuth auth = FirebaseAuth.instance;
  get user => auth.currentUser;
   Future<String?>SignUp({required String mail,required String password})async{
     try{
       await auth.createUserWithEmailAndPassword(email: mail, password: password);
       return null;
     }on FirebaseAuthException catch(e){
       return e.message;
     }
   }
   Future<String?>signin({required String mail,required String password})async{
     try{
       await auth.signInWithEmailAndPassword(email: mail, password: password);
       return null;

     }on FirebaseException catch(e){
       return e.message;
     }
   }
   Future<void>signuot()async{
     await auth.signOut();
   }
}