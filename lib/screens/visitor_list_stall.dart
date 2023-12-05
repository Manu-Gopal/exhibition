import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VisitorListStall extends StatefulWidget {
  const VisitorListStall({super.key});

  @override
  State<VisitorListStall> createState() => _VisitorListStallState();
}

class _VisitorListStallState extends State<VisitorListStall> {
  // ignore: non_constant_identifier_names
  final supabase = Supabase.instance.client;

  dynamic exhibitionId;

  dynamic stallList;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      exhibitionId = ModalRoute.of(context)?.settings.arguments as Map?;
      getStalls();
    });
  }

  Future getStalls() async {
    stallList = Supabase.instance.client
        .from('add_stall')
        .stream(primaryKey: ['id'])
        .eq('exhibition_id', exhibitionId['exhibition_id'])
        .order('id');
    // print(stallList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[400],
        title: const Text("Visitor List Stall"),
        centerTitle: true,
      ),
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
                const Text(
                  'Stalls',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NovaSquare',
                    color:
                        Colors.black, // Choose the color you want for the title
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: StreamBuilder(
                    stream: stallList,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        final stallList = snapshot.data!;
                        if (stallList.isEmpty) {
                          return const Center(
                            child: Text(
                              "No Stalls Yet",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'NovaSquare',
                                  fontSize: 20),
                            ),
                          );
                        }
                        return ListView.builder(
                            itemCount: stallList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(8.0),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          stallList[index]['stall_name'],
                                          style: const TextStyle(
                                            fontFamily: 'RobotoSlab',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/visitor_list_items',
                                                  arguments: {
                                                    'stall_id': stallList[index]
                                                        ['id'],
                                                    'exhibition_id': exhibitionId
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
                                        const Icon(Icons.category),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            '${stallList[index]['stall_type']}',
                                            style: const TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    )
      
                                    // ListTile(
                                    //   title: Text(
                                    //     stallList[index]['stall_name'],
                                    //     style: const TextStyle(
                                    //         fontWeight: FontWeight.bold),
                                    //   ),
                                    //   subtitle: Column(
                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                    //     children: [
                                    //       Text(
                                    //         'Type: ${stallList[index]['stall_type']}',
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   trailing: Container(
                                    //     decoration: const BoxDecoration(
                                    //       color: Colors.grey,
                                    //       shape: BoxShape.rectangle,
                                    //       borderRadius:
                                    //           BorderRadius.all(Radius.circular(10)),
                                    //     ),
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(5.0),
                                    //       child: GestureDetector(
                                    //         onTap: () {
                                    //           Navigator.pushNamed(
                                    //               context, '/visitor_list_items',
                                    //               arguments: {
                                    //                 'stall_id': stallList[index]['id'],
                                    //                 'exhibition_id' : exhibitionId
                                    //               });
                                    //         },
                                    //         child: const Icon(
                                    //             Icons.keyboard_arrow_right_outlined,
                                    //             size: 25,
                                    //             color: Colors.black),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              );
                            });
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
