import 'package:battleship/screens/defence_screen.dart';
import 'package:battleship/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:battleship/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: Home_Screen.id,
      routes: {
        Home_Screen.id:(context)=>Home_Screen(),
      },
    );
  }
}

