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
  final exhibition_list =
      Supabase.instance.client.from('ex_manager').stream(primaryKey: ['id']).order('id');

  dynamic exhibitions;
  // bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                        Navigator.pushNamed(context, '/list_stall', arguments: {
                                          'exhibition_id': exhibitionList[index]['id'],
                                        });
                                      },
                                      child: const Icon(Icons.keyboard_arrow_right_outlined,
                                          size: 25, color: Colors.black),
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
