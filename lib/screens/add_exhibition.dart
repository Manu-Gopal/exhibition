import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddExhibition extends StatelessWidget {
  final TextEditingController exhibitionnameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController organisationController = TextEditingController();
  final TextEditingController startdateController = TextEditingController();
  final TextEditingController enddateController = TextEditingController();
  AddExhibition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 177, 167),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TextFormField(
                  controller: exhibitionnameController,
                  decoration: const InputDecoration(
                    hintText: 'Exhibition Name',
                    labelText: 'Exhibition Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(9.0))
                    )
                  ),
                ),

                const SizedBox(height: 40.0),
                TextFormField(
                  controller: placeController,
                  decoration: const InputDecoration(
                    hintText: 'Place',
                    labelText: 'Place',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(9.0))
                    )
                  ),
                ),

                const SizedBox(height: 40.0),
                TextFormField(
                  controller: organisationController,
                  decoration: const InputDecoration(
                    hintText: 'Organisation',
                    labelText: 'Organisation',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(9.0))
                    )
                  ),
                ),

                const SizedBox(height: 40.0),
                TextFormField(
                  controller: startdateController,
                  decoration: const InputDecoration(
                    hintText: 'Starting Date',
                    labelText: 'Starting Date',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(9.0))
                    )
                  ),
                ),

                const SizedBox(height: 40.0),
                TextFormField(
                  controller: enddateController,
                  decoration: const InputDecoration(
                    hintText: 'Ending Date',
                    labelText: 'Ending Date',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(9.0))
                    )
                  ),
                ),

                const SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () async {
                    final supabase = Supabase.instance.client;
                    String exhibitionName = exhibitionnameController.text;
                    String place = placeController.text;
                    String organisation = organisationController.text;
                    String startDate = startdateController.text;
                    String endDate = enddateController.text;

                    if (exhibitionName.isEmpty || place.isEmpty || organisation.isEmpty || startDate.isEmpty || endDate.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all details.'),
                          duration: Duration(seconds: 3),
                        )
                      );
                      return;
                    }
                    else{

                      final Map<String , dynamic> userDetails = {
                        'exhibition_name' : exhibitionName,
                        'exhibition_place' : place,
                        'organisation' : organisation,
                        'start_date' : startDate,
                        'end_date' : endDate,
                      };

                      await supabase.from('ex_manager').upsert([userDetails]);

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Account Created Successfully.'),
                          duration: Duration(seconds: 3),
                        )
                      );
                    }

                    // final response = await supabase
                    // await supabase
                    // .from('account')
                    // .upsert([
                    //   {'name': name, 'email': email, 'password': password, 'phone': phone}
                    //   ]);

                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, '/exhibition_manager_main');
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15
                    )
                  ),
                  child: const Text(
                    'Add Exhibition',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            )
            
          ),
          
        ),
        ),
      )
      
    );
  
  }
}