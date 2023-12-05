import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExhibitionManagerMain extends StatefulWidget {
  const ExhibitionManagerMain({super.key});

  @override
  State<ExhibitionManagerMain> createState() => _ExhibitionManagerMainState();
}

class _ExhibitionManagerMainState extends State<ExhibitionManagerMain> {
  // ignore: non_constant_identifier_names
  final exhibition_list = Supabase.instance.client
      .from('ex_manager')
      .stream(primaryKey: ['id']).order('id');
  final supabase = Supabase.instance.client;
  dynamic userId = Supabase.instance.client.auth.currentUser!.id;

  dynamic exhibitions;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getExhibitions();
  }

  Future getExhibitions() async {
    setState(() {
      isLoading = true;
    });
    exhibitions = await supabase.from('ex_manager').select();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xffe7fdf8), Color(0xff80ebf9)],
            stops: [0.25, 0.75],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 85,),
                    const Expanded(
                      child: Text(
                        'Exhibitions',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NovaSquare',
                          color: Colors.black,
                          // Colors.white
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons
                          .logout), // Replace with the icon you want for logout
                      onPressed: () async {
                        await supabase.auth.signOut();
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                Expanded(
                    child: StreamBuilder(
                        stream: exhibition_list,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            final exhibitionList = snapshot.data!;
                            return ListView.builder(
                                itemCount: exhibitionList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 9,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween, // Align items to both ends of the row
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
                                                    right:
                                                        8.0), // Adjust the right padding as needed
                                                child: IconButton(
                                                  onPressed: () async {
                                                    if (exhibitionList[index][
                                                            'exhibition_manager_id'] ==
                                                        userId) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Delete Exhibition'),
                                                            content: Text(
                                                              'Are you sure you want to delete the exhibition ${exhibitionList[index]['exhibition_name']}',
                                                            ),
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await supabase
                                                                      .from(
                                                                          'ex_manager')
                                                                      .delete()
                                                                      .match({
                                                                    'id': exhibitionList[
                                                                            index]
                                                                        ['id'],
                                                                  });
                                                                  // ignore: use_build_context_synchronously
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'Yes'),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'No'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'You are not authorized to delete the exhibition.'),
                                                          duration: Duration(
                                                              seconds: 3),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                ),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              // const Icon(Icons.location_city),
                                              const Text('@',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20
                                              ),
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
                                          const SizedBox(height: 5,),
                                          Row(
                                            children: [
                                              const Icon(Icons.eco),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  '${exhibitionList[index]['organization']}',
                                                  style:
                                                      const TextStyle(fontSize: 17),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5,),
                                          Row(
                                            children: [
                                              const Icon(Icons.calendar_month),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  '${exhibitionList[index]['start_date']}',
                                                  style:
                                                      const TextStyle(fontSize: 17),
                                                ),
                                              ),
                                              const Icon(Icons.remove,
                                              size: 20,
                                              ),
                                              Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text(
                                              '${exhibitionList[index]['end_date']}',
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                          ),
                                            ],
                                          ),
                                          
                                          // Use Align to position the IconButton to the top right
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                          return Container();
                        })),
                const SizedBox(
                  height: 18,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add_exhibition',
                        arguments: {'exhibition_manager_id': userId});
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
                    'Add Exhibition',
                    style: TextStyle(
                      color: Colors.white, // Set the text color
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // const SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
