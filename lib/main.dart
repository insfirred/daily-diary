import 'package:daily_diary/screen/register_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './screen/home_screen.dart';
import 'screen/add_progress.dart';
import './screen/progress_added.dart';
import './service/auth_service.dart';
import 'screen/login_user.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(context,FirebaseAuth.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        initialRoute: '/',
        routes: {
          '/':(context) => AuthenticationWrapper(),
          '/add_progress': (context) => AddProgress(),
          '/progress_added': (context) => ProgressAdded(),
          '/authentication_wrapper':(context) => AuthenticationWrapper(),
          '/login_screen':(context) => LoginScreen(),
          '/register_screen':(context) => RegisterScreen(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireBaseUser =  context.watch<User?>();

    if(fireBaseUser!=null){
      return HomeScreen();
    }else{
      return LoginScreen();
    }
  }
}