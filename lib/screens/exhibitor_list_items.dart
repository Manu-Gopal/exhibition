import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ExhibitorListitems extends StatefulWidget {
  const ExhibitorListitems({super.key});

  @override
  State<ExhibitorListitems> createState() => _ExhibitorListitemsState();
}

class _ExhibitorListitemsState extends State<ExhibitorListitems> {

  final supabase = Supabase.instance.client;

  final TextEditingController searchController = TextEditingController();

  dynamic stallId;
  dynamic itemLists;
  dynamic searchItem;
  
  // get index => null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () {
      stallId = ModalRoute.of(context)?.settings.arguments as Map?;
      getItems();
    });
  }

  // @override
  // void initState(){
  //   super.initState();
  //   Future.delayed(Duration.zero, () {
  //     stallId = ModalRoute.of(context)?.settings.arguments as Map?;
  //   },
  //   getItems();
  //   );
  // }

  // Future getItems() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   if (searchController.text.isEmpty){
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please enter a'),
  //         duration: Duration(seconds: 3),
  //       )
  //     );
  //     return;
  //   }
  //   else{
  //     searchItem = searchController.text;
  //     // labs = await supabase.from('labs').select().ilike('city', '%$city%');

  //   }
  // }

  Future getItems() async {
    itemLists = Supabase.instance.client
      .from('add_items')
      .stream(primaryKey: ['id']).eq('stall_id', stallId['stall_id']).order('id');
      setState(() {
        
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("List Items"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: getItems,
        child:
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: itemLists,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      final itemList = snapshot.data!;

                      return ListView.builder(
                          itemCount:itemList.length,
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
                                  itemList[index]['item_name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price : ${itemList[index]['item_price']}',
                                    ),
                                    Text(
                                      'Discount : ${itemList[index]['item_discount']}',
                                    ),
                                    Text(
                                      'Quantity : ${itemList[index]['item_quantity']}',
                                    ),
                                    IconButton(
                                      onPressed: () async{
                                        await supabase.from('add_items').delete().match({'id':itemList[index]['id']});
                                      },
                                      icon: const Icon(Icons.delete)
                                    )
                                  ],
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
                                        
                                //       },
                                //       child: const Text(
                                //         'Book Now',
                                //         style: TextStyle(
                                //           color: Colors.black,
                                //           fontSize: 16
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ),
                            );
                          }
                        );
                    }
                    return Container();
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context, '/add_items',
                    arguments: {'stall_id' :stallId['stall_id']}
                    );
                  },
                  child: const Text('Add Item')
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back')
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}