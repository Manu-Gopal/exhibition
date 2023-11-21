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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(8.0),
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
                                      Navigator.pushNamed(context, '/list_stall',arguments: {
                                        'exhibition_id' :exhibitionList[index]['id'] 
                                      });
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
