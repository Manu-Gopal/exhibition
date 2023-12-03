import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 110),
          Center(
            child: Text('Login',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'NovaSquare',
              fontSize: 40
            ),),
          ),
          SizedBox(height: 10,),
          Center(
            child: Text("Welcome...!",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'NovaSquare',
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),),
          )
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class ExhibitionManagerMain extends StatefulWidget {
//   const ExhibitionManagerMain({super.key});

//   @override
//   State<ExhibitionManagerMain> createState() => _ExhibitionManagerMainState();
// }

// class _ExhibitionManagerMainState extends State<ExhibitionManagerMain> {
//   // ignore: non_constant_identifier_names
//   final exhibition_list = Supabase.instance.client
//       .from('ex_manager')
//       .stream(primaryKey: ['id']).order('id');
//   final supabase = Supabase.instance.client;
//   dynamic userId = Supabase.instance.client.auth.currentUser!.id;

//   dynamic exhibitions;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     getExhibitions();
//   }

//   Future getExhibitions() async {
//     setState(() {
//       isLoading = true;
//     });
//     exhibitions = await supabase.from('ex_manager').select();

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.blueAccent,
//         title: const Text("Exhibition Manager Main"),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               onPressed: () async {
//                 await supabase.auth.signOut();
//                 // ignore: use_build_context_synchronously
//                 Navigator.pushNamed(context, '/');
//               },
//               child: const Text('Logout'),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               colors: [
//                 Color.fromARGB(255, 3, 144, 163),
//                 Color.fromARGB(255, 3, 201, 227),
//                 Color.fromARGB(255, 2, 155, 175)
//               ]
//             )
//           ),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                       child: StreamBuilder(
//                           stream: exhibition_list,
//                           builder: (context, AsyncSnapshot snapshot) {
//                             if (snapshot.hasData) {
//                               final exhibitionList = snapshot.data!;
//                               return GridView.builder(
//                                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2, // Adjust the crossAxisCount as needed
//                                   crossAxisSpacing: 8.0, // Adjust the crossAxisSpacing as needed
//                                   mainAxisSpacing: 8.0, // Adjust the mainAxisSpacing as needed
//                                 ),
//                                   itemCount: exhibitionList.length,
//                                   itemBuilder: (context, index) {
//                                     return Card(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                       Text(
//                                         exhibitionList[index]['exhibition_name'],
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                           Text(
//                                             'Place: ${exhibitionList[index]['exhibition_place']}',
//                                           ),
//                                           Text(
//                                             'Organization: ${exhibitionList[index]['organization']}',
//                                           ),
//                                           Text(
//                                             'Start Date: ${exhibitionList[index]['start_date']}',
//                                           ),
//                                           Text(
//                                             'End Date: ${exhibitionList[index]['end_date']}',
//                                           ),
                                          
//                                           IconButton(
//                                               onPressed: () async {
//                                                 if (exhibitionList[index]
//                                                         ['exhibition_manager_id'] ==
//                                                     userId) {
//                                                   showDialog(
//                                                     context: context,
//                                                     builder:
//                                                         (BuildContext context) {
//                                                       return AlertDialog(
//                                                         title: const Text(
//                                                             'Delete Exhibition'),
//                                                         content: Text(
//                                                             'Are you sure you want to delete the exhibition ${exhibitionList[index]['exhibition_name']}'),
//                                                         actions: [
//                                                           ElevatedButton(
//                                                             onPressed: () async {
//                                                               await supabase
//                                                                   .from(
//                                                                       'ex_manager')
//                                                                   .delete()
//                                                                   .match({
//                                                                 'id':
//                                                                     exhibitionList[
//                                                                         index]['id']
//                                                               });
//                                                               // ignore: use_build_context_synchronously
//                                                               Navigator.pop(
//                                                                   context); // Close the dialog
//                                                             },
//                                                             child:
//                                                                 const Text('Yes'),
//                                                           ),
//                                                           ElevatedButton(
//                                                             onPressed: () {
//                                                               Navigator.pop(
//                                                                   context); // Close the dialog
//                                                             },
//                                                             child: const Text('No'),
//                                                           ),
//                                                         ],
//                                                       );
//                                                     },
//                                                   );
//                                                 }
//                                                 else{
//                                                   // ignore: use_build_context_synchronously
//                                                   ScaffoldMessenger.of(context).showSnackBar(
//                                                     const SnackBar(
//                                                       content: Text('You are not authorised to delete the exhibition.'),
//                                                       duration: Duration(seconds: 3),
//                                                     ),
//                                                   );
//                                                 }
//                                               },
//                                               icon: const Icon(Icons.delete))
                                        
                                      
//                                         ]
//                                     ),
//                                     );
//                                   });
//                             }
//                             return Container();
//                           })),
//                   ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/add_exhibition',
//                             arguments: {'exhibition_manager_id': userId});
//                       },
//                       child: const Text('Add Exhibition')),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
