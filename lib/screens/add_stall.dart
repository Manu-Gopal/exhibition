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
      backgroundColor: const Color.fromARGB(255, 246, 244, 244),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: stallnameController,
                    decoration: const InputDecoration(
                      hintText: 'Stall Name',
                      labelText: 'Stall Name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(9.0))),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    controller: stalltypeController,
                    decoration: const InputDecoration(
                      hintText: 'Stall Type',
                      labelText: 'Stall Type',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(9.0))),
                    ),
                  ),
                  const SizedBox(height: 40.0),
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
                          'exhibition_id': exhibitionId['exhibition_id']
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
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("back")
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

