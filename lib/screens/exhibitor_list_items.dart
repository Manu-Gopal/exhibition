import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExhibitorListitems extends StatefulWidget {
  const ExhibitorListitems({super.key});

  @override
  State<ExhibitorListitems> createState() => _ExhibitorListitemsState();
}

class _ExhibitorListitemsState extends State<ExhibitorListitems> {
  final supabase = Supabase.instance.client;

  dynamic exhibitorId = Supabase.instance.client.auth.currentUser!.id;

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
        .stream(primaryKey: ['id'])
        .eq('stall_id', stallId['stall_id'])
        .order('id');
    setState(() {});
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Items',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NovaSquare',
                      color: Colors
                          .black, // Choose the color you want for the title
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
                              child: Text(
                                "No items Yet",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            );
                          }
                          return ListView.builder(
                              itemCount: itemList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(8.0),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      itemList[index]['item_name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            onPressed: () async {
                                              if (itemList[index]
                                                      ['exhibitor_id'] ==
                                                  exhibitorId) {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Delete Items'),
                                                        content: const Text(
                                                            'Are you sure you want to delete the item..?'),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              await supabase
                                                                  .from(
                                                                      'add_items')
                                                                  .delete()
                                                                  .match({
                                                                'id': itemList[
                                                                    index]['id']
                                                              });
                                                              // ignore: use_build_context_synchronously
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Yes'),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context); // Close the dialog
                                                            },
                                                            child: const Text(
                                                                'No'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              } else {
                                                // ignore: use_build_context_synchronously
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'You are not authorised to delete the item.'),
                                                    duration:
                                                        Duration(seconds: 3),
                                                  ),
                                                );
                                              }
                                              // await supabase.from('add_items').delete().match({'id':itemList[index]['id']});
                                            },
                                            icon: const Icon(Icons.delete))
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        return Container();
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/add_items',
                            arguments: {'stall_id': stallId['stall_id']});
                      },
                      child: const Text('Add Item')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Back')),
                ],
              ),
            ),
          ),
        ));
  }
}
