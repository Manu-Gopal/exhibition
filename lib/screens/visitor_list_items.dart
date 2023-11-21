import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class VisitorListitems extends StatefulWidget {
  const VisitorListitems({super.key});

  @override
  State<VisitorListitems> createState() => _AddItemsState();
}

class _AddItemsState extends State<VisitorListitems> {

  final supabase = Supabase.instance.client;

  final TextEditingController searchController = TextEditingController();

  dynamic stallId;
  bool isLoading = false;
  dynamic itemLists;
  dynamic searchItem;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () {
      stallId = ModalRoute.of(context)?.settings.arguments as Map?;
      getItems();
    });
  }

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
        title: const Text("List Item"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: (){
              //     Navigator.pushNamed(
              //       context, '/visitor_search_item',
              //       arguments: {
              //         'stall_id' :itemLists[0]['id']
              //       }
              //     );
              //   }, 
              // child: const Text("Search Item"),
              // ),

              TextField(
                controller: searchController,
                decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                      if(searchController.text.isNotEmpty){
                      Navigator.pushNamed(context,'/visitor_search_item', arguments: {
                        'stallId': stallId['stall_id'], 'searchText': searchController.text
                      });
                    }
                  },
                  child: const Icon(Icons.search),
                )
                )
              ),
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
                                          context, '/book_items', arguments: {
                                            'item_id' : itemList[index]['id']
                                            // 'stall_id': stallList[index]['id']
                                          });
                                      },
                                      child: const Text(
                                        'Book Now',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
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