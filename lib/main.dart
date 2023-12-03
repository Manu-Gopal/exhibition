import 'package:exhibition/screens/add_exhibition.dart';
import 'package:exhibition/screens/add_items.dart';
import 'package:exhibition/screens/book_items.dart';
import 'package:exhibition/screens/exhibitor_bookings.dart';
import 'package:exhibition/screens/exhibitor_home.dart';
import 'package:exhibition/screens/exhibitor_list_items.dart';
import 'package:exhibition/screens/add_stall.dart';
import 'package:exhibition/screens/exhibition_manager_login.dart';
import 'package:exhibition/screens/exhibition_manager_account.dart';
import 'package:exhibition/screens/exhibition_manager_main.dart';
import 'package:exhibition/screens/exhibitor_account.dart';
import 'package:exhibition/screens/exhibitor_list_stall.dart';
import 'package:exhibition/screens/exhibitor_login.dart';
import 'package:exhibition/screens/exhibitor_main.dart';
import 'package:exhibition/screens/exhibitor_profile.dart';
import 'package:exhibition/screens/exhibitor_item_accept.dart';
import 'package:exhibition/screens/visitor_account.dart';
import 'package:exhibition/screens/visitor_bookings.dart';
import 'package:exhibition/screens/visitor_list_items.dart';
import 'package:exhibition/screens/visitor_list_stall.dart';
import 'package:exhibition/screens/visitor_login.dart';
import 'package:exhibition/screens/visitor_main.dart';
import 'package:exhibition/screens/visitor_search_item.dart';
import 'package:flutter/material.dart';
import 'package:exhibition/screens/homepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    await Supabase.initialize(
    url: dotenv.env['URL']!,
    anonKey: dotenv.env['PUBLIC_KEY']!
  );
  OneSignal.shared.setAppId(dotenv.env['APP_ID']!);
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
        '/add_exhibition':(context) => const AddExhibition(),
        '/list_stall':(context) => const ExhibitorListStall(),
        '/add_stall' :(context) => const AddStall(),
        '/list_items' :(context) => const ExhibitorListitems(),
        '/add_items' :(context) => const AddItems(),
        '/exhibitor' :(context) => ExhibitorLogin(),
        '/visitor':(context) => VisitorLogin(),
        '/exhibitor_account' :(context) => ExhibitorAccount(),
        '/visitor_account' :(context) => VisitorAccount(),
        '/exhibitor_main' :(context) => const ExhibitorMain(),
        '/visitor_main' :(context) => const VisitorMain(),
        '/visitor_list_stall':(context) => const VisitorListStall(),
        '/visitor_list_items':(context) => const VisitorListitems(),
        '/visitor_search_item':(context) => const VisitorSearchItem(),
        '/book_items':(context) => const BookItems(),
        '/exhibitor_home':(context) => const ExhibitorHome(),
        '/bookings':(context) => const ExhibitorBookings(),
        '/profile':(context) => const ExhibitorProfile(),
        '/exhibitor_item_accept' :(context) => const ItemAccept(),
        '/visitor_bookings' :(context) => const VisitorBookings()
      },
    );
  }
}