import 'package:exhibition/screens/add_exhibition.dart';
import 'package:exhibition/screens/exhibition_manager_login.dart';
import 'package:exhibition/screens/exhibition_manager_account.dart';
import 'package:exhibition/screens/exhibition_manager_main.dart';
import 'package:exhibition/screens/exhibitor_account.dart';
import 'package:exhibition/screens/exhibitor_login.dart';
import 'package:exhibition/screens/exhibitor_main.dart';
import 'package:exhibition/screens/visitor_account.dart';
import 'package:exhibition/screens/visitor_login.dart';
import 'package:exhibition/screens/visitor_main.dart';
import 'package:flutter/material.dart';
import 'package:exhibition/screens/homepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    await Supabase.initialize(
    url: dotenv.env['URL']!,
    anonKey: dotenv.env['PUBLIC_KEY']!
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "EMS",
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/exhibition_manager_account' :(context) => ExhibitionManagerAccount(),
        '/exhibition_manager' :(context) => ExhibitionManagerLogin(),
        '/exhibition_manager_main' :(context) => const ExhibitionManagerMain(),
        '/add_exhibition':(context) => AddExhibition(),
        '/exhibitor' :(context) => ExhibitorLogin(),
        '/visitor':(context) => VisitorLogin(),
        '/exhibitor_account' :(context) => ExhibitorAccount(),
        '/visitor_account' :(context) => VisitorAccount(),
        '/exhibitor_main' :(context) => const ExhibitorMain(),
        '/visitor_main' :(context) => const VisitorMain(),
      },
    );
  }
}