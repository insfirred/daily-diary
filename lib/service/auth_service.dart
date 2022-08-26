import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService{
  final FirebaseAuth firebaseAuth;
  final BuildContext context;

  AuthenticationService(this.context ,this.firebaseAuth);

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future <String> signIn({required String email, required String password}) async{
    try{
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Sign In";
    }
    on FirebaseAuthException catch(e){
      return(e.message.toString());
    }
  }

  Future<String> signUp({required String email, required String password}) async{
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Sign Up";
    }
    on FirebaseAuthException catch(e){
      return(e.message.toString());
    }
  }
}