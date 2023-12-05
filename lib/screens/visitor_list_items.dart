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
  dynamic exId;
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

    exId = stallId['exhibition_id'];
      setState(() {
        
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[400],
        title: const Text("List Item"),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient:LinearGradient(
          colors: [Color(0xffe7fdf8), Color(0xff80ebf9)],
          stops: [0.25, 0.75],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      
      ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
      
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                        if(searchController.text.isNotEmpty){
                        Navigator.pushNamed(context,'/visitor_search_item', arguments: {
                          'exhibition_id' : exId,
                          'stallId': stallId['stall_id'], 'searchText': searchController.text
                        });
                      }
                    },
                    child: const Icon(Icons.search),
                  )
                  )
                ),
                const SizedBox(height: 30,),
      
                const Text(
                    'Items',
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
                    stream: itemLists,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        final itemList = snapshot.data!;
                        if (itemList.isEmpty) {
                            return const Center(
                              child: Text("No Items Yet",
                                style: TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                ),
                              ),
                            );
                          }
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
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // const Icon(Icons.store),
                                        Text(
                                          itemList[index]['item_name'],
                                          style: const TextStyle(
                                            fontFamily: 'RobotoSlab',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context, '/book_items', arguments: {
                                                  'item_id' : itemList[index]['id'],
                                                  'stall_id' : itemList[index]['stall_id'],
                                                  'exhibition_id' : exId,
                                                  // 'stall_id': stallList[index]['id']
                                                });
                                            },
                                            child: const Text(
                                              'Book Now',
                                              style: TextStyle(
                                                fontFamily: 'RobotoSlab',
                                                color: Colors.black,
                                                fontSize: 16
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        // const Icon(Icons.attach_money),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Price : ${itemList[index]['item_price']}',
                                            style: const TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5,),
                                    // Row(
                                    //   children: [
                                    //     const Icon(Icons.percent),
                                    //     Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(left: 8.0),
                                    //       child: Text(
                                    //         '${itemList[index]['item_discount']}',
                                    //         style: const TextStyle(fontSize: 17),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 7,),
                                        const Icon(Icons.add_shopping_cart),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            '${itemList[index]['item_quantity']}',
                                            style: const TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    // ListTile(
                                    //   title: Text(
                                    //     itemList[index]['item_name'],
                                    //     style: const TextStyle(
                                    //         fontWeight: FontWeight.bold),
                                    //   ),
                                    //   subtitle: Column(
                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                    //     children: [
                                    //       Text(
                                    //         'Price : ${itemList[index]['item_price']}',
                                    //       ),
                                    //       Text(
                                    //         'Discount : ${itemList[index]['item_discount']}',
                                    //       ),
                                    //       Text(
                                    //         'Quantity : ${itemList[index]['item_quantity']}',
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   trailing: Container(
                                    //     decoration: const BoxDecoration(
                                    //       color: Colors.grey,
                                    //       shape: BoxShape.rectangle,
                                    //       borderRadius:
                                    //           BorderRadius.all(Radius.circular(10)),
                                    //     ),
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(5.0),
                                    //       child: GestureDetector(
                                    //         onTap: () {
                                    //           Navigator.pushNamed(
                                    //             context, '/book_items', arguments: {
                                    //               'item_id' : itemList[index]['id'],
                                    //               'stall_id' : itemList[index]['stall_id'],
                                    //               'exhibition_id' : exId,
                                    //               // 'stall_id': stallList[index]['id']
                                    //             });
                                    //         },
                                    //         child: const Text(
                                    //           'Book Now',
                                    //           style: TextStyle(
                                    //             color: Colors.black,
                                    //             fontSize: 16
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
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
      ),
    );
  }
}