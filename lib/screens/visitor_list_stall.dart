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
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Visitor List Stall"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: stallList,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      final stallList = snapshot.data!;

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
                              child: ListTile(
                                title: Text(
                                  stallList[index]['stall_name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/visitor_list_items',
                                            arguments: {
                                              'stall_id': stallList[index]['id'],
                                              'exhibition_id' : exhibitionId
                                            });
                                      },
                                      child: const Icon(
                                          Icons.keyboard_arrow_right_outlined,
                                          size: 25,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
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
    );
  }
}
