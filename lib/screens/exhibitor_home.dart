import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExhibitorHome extends StatefulWidget {
  const ExhibitorHome({Key? key}) : super(key: key);

  @override
  State<ExhibitorHome> createState() => _ExhibitorHomeState();
}

class _ExhibitorHomeState extends State<ExhibitorHome> {
  final supabase = Supabase.instance.client;
  // ignore: non_constant_identifier_names
  final exhibition_list = Supabase.instance.client
      .from('ex_manager')
      .stream(primaryKey: ['id']).order('id');

  dynamic exhibitions;
  // bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient:LinearGradient(
          colors: [Color(0xffe7fdf8), Color(0xff80ebf9)],
          stops: [0.25, 0.75],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      
      ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  'Exhibitions',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color:
                        Colors.black, // Choose the color you want for the title
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: StreamBuilder(
                    stream: exhibition_list,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        final exhibitionList = snapshot.data!;
                        return ListView.builder(
                          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          //       crossAxisCount: 1, // Adjust the crossAxisCount as needed
                          //       crossAxisSpacing: 8.0, // Adjust the crossAxisSpacing as needed
                          //       mainAxisSpacing: 8.0, // Adjust the mainAxisSpacing as needed
                          //     ),
                          itemCount: exhibitionList.length,
                          itemBuilder: (context, index) {
                            return ClipRect(



                              child: Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Material(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 187, 186, 186)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              exhibitionList[index]
                                                  ['exhibition_name'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'RobotoSlab',
                                                fontSize: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: IconButton(
                                                onPressed: () {
                                                  // print('Navigating');
                                                  Navigator.pushNamed(context,
                                                      '/list_stall',
                                                      arguments: {
                                                        'exhibition_id':
                                                            exhibitionList[
                                                                index]['id'],
                                                      });
                                                },
                                                icon: const Icon(
                                                    Icons
                                                        .keyboard_arrow_right_outlined,
                                                    size: 35,
                                                    color: Colors.black),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            // const Icon(Icons.location_city),
                                            const Text(
                                              '@',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                '${exhibitionList[index]['exhibition_place']}',
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  // color: Colors.grey
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.eco),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                '${exhibitionList[index]['organization']}',
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.calendar_month),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                '${exhibitionList[index]['start_date']}',
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.remove,
                                              size: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Text(
                                                '${exhibitionList[index]['end_date']}',
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ],
                                        ),
                                      
                                      ],
                                    ),
                                  ),
                                ),
                              ),


                              // elevation: 9,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(8),
                              // ),
                              // color: Colors.white,
                              // child: Padding(
                              //   padding: const EdgeInsets.all(16.0),
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Text(
                              //             exhibitionList[index]
                              //                 ['exhibition_name'],
                              //             style: const TextStyle(
                              //               fontWeight: FontWeight.bold,
                              //               fontSize: 20,
                              //             ),
                              //           ),
                              //           const Padding(
                              //             padding: EdgeInsets.only(right: 8.0),
                              //           ),
                              //           IconButton(
                              //             onPressed: () {
                              //               Navigator.pushNamed(
                              //                 context,
                              //                 '/list_stall',
                              //                 arguments: {
                              //                   'exhibition_id':
                              //                       exhibitionList[index]['id'],
                              //                 },
                              //               );
                              //             },
                              //             icon: const Icon(
                              //               Icons.keyboard_arrow_right_outlined,
                              //               size: 35,
                              //               color: Colors.black,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       Row(
                              //         children: [
                              //           const Text(
                              //             '@',
                              //             style: TextStyle(
                              //               fontWeight: FontWeight.bold,
                              //               fontSize: 20,
                              //             ),
                              //           ),
                              //           Padding(
                              //             padding:
                              //                 const EdgeInsets.only(left: 8.0),
                              //             child: Text(
                              //               '${exhibitionList[index]['exhibition_place']}',
                              //               style: const TextStyle(
                              //                 fontSize: 17,
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       const SizedBox(height: 5),
                              //       Row(
                              //         children: [
                              //           const Icon(Icons.eco),
                              //           Padding(
                              //             padding:
                              //                 const EdgeInsets.only(left: 8.0),
                              //             child: Text(
                              //               '${exhibitionList[index]['organization']}',
                              //               style:
                              //                   const TextStyle(fontSize: 17),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       const SizedBox(height: 5),
                              //       Row(
                              //         children: [
                              //           const Icon(Icons.calendar_month),
                              //           Padding(
                              //             padding:
                              //                 const EdgeInsets.only(left: 8.0),
                              //             child: Text(
                              //               '${exhibitionList[index]['start_date']}',
                              //               style:
                              //                   const TextStyle(fontSize: 17),
                              //             ),
                              //           ),
                              //           const Icon(
                              //             Icons.remove,
                              //             size: 20,
                              //           ),
                              //           Padding(
                              //             padding:
                              //                 const EdgeInsets.only(left: 4.0),
                              //             child: Text(
                              //               '${exhibitionList[index]['end_date']}',
                              //               style:
                              //                   const TextStyle(fontSize: 17),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // margin: const EdgeInsets.all(8.0),
                              // padding: const EdgeInsets.all(8.0),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   border: Border.all(color: Colors.grey),
                              //   borderRadius:
                              //       const BorderRadius.all(Radius.circular(10)),
                              // ),
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
      ),
    );
  }
}
