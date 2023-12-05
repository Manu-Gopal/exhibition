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
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
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
                                    //             context, '/book_items',
                                    //             arguments: {
                                    //               'item_id' : itemList[index]['id'],
                                    //               'stall_id' : itemList[index]['stall_id'],
                                    //               'exhibition_id' : exId,
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
                          )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}