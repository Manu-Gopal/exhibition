import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExhibitorListStall extends StatefulWidget {
  const ExhibitorListStall({super.key});

  @override
  State<ExhibitorListStall> createState() => _ExhibitorListStallState();
}

class _ExhibitorListStallState extends State<ExhibitorListStall> {
  // ignore: non_constant_identifier_names
  final supabase = Supabase.instance.client;

  dynamic exhibitorId = Supabase.instance.client.auth.currentUser!.id;

  dynamic exhibitionId;

  dynamic stallList;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      exhibitionId = ModalRoute.of(context)?.settings.arguments as Map?;
      await getStalls();
      setState(() {});
    });
  }

  Future getStalls() async {
    // print('Fetching stalls');
    stallList = Supabase.instance.client
        .from('add_stall')
        .stream(primaryKey: ['id'])
        .eq('exhibition_id', exhibitionId['exhibition_id'])
        .order('id');
    // print('stalls $stallList');
  }

  @override
  Widget build(BuildContext context) {
    // print('rendering');
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xffe7fdf8), Color(0xff80ebf9)],
            stops: [0.25, 0.75],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: RefreshIndicator(
            onRefresh: getStalls,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 85,),
                        Expanded(
                          child: Text('Stalls',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            // Colors.white
                          ),
                          )
                          ),
                          // IconButton(
                          //   onPressed: (){},
                          //   icon: Icon(Icons.keyboard_arrow_right_outlined)),
                          // IconButton(
                          //   onPressed: (){},
                          //   icon: Icon(Icons.delete))
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Expanded(
                      child: StreamBuilder(
                        stream:  stallList,
                        builder: (context, AsyncSnapshot snapshot)
                        {
                        if (snapshot.hasData){
                          final stallList = snapshot.data!;
                          if(stallList.isEmpty){
                            return const Center(
                                  child: Text(
                                    "No Stalls Yet",
                                    style: TextStyle(
                                      fontFamily: 'RobotoSlab',
                                        fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                );
                          }
                          return ListView.builder(
                            itemCount: stallList.length,
                            itemBuilder: (context, index){
                              return Card(
                                elevation: 9,
                                shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                stallList[index]['stall_name'],
                                                style: const TextStyle(
                                                  fontFamily: 'RobotoSlab',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20
                                                    ),
                                              ),
                                              Padding(padding: const EdgeInsets.only(right: 8),
                                              child: IconButton(
                                                onPressed: (){
                                                  Navigator.pushNamed(
                                                            context,
                                                            '/list_items',
                                                            arguments: {
                                                              'stall_id':
                                                                  stallList[index]
                                                                      ['id'],
                                                            },
                                                          );
                                                },
                                                 icon: const Icon(Icons.keyboard_arrow_right_outlined)
                                                 ),
                                                
                                              )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // const Icon(Icons.),
                                                Text(
                                                        'Type: ${stallList[index]['stall_type']}',
                                                        style: const TextStyle(
                                                          fontSize: 17
                                                        ),
                                                      ),
                                                      Padding(padding: const EdgeInsets.only(right: 8),
                                              child: IconButton(
                                                onPressed: (){
                                                  if (stallList[index][
                                                                  'exhibitor_id'] ==
                                                              exhibitorId) {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      "Confirm Delete"),
                                                                  content: const Text(
                                                                      "Are you sure you want to delete?"),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(
                                                                                context)
                                                                            .pop();
                                                                      },
                                                                      child: const Text(
                                                                          "Cancel"),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        await supabase
                                                                            .from(
                                                                                'add_stall')
                                                                            .delete()
                                                                            .match({
                                                                          'id': stallList[index]
                                                                              [
                                                                              'id']
                                                                        });
                                                                        // ignore: use_build_context_synchronously
                                                                        Navigator.pop(
                                                                            context); // Close the dialog
                                                                      },
                                                                      child: const Text(
                                                                          "Delete"),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          } else {
                                                            // ignore: use_build_context_synchronously
                                                            ScaffoldMessenger.of(
                                                                    context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                    'You are not authorised to delete the stall.'),
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            3),
                                                              ),
                                                            );
                                                          }
                                                },
                                                 icon: const Icon(Icons.delete)
                                                 ),
                                                      )
                                                    
                                                    
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                              );
                            }
                          );
                        }
                        return  Container();
                      },
                      
                      )
                    ),
                    const SizedBox(height: 18,),
                    ElevatedButton(
                    onPressed: () {
                      
                      Navigator.pushNamed(
                                      context, '/add_stall', arguments: {
                                    'exhibition_id': exhibitionId['exhibition_id']
                                  });
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
                          horizontal: 24), // Adjust the padding for size
                    ),
                    child: const Text(
                      'Add Stall',
                      style: TextStyle(
                        color: Colors.white, // Set the text color
                        fontSize: 16,
                        fontFamily: 'NovaSquare',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          
                  ],
                ),
                ),
            ),
          ),

          // child: Column(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Align(
          //         alignment: Alignment.topLeft,
          //         child: IconButton(
          //           icon: const Icon(
          //             Icons.arrow_back,
          //             size: 20,
          //             color: Colors.black,
          //           ),
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //         ),
          //       ),
          //     ),
          //     RefreshIndicator(
          //         onRefresh: getStalls,
          //         child: Center(
          //           child: Padding(
          //             padding: const EdgeInsets.all(16),
          //             child: Column(
          //               // mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 const Text(
          //                   'Stalls',
          //                   style: TextStyle(
          //                     fontSize: 24,
          //                     fontWeight: FontWeight.bold,
          //                     fontFamily: 'NovaSquare',
          //                     color: Colors
          //                         .black, // Choose the color you want for the title
          //                   ),
          //                 ),
          //                 const SizedBox(height: 25),
          //                 SizedBox(
          //                   child: StreamBuilder(
          //                     stream: stallList,
          //                     builder: (context, AsyncSnapshot snapshot) {
          //                       if (snapshot.hasData) {
          //                         final stallList = snapshot.data!;
          //                         if (stallList.isEmpty) {
          //                           return const Center(
          //                             child: Text(
          //                               "No Stalls Yet",
          //                               style: TextStyle(
          //                                   fontWeight: FontWeight.bold,
          //                                   fontFamily: 'NovaSquare',
          //                                   fontSize: 25),
          //                             ),
          //                           );
          //                         }
          //                         return ListView.builder(
          //                             shrinkWrap: true,
          //                             itemCount: stallList.length,
          //                             itemBuilder: (context, index) {
          //                               return Container(
          //                                 margin: const EdgeInsets.all(8.0),
          //                                 padding: const EdgeInsets.all(8.0),
          //                                 decoration: BoxDecoration(
          //                                   border:
          //                                       Border.all(color: Colors.grey),
          //                                   borderRadius:
          //                                       const BorderRadius.all(
          //                                           Radius.circular(10)),
          //                                 ),
          //                                 child: ListTile(
          //                                   title: Text(
          //                                     stallList[index]['stall_name'],
          //                                     style: const TextStyle(
          //                                         fontWeight: FontWeight.bold),
          //                                   ),
          //                                   subtitle: Column(
          //                                     crossAxisAlignment:
          //                                         CrossAxisAlignment.start,
          //                                     children: [
          //                                       Text(
          //                                         'Type: ${stallList[index]['stall_type']}',
          //                                       ),
          //                                     ],
          //                                   ),
          //                                   trailing: Container(
          //                                     decoration: const BoxDecoration(
          //                                       // color: Colors.grey,
          //                                       shape: BoxShape.rectangle,
          //                                       borderRadius: BorderRadius.all(
          //                                           Radius.circular(10)),
          //                                     ),
          //                                     child: Row(
          //                                       mainAxisSize: MainAxisSize.min,
          //                                       children: [
          //                                         Padding(
          //                                           padding:
          //                                               const EdgeInsets.all(
          //                                                   5.0),
          //                                           child: GestureDetector(
          //                                             onTap: () {
          //                                               Navigator.pushNamed(
          //                                                 context,
          //                                                 '/list_items',
          //                                                 arguments: {
          //                                                   'stall_id':
          //                                                       stallList[index]
          //                                                           ['id'],
          //                                                 },
          //                                               );
          //                                             },
          //                                             child: const Icon(
          //                                               Icons
          //                                                   .keyboard_arrow_right_outlined,
          //                                               size: 25,
          //                                               color: Colors.black,
          //                                             ),
          //                                           ),
          //                                         ),
          //                                         const SizedBox(
          //                                           width: 10,
          //                                         ),
          //                                         Padding(
          //                                           padding:
          //                                               const EdgeInsets.all(
          //                                                   5.0),
          //                                           child: GestureDetector(
          //                                             onTap: () {
          //                                               // Add your delete logic here
          //                                               // You might want to show a confirmation dialog before deleting
          //                                               // and then update your data accordingly.
          //                                               // Example:
          //                                               if (stallList[index][
          //                                                       'exhibitor_id'] ==
          //                                                   exhibitorId) {
          //                                                 showDialog(
          //                                                   context: context,
          //                                                   builder:
          //                                                       (BuildContext
          //                                                           context) {
          //                                                     return AlertDialog(
          //                                                       title: const Text(
          //                                                           "Confirm Delete"),
          //                                                       content: const Text(
          //                                                           "Are you sure you want to delete?"),
          //                                                       actions: [
          //                                                         TextButton(
          //                                                           onPressed:
          //                                                               () {
          //                                                             Navigator.of(
          //                                                                     context)
          //                                                                 .pop();
          //                                                           },
          //                                                           child: const Text(
          //                                                               "Cancel"),
          //                                                         ),
          //                                                         TextButton(
          //                                                           onPressed:
          //                                                               () async {
          //                                                             await supabase
          //                                                                 .from(
          //                                                                     'ex_manager')
          //                                                                 .delete()
          //                                                                 .match({
          //                                                               'id': stallList[index]
          //                                                                   [
          //                                                                   'id']
          //                                                             });
          //                                                             // ignore: use_build_context_synchronously
          //                                                             Navigator.pop(
          //                                                                 context); // Close the dialog
          //                                                           },
          //                                                           child: const Text(
          //                                                               "Delete"),
          //                                                         ),
          //                                                       ],
          //                                                     );
          //                                                   },
          //                                                 );
          //                                               } else {
          //                                                 // ignore: use_build_context_synchronously
          //                                                 ScaffoldMessenger.of(
          //                                                         context)
          //                                                     .showSnackBar(
          //                                                   const SnackBar(
          //                                                     content: Text(
          //                                                         'You are not authorised to delete the stall.'),
          //                                                     duration:
          //                                                         Duration(
          //                                                             seconds:
          //                                                                 3),
          //                                                   ),
          //                                                 );
          //                                               }
          //                                             },
          //                                             child: const Icon(
          //                                               Icons.delete,
          //                                               size: 25,
          //                                               color: Colors
          //                                                   .red, // or any other color you prefer
          //                                             ),
          //                                           ),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ),
          //                               );
          //                             });
          //                       }
          //                       return const Center(
          //                           child: CircularProgressIndicator());
          //                     },
          //                   ),
          //                 ),
          //                 ElevatedButton(
          //                     onPressed: () {
          //                       Navigator.pushNamed(
          //                           context, '/add_stall', arguments: {
          //                         'exhibition_id': exhibitionId['exhibition_id']
          //                       });
          //                     },
          //                     style: ElevatedButton.styleFrom(
          //                       backgroundColor:
          //                           const Color.fromARGB(255, 99, 172, 172),
          //                       padding: const EdgeInsets.symmetric(
          //                           horizontal: 65, vertical: 17),
          //                       shape: RoundedRectangleBorder(
          //                           borderRadius: BorderRadius.circular(20)),
          //                     ),
          //                     child: const Text(
          //                       'Add Stall',
          //                       style: TextStyle(
          //                         color: Colors.black,
          //                         fontSize: 23.0,
          //                         fontFamily: 'NovaSquare',
          //                         // fontFamily: 'RobotoSlab',
          //                       ),
          //                     )),
          //                 // const SizedBox(height: 200,)
          //               ],
          //             ),
          //           ),
          //         )),
          //   ],
          // ),
        ),
      );
  }
}
