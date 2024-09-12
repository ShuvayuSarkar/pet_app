import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/firebase_options.dart';
import 'package:pet_app/pages/registerpage.dart';
import 'package:pet_app/services/auth/auth_gate.dart';
import 'package:pet_app/services/auth/database/database_provider.dart';
import 'package:pet_app/services/auth/login_or_register.dart';
import 'package:pet_app/themes/theme_provider.dart';
import 'pages/home_page.dart';
import 'components/my_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pet_app/pages/login_page.dart';

void main() async {
  //firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        //theme provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

        //database provider
        ChangeNotifierProvider(create: (context) => DatbaseProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
