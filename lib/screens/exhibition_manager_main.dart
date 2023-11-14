import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExhibitionManagerMain extends StatefulWidget {
  const ExhibitionManagerMain({super.key});

  @override
  State<ExhibitionManagerMain> createState() => _ExhibitionManagerMainState();
}

class _ExhibitionManagerMainState extends State<ExhibitionManagerMain> {

  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        title: const Text("Exhibition Manager Main"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                await supabase.auth.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, '/');
                // Add your logout logic here
                
              },
              child: const Text('Logout'),
            ),
          ),
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Search an Exhibition",
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 20), // Add some space between the TextField and the button
              ElevatedButton(
                onPressed: () {
                  // Add your "Add Exhibition" button click logic here
                  Navigator.pushNamed(context, '/add_exhibition');
                },
                child: const Text('Add Exhibition'),
              ),
            ],
          ),
        ),
      ),
          
          
        
      
      // body: Center(
      //   child: ElevatedButton(
      //       onPressed: () async {             
      //       await supabase.auth.signOut();
      //       // ignore: use_build_context_synchronously
      //       Navigator.pushNamed(context, '/');
      //     }, child: const Text('sign out')
      //   )
      // )
    );
  }
}