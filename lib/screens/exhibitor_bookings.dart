import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class ExhibitorBookings extends StatefulWidget {
  const ExhibitorBookings({super.key});

  @override
  State<ExhibitorBookings> createState() => _ExhibitorBookingsState();
}

class _ExhibitorBookingsState extends State<ExhibitorBookings> {

  final supabase = Supabase.instance.client;

  // ignore: non_constant_identifier_names
    final profile_list =
      Supabase.instance.client.from('profile').stream(primaryKey: ['id']).order('id');

    // final itemList =
    //   Supabase.instance.client.from('add_items').stream(primaryKey: ['id']).order('id');
    

  // ignore: non_constant_identifier_names
  dynamic book_list;
  dynamic itemLists;
  dynamic exhibitorId = Supabase.instance.client.auth.currentUser!.id;

  @override
  void initState() {
    super.initState();
    getBookingDetails();
  }

  Future getBookingDetails() async{

    // final exhibitorProfile = await supabase.from('ex_profile').select('id').match({'exhibitor_id': supabase.auth.currentUser!.id});

    final stalls = await supabase.from('add_stall').select().match({'exhibitor_id':exhibitorId});

    itemLists = Supabase.instance.client
      .from('add_items')
      .stream(primaryKey: ['id'])
      .order('id');

    List stallIds = [];

    for(dynamic stall in stalls){
      stallIds.add(stall['id']);
    }

      book_list = Supabase.instance.client
      .from('book_item')
      .stream(primaryKey: ['id'])
      .inFilter('stall_id', stallIds)
      .order('id');
    


    setState(() {});
  }
   Future sendPushNotification(String userId, String message) async {

    await dotenv.load(fileName: ".env");

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': dotenv.env['URL']!,
    };

    var body = {
      'app_id': dotenv.env['APP_ID']!,
      'include_player_ids': [userId],
      'contents': {'en': message},
    };

    await http.post(
      Uri.parse("https://onesignal.com/api/v1/notifications"),
      headers: headers,
      body: jsonEncode(body),
    );

  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
            gradient:LinearGradient(
          colors: [Color(0xffe7fdf8), Color(0xff80ebf9)],
          stops: [0.25, 0.75],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      
      ),
      child: Column(children: [
        const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 180,),
              Text(
                "Booking Details",
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'NovaSquare',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => getBookingDetails(),
            child: StreamBuilder(
              stream: book_list,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  final bookList = snapshot.data!;
                  if (bookList.isEmpty) {
                            return const Center(
                              child: Text("No bookings",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 20
                                ),
                              ),
                            );
                          }
                  return ListView.builder(
                    itemCount: bookList.length,
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
                            // 'Item : ${bookList[index]['item_name']}',
                            bookList[index]['item_name'],
                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'RobotoSlab',
                                              fontSize: 20
                                              ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   '${bookList[index]['exhibition_name']}',
                              //   style: const TextStyle(
                              //                   fontSize: 17,
                              //                   fontWeight: FontWeight.bold
                              //                 ),
                              // ),
                              Text(
                                'Stall : ${bookList[index]['stall_name']}',
                                style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17
                                              ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.person),
                                  Text(
                                    ' : ${bookList[index]['user_name']}',
                                    style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17
                                              ),),
                                ],
                              ),
                              // Text(' : ${bookList[index]['user_name']}'),
                              Row(
                                children: [
                                  const Icon(Icons.add_shopping_cart),
                                  Text(
                                    ' : ${bookList[index]['quantity']}',
                                    style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17
                                              ),
                                  ),
                                ],
                              ),
                              // Text('Quantity : ${bookList[index]['quantity']}'),
                              Row(
                                children: [
                                  const Icon(Icons.phone),
                                  Text(
                                    ' : ${bookList[index]['phone']}',
                                    style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17
                                              ),
                                  ),
                                ],
                              ),
                              // Text('Phone : ${bookList[index]['phone']}'),
                              Text(' ${bookList[index]['approved'] == true ? 'Accepted' : bookList[index]['approved'] == false ? 'Rejected' : 'Pending'}',
                              style: TextStyle(
                                fontSize: 18,
                                          color: bookList[index]['approved'] == true
                                              ? Colors.green
                                              : bookList[index]['approved'] == false
                                                  ? Colors.red
                                                  : Colors.blue,
                                        ),
                              ),
                              // Text('Status: ${bookList[index]['approved'] ? 'Accepted' : 'Rejected'}'),
                            ],
                          ),
          
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () async {
          
                                      if (bookList[index]['approved'] == null) {
          
                                        int itemQty = bookList[index]['available_qty'];
                                        int bookQty = bookList[index]['quantity'];
                                        int availableQty = itemQty - bookQty;
          
                                        if (availableQty >= 0){
                                          // ignore: use_build_context_synchronously
                                          await Navigator.pushNamed(
                                            context, '/exhibitor_item_accept',
                                            arguments: {
                                              'user_id': bookList[index]['user_id'],
                                              'book_id': bookList[index]['id'],
                                              'item_id': bookList[index]['item_id'],
                                              'available_qty' : availableQty,
                                            },
                                          );
                                          await getBookingDetails();
                                          setState(() {});
                                        }
                                        else{
                                          showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Item out of stock'),
                                                      content: const Text(
                                                          'The item is out of stock'),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            await supabase.from('book_item').update({'approved': false}).eq('item_id', bookList[index]['item_id']);
                                                            final profile = await supabase.from('profile').select('onesignaluserid').match({
                                                              'id': bookList[index]['user_id'],
                                                            });
                                                            const message = "Your booking is rejected";
                                                            sendPushNotification(profile[0]['onesignaluserid'], message);
                                                            // ignore: use_build_context_synchronously
                                                            Navigator.pop(
                                                                context); // Close the dialog
                                                          },
                                                          child: const Text('Reject'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                        }
          
                                        // int qty = itemLists
                                        // await supabase.from('add_items').update({'item_quantity': 'item_quantity - ${bookList[index]['quantity']}')}).eq('item_id', bookList[index]['item_id']);
                                        // ignore: use_build_context_synchronously
                                        // Navigator.pushNamed(
                                        //   context, '/exhibitor_item_accept',
                                        //   arguments: {
                                        //     'user_id': bookList[index]['user_id'],
                                        //     'book_id': bookList[index]['id'],
                                        //   },
                                        // );
                                      }
                                    },
                                    child: const Text('Accept'),
                                  ),
                                ),
                              ),
                              
                              const SizedBox(width: 10),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () async { 
                                      if (bookList[index]['approved'] == null) {
                                        // Perform the operations only if 'approved' is null
                                        await supabase.from('book_item').update({'approved': false}).eq('item_id', bookList[index]['item_id']);
                                        final profile = await supabase.from('profile').select('onesignaluserid').match({
                                          'id': bookList[index]['user_id'],
                                        });
                                        const message = "Your booking is rejected";
                                        sendPushNotification(profile[0]['onesignaluserid'], message);
                                      }
                                    },
                                    child: const Text('Reject'),
                                  ),
                                ),
                              ),
                            ],
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
        ),
      ]),
    );
  }
}
