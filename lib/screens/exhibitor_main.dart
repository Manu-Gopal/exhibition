import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExhibitorMain extends StatefulWidget {
  const ExhibitorMain({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExhibitorMainState createState() => _ExhibitorMainState();
}

class _ExhibitorMainState extends State<ExhibitorMain> {
  int _currentIndex = 0;

  // Define your pages
  final List<Widget> _pages = [
    const ExhibitorHomePage(),
    const ExhibitorBookPage(),
    ExhibitorProfilePage(),
    
    // Add more pages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        title: const Text("Exhibitor Main Page"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: _pages[_currentIndex], // Display the selected page

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black ,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          // Add more items as needed
        ],
      ),
    );
  }
}


class ExhibitorHomePage extends StatelessWidget {
  const ExhibitorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Exhibitor Home Page'),
    );
  }
}

class ExhibitorBookPage extends StatelessWidget {
  const ExhibitorBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Bookings'),
    );
  }
}

class ExhibitorProfilePage extends StatelessWidget {
  final supabase = Supabase.instance.client;

  ExhibitorProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await supabase.auth.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, '/');
                },
                child: const Text("Logout")
              ),
            ],
          )
        ],
      ),
    );
  }
}
