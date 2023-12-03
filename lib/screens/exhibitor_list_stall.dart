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
  void didChangeDependencies() {
    super.didChangeDependencies();
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
        backgroundColor: Colors.blueAccent,
        title: const Text("List Stall"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
          onRefresh: getStalls,
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
                            child: Text("No Stalls Yet",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      stallList[index]['stall_name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Type: ${stallList[index]['stall_type']}',
                                        ),
                                      ],
                                    ),
                                    trailing: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/list_items',
                                                  arguments: {
                                                    'stall_id': stallList[index]
                                                        ['id'],
                                                  },
                                                );
                                              },
                                              child: const Icon(
                                                Icons
                                                    .keyboard_arrow_right_outlined,
                                                size: 25,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                // Add your delete logic here
                                                // You might want to show a confirmation dialog before deleting
                                                // and then update your data accordingly.
                                                // Example:
                                                if (stallList[index]
                                                        ['exhibitor_id'] ==
                                                    exhibitorId) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Confirm Delete"),
                                                        content: const Text(
                                                            "Are you sure you want to delete?"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
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
                                                                      'ex_manager')
                                                                  .delete()
                                                                  .match({
                                                                'id': stallList[
                                                                    index]['id']
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
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'You are not authorised to delete the exhibition.'),
                                                      duration:
                                                          Duration(seconds: 3),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                size: 25,
                                                color: Colors
                                                    .red, // or any other color you prefer
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // trailing: Container(
                                    //   decoration: const BoxDecoration(
                                    //     color: Colors.grey,
                                    //     shape: BoxShape.rectangle,
                                    //     borderRadius:
                                    //         BorderRadius.all(Radius.circular(10)),
                                    //   ),
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(5.0),
                                    //     child: GestureDetector(
                                    //       onTap: () {
                                    //         Navigator.pushNamed(
                                    //           context, '/list_items',
                                    //           arguments: {
                                    //             'stall_id' :stallList[index]['id']
                                    //           }
                                    //         );
                                    //       },
                                    //       child: const Icon(
                                    //           Icons.keyboard_arrow_right_outlined,
                                    //           size: 25,
                                    //           color: Colors.black),
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                );
                              });
                        }
                        return Container();
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/add_stall', arguments: {
                          'exhibition_id': exhibitionId['exhibition_id']
                        });
                      },
                      child: const Text('Add Stall')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/exhibitor_main');
                      },
                      child: const Text('Back')),
                ],
              ),
            ),
          )),
    );
  }
}

// Navigator.pushNamed(context, '/add_stall',arguments: {'exhibition_id' :exhibitionList[index]['id']
