import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddStall extends StatefulWidget {
  const AddStall({super.key});

  @override
  State<AddStall> createState() => AddStallState();
}  

class AddStallState extends State<AddStall> {
  final TextEditingController stallnameController = TextEditingController();
  final TextEditingController stalltypeController = TextEditingController();

  dynamic exhibitionId;
  dynamic exhibitorId = Supabase.instance.client.auth.currentUser!.id;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      exhibitionId = ModalRoute.of(context)?.settings.arguments as Map?;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(255, 3, 144, 163),
                    Color.fromARGB(255, 3, 201, 227),
                    Color.fromARGB(255, 2, 155, 175)
                  ]
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 130),
                const Text(
                  'Add a Stall', // Heading text
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'NovaSquare',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 78, 66, 66),
                  ),
                ),
                const SizedBox(height: 50,),
                Container(
                  height: 300, // Set the desired height for the container
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color for the container
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: stallnameController,
                        decoration: const InputDecoration(
                            hintText: 'Stall Name',
                            labelText: 'Stall Name',
                            prefixIcon: Icon(Icons.store,
                            color: Color.fromARGB(255, 78, 66, 66),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                            )
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: stalltypeController,
                        decoration: const InputDecoration(
                            hintText: 'Stall type',
                            labelText: 'Stall type',
                            prefixIcon: Icon(
                              Icons.category,
                              color: Color.fromARGB(255, 78, 66, 66),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                            )
                        ),
                      ),                   
                      const SizedBox(height: 30,),
                                  ElevatedButton(
                    onPressed: () async {
                      final supabase = Supabase.instance.client;
                      String stallName = stallnameController.text;
                      String stallType = stalltypeController.text;

                      if (stallName.isEmpty || stallType.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all details.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        return;
                      } else {
                        final Map<String, dynamic> userDetails = {
                          'stall_name': stallName,
                          'stall_type': stallType,
                          'exhibition_id': exhibitionId['exhibition_id'],
                          'exhibitor_id' : exhibitorId
                        };

                        await supabase.from('add_stall').insert(userDetails);

                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Stall added Successfully.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 99, 172, 172),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 85,
                        vertical: 17
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                    ],
                  ),
                ),
                const SizedBox(height: 200,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

