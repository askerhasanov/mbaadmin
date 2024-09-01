import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mbaadmin/globalVariables.dart';
import 'package:mbaadmin/pages/auth/login.dart';
import 'package:mbaadmin/pages/homepage.dart';
import 'package:mbaadmin/providers/authProvider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => MbaAuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthWrapper(),
      routes: {
        LoginPage.id : (context) => LoginPage(),
        HomePage.id : (context) =>  HomePage(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<MbaAuthProvider>(context);
    return authProvider.isLoggedIn ? HomePage() : LoginPage();
  }
}


