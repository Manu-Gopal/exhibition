import 'package:exhibition/screens/exhibitor_bookings.dart';
import 'package:exhibition/screens/exhibitor_profile.dart';
import 'package:exhibition/screens/exhibitor_home.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExhibitorMain extends StatefulWidget {
  const ExhibitorMain({Key? key}) : super(key: key);

  @override
  State<ExhibitorMain> createState() => _ExhibitorMainState();
}

class _ExhibitorMainState extends State<ExhibitorMain> {
  final supabase = Supabase.instance.client;
  // ignore: non_constant_identifier_names
  final exhibition_list =
      Supabase.instance.client.from('ex_manager').stream(primaryKey: ['id']).order('id');
      
  dynamic userId = Supabase.instance.client.auth.currentUser!.id;

  dynamic exhibitions;
  bool isLoading = false;
  int _selectedIndex = 0;

  void _onItemTapped( int index) {
    setState(() {
    _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  IndexedStack(
        index: _selectedIndex,
        children:const [
          ExhibitorHome(),
          ExhibitorBookings(),
          ExhibitorProfile()
        ],
        ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 25,
        showUnselectedLabels: true,
        
      )
    );
  }
}
