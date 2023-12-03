import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VisitorSearchItem extends StatefulWidget {
  const VisitorSearchItem({super.key});

  @override
  State<VisitorSearchItem> createState() => _VisitorSearchItemState();
}

class _VisitorSearchItemState extends State<VisitorSearchItem> {

  final supabase = Supabase.instance.client;
  final TextEditingController searchController = TextEditingController();
  dynamic stallDetails;
  bool isLoading = false;
  dynamic itemLists;
  dynamic searchItem;
  dynamic exId;
  // ignore: non_constant_identifier_names
  List itemList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () {
      stallDetails = ModalRoute.of(context)?.settings.arguments as Map?;
      getItems();
    });
  }

  Future getItems() async {
    exId = stallDetails['exhibition_id'];
    setState(() {
      isLoading = true;
    });

    itemList = await supabase.from('add_items').select().ilike('item_name', '%${stallDetails["searchText"]}%')
    .match({'stall_id': stallDetails['stallId']});

    setState(() {
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Search Items"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Expanded(
                child: isLoading?const Text('') : itemList.isEmpty?const Text('No items'):ListView.builder(
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
                                          context, '/book_items',
                                          arguments: {
                                            'item_id' : itemList[index]['id'],
                                            'stall_id' : itemList[index]['stall_id'],
                                            'exhibition_id' : exId,
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
                        )
              )
            ],
          ),
        ),
      ),
    );
  }
}