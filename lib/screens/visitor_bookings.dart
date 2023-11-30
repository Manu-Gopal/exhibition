import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VisitorBookings extends StatefulWidget {
  const VisitorBookings({super.key});

  @override
  State<VisitorBookings> createState() => _VisitorBookingsState();
}

class _VisitorBookingsState extends State<VisitorBookings> {

  final supabase = Supabase.instance.client;

  dynamic visitorBookList;
  dynamic items;
  int bookId = 0;

  @override
  void initState() {
    super.initState();
    getBookingDetails();
  }

  Future getBookingDetails() async{

    final visitorProfile = await supabase.from('profile').select('id').match({'user_id': supabase.auth.currentUser!.id});

    // items = await supabase.from('book_item').select().match({'user_id':visitorProfile[0]['id']});
    items = Supabase.instance.client
      .from('book_item')
      .stream(primaryKey: ['id'])
      .eq('user_id', visitorProfile[0]['id'])
      // .inFilter('stall_id', stallIds)
      .order('id');

    // List userIds = [];
    // for(dynamic item in items){
    //   userIds.add(item['id']);
    // }

      // visitorBookList = Supabase.instance.client
      // .from('book_item')
      // .stream(primaryKey: ['id'])
      // .inFilter('user_id', userIds)
      // .order('id');
      // print(visitorBookList);
      
    setState(() {
      // bookId = items['id'];
      // print(bookId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visitor Bookings"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: items,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData){
                      final itemList  = snapshot.data!;
                      return ListView.builder(
                        itemCount: itemList.length,
                        itemBuilder: (context, index){
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: ListTile(
                              title: Text(
                                // 'Item : ${bookList[index]['item_name']}',
                                itemList[index]['item_name'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // bookId = itemList[index]['id'],
                                  // Text('Exhibition name : ${itemList[index]['exhibition_name']}'),
                                  Text('Stall name : ${itemList[index]['stall_name']}'),
                                  Text('Quantity : ${itemList[index]['quantity']}'),
                                  Text('Delivery Date : ${itemList[index]['delivery_date']}'),
                                  Text(
                                    ' ${itemList[index]['approved'] == true ? 'Accepted' : itemList[index]['approved'] == false ? 'Rejected' : 'Pending'}',
                                    style: TextStyle(
                                      color: itemList[index]['approved'] == true
                                          ? Colors.green
                                          : itemList[index]['approved'] == false
                                              ? Colors.red
                                              : Colors.blue,
                                    ),
                                  )
                                  // Text('Status: ${itemList[index]['approved'] == true ? 'Accepted' : itemList[index]['approved'] == false ? 'Rejected' : 'Pending'}',

                                  // )
                                  // Text('Status : ${itemList[index]['quantity']}'),
                                ],
                              ),
                              trailing: Container(
                                
                                decoration: BoxDecoration(
                                  color: (itemList[index]["delivery_date"] != null)
                                     && (-DateTime.now().difference(
                                      DateTime.parse(itemList[index]["delivery_date"])
                                      ).inHours < 24)
                                  ? Colors.grey
                                  : Colors.red, // Change color to red
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // DateTime delivery_date = itemList[index]["delivery_date"];
                                     -DateTime.now().difference(DateTime.parse(itemList[index]["delivery_date"]))
                                      .inHours < 24
                                      ? null
                                      : showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Cancel Booking'),
                                                  content: const Text(
                                                      'Are you sure you want to cancel the booking'),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () async{
                                                        await supabase
                                                            .from('book_item')
                                                            .delete()
                                                            .match({
                                                          'id': itemList[index]['id']
                                                        });
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.pop(
                                                            context); // Close the dialog
                                                      },
                                                      child: const Text('Yes'),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context); // Close the dialog
                                                      },
                                                      child: const Text('No'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                      // Navigator.pushNamed(context, '/visitor_list_stall',arguments: {
                                      //   'exhibition_id' :exhibitionList[index]['id'] 
                                      // });
                                    },
                                    child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),

                              
                            ),
                          );
                        }
                      );
                    }
                    else{
                      return Container();
                    }
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