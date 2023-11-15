import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExhibitionManagerMain extends StatefulWidget {
  const ExhibitionManagerMain({super.key});

  @override
  State<ExhibitionManagerMain> createState() => _ExhibitionManagerMainState();
}

class _ExhibitionManagerMainState extends State<ExhibitionManagerMain> {

  // ignore: non_constant_identifier_names
  final exhibition_list = Supabase.instance.client.from('ex_manager').stream(primaryKey: ['id']).order('id');
  final supabase = Supabase.instance.client;

  dynamic exhibitions;
  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    getExhibitions();
  }

  Future getExhibitions() async{
    setState(() {
      isLoading = true;
    });
    exhibitions=await supabase.from('ex_manager').select();

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
                  builder: (context, AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                      final exhibitionList = snapshot.data!;
                      return ListView.builder(
                        itemCount: exhibitionList.length,
                        itemBuilder: (context, index){
                          return ListTile(
                            title: Text(
                              exhibitionList[index]['exhibition_name'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Place: ${exhibitionList[index]['exhibition_place']}',
                                  // Add any additional styling if needed
                                ),
                                Text(
                                  'Organization: ${exhibitionList[index]['organization']}',
                                  // Add any additional styling if needed
                                ),
                                Text(
                                  'Start Date: ${exhibitionList[index]['start_date']}',
                                  // Add any additional styling if needed
                                ),
                                Text(
                                  'End Date: ${exhibitionList[index]['end_date']}',
                                  // Add any additional styling if needed
                                ),
                                IconButton(
                                  onPressed: () async{
                                    await supabase.from('ex_manager').delete().match({'id':exhibitionList[index]['id']});
                                  },
                                  icon: const Icon(Icons.delete)
                                  )
                              ],
                            ),
                          );
                        }
                        );
                    }
                    return Container();
                  }
                  )
                ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add_exhibition');
                },
                child: const Text('Add Exhibition')
              ),
            ],
          ),
        ),
      ),
    );
  }
}