// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class ExhibitorMain extends StatefulWidget {
//   const ExhibitorMain({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _ExhibitorMainState createState() => _ExhibitorMainState();
// }

// class _ExhibitorMainState extends State<ExhibitorMain> {
//   // ignore: non_constant_identifier_names
//   // final exhibition_list = Supabase.instance.client.from('ex_manager').stream(primaryKey: ['id']).order('id');
//   final supabase = Supabase.instance.client;

//   dynamic exhibitions;
//   int _currentIndex = 0;
//   // bool isLoading=false;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   getExhibitions();
//   // }

//   // Future getExhibitions() async{
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //   exhibitions=await supabase.from('ex_manager').select();

//   //   setState(() {
//   //     isLoading = false;
//   //   });
//   // }

//   // Define your pages
//   final List<Widget> _pages = [
//     const ExhibitorHomePage(),
//     const ExhibitorBookPage(),
//     ExhibitorProfilePage(),
    
//     // Add more pages as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.blueAccent,
//         title: const Text("Exhibitor Main Page"),
//         centerTitle: true,
//       ),
//       backgroundColor: Colors.white,
//       body: _pages[_currentIndex], // Display the selected page

//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.black ,
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.event),
//             label: 'Bookings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//           // Add more items as needed
//         ],
//       ),
//     );
//   }
// }


// class ExhibitorHomePage extends StatelessWidget {
//   const ExhibitorHomePage({super.key});

//   // ignore: non_constant_identifier_names
//   // final exhibition_list = Supabase.instance.client.from('ex_manager').stream(primaryKey: ['id']).order('id');
//   // final supabase = Supabase.instance.client;


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   hintText: "Search an Exhibition",
//                   prefixIcon: const Icon(Icons.search),
//                 ),
//               ),
//               // Expanded(
//               //   child: StreamBuilder(
//               //     stream: exhibition_list,
//               //     builder: (context, AsyncSnapshot snapshot){
//               //       if(snapshot.hasData){
//               //         final exhibitionList = snapshot.data!;
//               //         return ListView.builder(
//               //           itemCount: exhibitionList.length,
//               //           itemBuilder: (context, index){
//               //             return ListTile(
//               //               title: Text(
//               //                 exhibitionList[index]['exhibition_name'],
//               //                 style: const TextStyle(fontWeight: FontWeight.bold),
//               //               ),
//               //               subtitle: Column(
//               //                 crossAxisAlignment: CrossAxisAlignment.start,
//               //                 children: [
//               //                   Text(
//               //                     'Place: ${exhibitionList[index]['exhibition_place']}',
//               //                     // Add any additional styling if needed
//               //                   ),
//               //                   Text(
//               //                     'Organization: ${exhibitionList[index]['organization']}',
//               //                     // Add any additional styling if needed
//               //                   ),
//               //                   Text(
//               //                     'Start Date: ${exhibitionList[index]['start_date']}',
//               //                     // Add any additional styling if needed
//               //                   ),
//               //                   Text(
//               //                     'End Date: ${exhibitionList[index]['end_date']}',
//               //                     // Add any additional styling if needed
//               //                   ),
//               //                   IconButton(
//               //                     onPressed: () async{
//               //                       await supabase.from('ex_manager').delete().match({'id':exhibitionList[index]['id']});
//               //                     },
//               //                     icon: const Icon(Icons.delete)
//               //                     )
//               //                 ],
//               //               ),
//               //               trailing: Container(
//               //                 decoration: const BoxDecoration(
//               //                   color: Colors.grey,
//               //                   shape: BoxShape.rectangle,
//               //                   borderRadius: BorderRadius.all(Radius.circular(10))
//               //                 ),
//               //                 child: Padding(
//               //                   padding: const EdgeInsets.all(5.0),
//               //                   child: GestureDetector(
//               //                     onTap: (){},
//               //                     child: const Icon(Icons.keyboard_arrow_right_outlined, size: 25, color: Colors.black,),
//               //                   ),
//               //                 ),
//               //               ),
//               //             );
//               //           }
//               //           );
//               //       }
//               //       return Container();
//               //     }
//               //     )
//               //   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ExhibitorBookPage extends StatelessWidget {
//   const ExhibitorBookPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Bookings'),
//     );
//   }
// }

// class ExhibitorProfilePage extends StatelessWidget {
//   final supabase = Supabase.instance.client;

//   ExhibitorProfilePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   await supabase.auth.signOut();
//                   // ignore: use_build_context_synchronously
//                   Navigator.pushNamed(context, '/');
//                 },
//                 child: const Text("Logout")
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExhibitorMain extends StatefulWidget {
  const ExhibitorMain({super.key});

  @override
  State<ExhibitorMain> createState() => _ExhibitorMainState();
}

class _ExhibitorMainState extends State<ExhibitorMain> {
  final supabase = Supabase.instance.client;
  // ignore: non_constant_identifier_names
  final exhibition_list = Supabase.instance.client.from('ex_manager').stream(primaryKey: ['id']).order('id');

  dynamic exhibitions;
  // int _currentIndex = 0;
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    getExhibitions();
  }

  Future getExhibitions() async{
    setState(() {
      isLoading = true;
    });
  }

  // final List<Widget> _pages = [
  //   const ExhibitorHomePage(),
  //   const ExhibitorBookPage(),
  //   ExhibitorProfilePage(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        title: const Text("Exhibitor Main"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                await supabase.auth.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, '/');
     
              },
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
      // body: _pages[_currentIndex],

      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.black,
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home'
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.event_note_rounded),
      //       label: 'Bookings'
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile'
      //     )
      //   ]
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextField(
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     hintText: "Search an Exhibition",
              //     prefixIcon: const Icon(Icons.search),
              //   ),
              // ),

              // Expanded(
              //   child: ListView.builder(
              //     itemBuilder: (context, index){
              //       return Container(
              //         margin: const EdgeInsets.fromLTRB(10, 8, 10, 5),
              //         decoration: const BoxDecoration(
              //           color: Colors.white,
              //           border: Border(
              //             top: BorderSide(
              //               color: Colors.red,
              //               width: 1.0,
              //             )
              //           )
              //         ),
              //         child: const ListTile(
              //           contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              //           title: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: [
              //                   Icon(Icons.art_track),
              //                   // Text(exhibitions[index]['exhibition_name']);
              //                 ],
              //               )
                            
              //             ],
              //           ),
              //         ),
              //       );
              //     }
              //     )
              // ),

              Expanded(
                child: StreamBuilder(
                  stream: exhibition_list,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      final exhibitionList = snapshot.data!;
                      return ListView.builder(
                        itemCount: exhibitionList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(8.0), // Adjust the margin as needed
                            padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: ListTile(
                              title: Text(
                                exhibitionList[index]['exhibition_name'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Place: ${exhibitionList[index]['exhibition_place']}'),
                                  Text('Organization: ${exhibitionList[index]['organization']}'),
                                  Text('Start Date: ${exhibitionList[index]['start_date']}'),
                                  Text('End Date: ${exhibitionList[index]['end_date']}'),
                                ],
                              ),
                              trailing: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      
                                    },
                                    child: const Icon(Icons.keyboard_arrow_right_outlined, size: 25, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


