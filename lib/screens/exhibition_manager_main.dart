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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        title: const Text("Exhibition Manager Main"),
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

              Expanded(
                  child: StreamBuilder(
                      stream: exhibition_list,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          final exhibitionList = snapshot.data!;
                          return ListView.builder(
                              itemCount: exhibitionList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    exhibitionList[index]['exhibition_name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Place: ${exhibitionList[index]['exhibition_place']}',
                                      ),
                                      Text(
                                        'Organization: ${exhibitionList[index]['organization']}',
                                      ),
                                      Text(
                                        'Start Date: ${exhibitionList[index]['start_date']}',
                                      ),
                                      Text(
                                        'End Date: ${exhibitionList[index]['end_date']}',
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Delete Exhibition'),
                                                  content: Text(
                                                      'Are you sure you want to delete the exhibition ${exhibitionList[index]['exhibition_name']}'),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        await supabase
                                                            .from('ex_manager')
                                                            .delete()
                                                            .match({
                                                          'id': exhibitionList[
                                                              index]['id']
                                                        });
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.pop(
                                                            context); // Close the dialog
                                                      },
                                                      child: const Text('Yes'),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context); // Close the dialog
                                                      },
                                                      child: const Text('No'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(Icons.delete))
                                    ],
                                  ),
                                );
                              });
                        }
                        return Container();
                      })),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add_exhibition');
                  },
                  child: const Text('Add Exhibition')),
            ],
          ),
        ),
      ),
    );
  }
}
