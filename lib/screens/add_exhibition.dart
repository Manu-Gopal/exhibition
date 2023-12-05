import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class AddExhibition extends StatefulWidget {
  const AddExhibition({super.key});

  @override
  State<AddExhibition> createState() => _AddExhibitionState();
}

class _AddExhibitionState extends State<AddExhibition> {
  dynamic exManagerId;
  final TextEditingController exhibitionnameController =
      TextEditingController();

  final TextEditingController placeController = TextEditingController();

  final TextEditingController organizationController = TextEditingController();

  final TextEditingController startdateController = TextEditingController();

  final TextEditingController enddateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      exManagerId = ModalRoute.of(context)?.settings.arguments as Map?;
    });
  }

  // stallId = ModalRoute.of(context)?.settings.arguments as Map?;
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
                const SizedBox(height: 50,),
                const Text(
                  'Add an Exhibition', // Heading text
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'NovaSquare',
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                    // color: Color.fromARGB(255, 78, 66, 66),
                  ),
                ),
                const SizedBox(height: 50,),
                Container(
                  height: 520, // Set the desired height for the container
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color for the container
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 13,),
                      TextFormField(
                        controller: exhibitionnameController,
                        decoration: const InputDecoration(
                            hintText: 'Exhibition Name',
                            labelText: 'Exhibition Name',
                            prefixIcon: Icon(
                              Icons.group,
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
                        controller: placeController,
                        decoration: const InputDecoration(
                            hintText: 'Place',
                            labelText: 'Place',
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: Color.fromARGB(255, 78, 66, 66),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                            )
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: organizationController,
                        decoration: const InputDecoration(
                            hintText: 'Organization',
                            labelText: 'Organization',
                            prefixIcon: Icon(
                              Icons.eco,
                              color: Color.fromARGB(255, 78, 66, 66),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                            )
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: startdateController,
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025));
                            if(picked != null){
                              startdateController.text =
                                DateFormat('yyyy-MM-dd').format(picked);
                            }
                            
                          },
                          decoration: const InputDecoration(
                            labelText: 'Starting Date',
                            hintText: 'yyyy-mm-dd',
                            prefixIcon: Icon(
                              Icons.calendar_month,
                              color: Color.fromARGB(255, 78, 66, 66),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: enddateController,
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025));
                            if(picked != null){
                              enddateController.text =
                                DateFormat('yyyy-MM-dd').format(picked);
                            }
                            
                          },
                          decoration: const InputDecoration(
                            labelText: 'Ending Date',
                            hintText: 'yyyy-mm-dd',
                            prefixIcon: Icon(
                              Icons.calendar_month,
                              color: Color.fromARGB(255, 78, 66, 66),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                ElevatedButton(
                        onPressed: () async {
                          final supabase = Supabase.instance.client;
                          String exhibitionName = exhibitionnameController.text;
                          String place = placeController.text;
                          String organization = organizationController.text;
                          String startDate = startdateController.text;
                          String endDate = enddateController.text;

                          if (exhibitionName.isEmpty ||
                              place.isEmpty ||
                              organization.isEmpty ||
                              startDate.isEmpty ||
                              endDate.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Please fill all details.'),
                              duration: Duration(seconds: 3),
                            ));
                            return;
                          } else {
                            if(-(DateTime.parse(startDate)).difference(DateTime.parse(endDate))
                            .inHours<0){
                              ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Please select appropriate dates.'),
                              duration: Duration(seconds: 3),
                            ));
                            return;
                            }
                            else{
                              final Map<String, dynamic> userDetails = {
                              'exhibition_name': exhibitionName,
                              'exhibition_place': place,
                              'organization': organization,
                              'start_date': startDate,
                              'end_date': endDate,
                              'exhibition_manager_id':
                                  exManagerId['exhibition_manager_id'],
                            };

                            await supabase
                                .from('ex_manager')
                                .upsert([userDetails]);

                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Exhibition addded Successfully.'),
                              duration: Duration(seconds: 3),
                            ));
                            }
                            
                             // ignore: use_build_context_synchronously
                            
                             
                          }

                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(
                              context, '/exhibition_manager_main');
                        },
                        style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 231, 162, 87),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust the value for circular edges
                    ),
                    
                    // primary: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 70), // Adjust the padding for size
                  ),
                        child: const Text(
                          'Add',
                          style: TextStyle(fontSize: 20.0,
                          fontFamily: 'NovaSquare',
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.pushNamed(
                      //           context, '/exhibition_manager_main');
                      //     },
                      //     child: const Text("back"))
                
                    ],
                  ),
                ),
                const SizedBox(height: 48,)
              ],
            ),
          ),
        ),
      ),
    );



    // return Scaffold(
    //     backgroundColor: Colors.cyan,
    //     body: Center(
    //       child: SingleChildScrollView(
    //         child: Center(
    //           child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   TextFormField(
    //                     controller: exhibitionnameController,
    //                     decoration: const InputDecoration(
    //                         hintText: 'Exhibition Name',
    //                         labelText: 'Exhibition Name',
    //                         border: OutlineInputBorder(
    //                             borderSide: BorderSide(color: Colors.red),
    //                             borderRadius:
    //                                 BorderRadius.all(Radius.circular(9.0)))),
    //                   ),

    //                   const SizedBox(height: 40.0),
    //                   TextFormField(
    //                     controller: placeController,
    //                     decoration: const InputDecoration(
    //                         hintText: 'Place',
    //                         labelText: 'Place',
    //                         border: OutlineInputBorder(
    //                             borderSide: BorderSide(color: Colors.red),
    //                             borderRadius:
    //                                 BorderRadius.all(Radius.circular(9.0)))),
    //                   ),

    //                   const SizedBox(height: 40.0),
    //                   TextFormField(
    //                     controller: organizationController,
    //                     decoration: const InputDecoration(
    //                         hintText: 'Organization',
    //                         labelText: 'Organization',
    //                         border: OutlineInputBorder(
    //                             borderSide: BorderSide(color: Colors.red),
    //                             borderRadius:
    //                                 BorderRadius.all(Radius.circular(9.0)))),
    //                   ),

    //                   const SizedBox(height: 40.0),
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: TextField(
    //                       controller: startdateController,
    //                       onTap: () async {
    //                         DateTime? picked = await showDatePicker(
    //                             context: context,
    //                             initialDate: DateTime.now(),
    //                             firstDate: DateTime.now(),
    //                             lastDate: DateTime(2025));

    //                         startdateController.text =
    //                             DateFormat('yyyy-MM-dd').format(picked!);
    //                       },
    //                       decoration: const InputDecoration(
    //                         labelText: 'Delivery Date',
    //                         hintText: 'yyyy-mm-dd',
    //                         border: OutlineInputBorder(),
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(height: 40.0),
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: TextField(
    //                       controller: enddateController,
    //                       onTap: () async {
    //                         DateTime? picked = await showDatePicker(
    //                             context: context,
    //                             initialDate: DateTime.now(),
    //                             firstDate: DateTime.now(),
    //                             lastDate: DateTime(2025));

    //                         enddateController.text =
    //                             DateFormat('yyyy-MM-dd').format(picked!);
    //                       },
    //                       decoration: const InputDecoration(
    //                         labelText: 'Delivery Date',
    //                         hintText: 'yyyy-mm-dd',
    //                         border: OutlineInputBorder(),
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(height: 40.0),
                      
    //                   ElevatedButton(
    //                       onPressed: () {
    //                         Navigator.pushNamed(
    //                             context, '/exhibition_manager_main');
    //                       },
    //                       child: const Text("back"))
    //                 ],
    //               )),
    //         ),
    //       ),
    //     ));
  }
}
