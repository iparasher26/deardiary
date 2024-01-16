import 'package:deardiary/app/home_page.dart';
import 'package:deardiary/app/new_journal.dart';
import 'package:deardiary/app/viewjournal_cubes.dart';
import 'package:deardiary/firebase_functions.dart';
import 'package:deardiary/provider/addTask_provider.dart';
import 'package:deardiary/provider/newJournal_provider.dart';
import 'package:deardiary/user_authentication/login_page.dart';
import 'package:deardiary/user_authentication/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async{
  //step1 import packages
  //step2 these 2 lines under main
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  MultiProvider build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> NewJournalProvider()),
        ChangeNotifierProvider(create: (_)=> AddTaskProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FirebaseFunction().getUserId()!="" ? HomePage() : SignUpPage(),
        routes: {
          'sign-up': (context) => SignUpPage(),
          'log-in': (context) => LoginPage(),
          'home': (context) => HomePage(),
          'newJournal' : (context) => NewJournal(),
        },
      ),
    );
  }
}
