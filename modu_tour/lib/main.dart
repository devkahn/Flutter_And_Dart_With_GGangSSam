import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modu_tour/Defines/Defines.dart';
import 'package:modu_tour/Views/ViewLogin.dart';
import 'package:modu_tour/Views/ViewMainPage.dart';
import 'package:modu_tour/Views/ViewSign.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Defines.APP_NAME,
      theme: ThemeData( primarySwatch: Colors.blue,),
      initialRoute: Defines.PAGE_NAME_LOGIN,
      routes: {
        Defines.PAGE_NAME_LOGIN : (context) => ViewLogin(),
        Defines.PAGE_NAME_SIGN : (context) => ViewSign(),
        Defines.PAGE_NAME_MAIN: (context) =>ViewMainPage(),
      },

    );
  }
}

