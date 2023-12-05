import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class ItemAccept extends StatefulWidget {
  const ItemAccept({Key? key}) : super(key: key);

  @override
  State<ItemAccept> createState() => _ItemAcceptState();
}

class _ItemAcceptState extends State<ItemAccept> {
  final supabase = Supabase.instance.client;

  final TextEditingController deliveryDateController = TextEditingController();

  // Other variables and methods...
  // ignore: non_constant_identifier_names
  dynamic item_id;
  dynamic bookData;
  dynamic userData;
  dynamic stallData;
  dynamic exhibitionData;
  dynamic bookId;
  dynamic userId;
  dynamic bookItemId;

  dynamic itemName = "";
  dynamic userName = "";
  dynamic itemPrice = "";
  int availableQty = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      item_id = ModalRoute.of(context)?.settings.arguments as Map?;
      getItems();
    });
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

  void getItems() async {
    // final userId = supabase.auth.currentUser!.id;
    bookId = item_id['book_id'];
    userId = item_id['user_id'];
    bookItemId = item_id['item_id'];

    bookData = Supabase.instance.client
        .from('book_item')
        .stream(primaryKey: ['id']).order('id');

    // final stallId = item_id['stall_id'];
    // final exId = item_id['exhibition_id']['exhibition_id'];

    userData = await supabase.from('profile').select().eq('id', userId);

    bookData = await supabase.from('book_item').select().eq('id', bookId);

    // stallData = await supabase.from('add_stall').select().eq('id', stallId);

    // exhibitionData = await supabase.from('ex_manager').select().eq('id', exId);

    setState(() {
      userName = userData[0]['name'];
      // userPhone = userData[0]['phone'];
      itemName = bookData[0]['item_name'];
      itemPrice = bookData[0]['item_price'];
      availableQty = item_id['available_qty'];
      // bookItemId = item_id['item_id'];
      // bookItemId = bookData[0]['id'];
      // bookUserId = userData[0]['id'];
      // stallName = stallData[0]['stall_name'];
      // exhibitionName = exhibitionData[0]['exhibition_name'];
      // bookExhibitorId = stallData[0]['exhibitor_id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color.fromARGB(255, 3, 144, 163),
            Color.fromARGB(255, 3, 201, 227),
            Color.fromARGB(255, 2, 155, 175)
          ])),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 120,
                ),
                const Text(
                  'Booking Details', // Heading text
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'NovaSquare',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 78, 66, 66),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 430, // Set the desired height for the container
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 25),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[
                              200], // Set the background color for the box
                          borderRadius: BorderRadius.circular(
                              10), // Add rounded corners if desired
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Item Name: $itemName",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "User Name: $userName",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Price: $itemPrice",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),

                      // Text(
                      //   "Item Name : $itemName",
                      //   style: const TextStyle(fontSize: 20),
                      // ),
                      // const SizedBox(height: 20),
                      // Text(
                      //   "User Name : $userName",
                      //   style: const TextStyle(fontSize: 20),
                      // ),
                      // const SizedBox(height: 20),
                      // Text(
                      //   "Price : $itemPrice",
                      //   style: const TextStyle(fontSize: 20),
                      // ),

                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: deliveryDateController,
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025));

                            deliveryDateController.text =
                                DateFormat('yyyy-MM-dd').format(picked!);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Delivery Date',
                            hintText: 'yyyy-mm-dd',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () async {
                            final supabase = Supabase.instance.client;
                            String deliveryDate = deliveryDateController.text;

                            if (deliveryDate.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Please fill all details.'),
                                duration: Duration(seconds: 3),
                              ));
                              return;
                            } else {
                              await supabase.from('add_items').update({
                                'item_quantity': availableQty
                              }).match({'id': bookItemId});

                              await supabase.from('book_item').update({
                                'approved': true,
                                'delivery_date': deliveryDate
                              }).eq('id', bookId);
                              final profile = await supabase
                                  .from('profile')
                                  .select('onesignaluserid')
                                  .match({'id': userId});
                              const message = "Your booking has been accepted";
                              sendPushNotification(
                                  profile[0]['onesignaluserid'], message);

                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                            
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15)),
                          child: const Text(
                            'Accept',
                            style: TextStyle(fontSize: 20.0),
                          )),

                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 125,
                )
              ],
            ),
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Item Details'),
    //   ),
    //   body: Column(
    //     children: [
    //       const SizedBox(
    //         height: 30,
    //       ),
    //       const Padding(
    //         padding: EdgeInsets.all(8.0),
    //         child: Text(
    //           'Item Details',
    //           style: TextStyle(
    //             fontSize: 30.0,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),

    //     ],
    //   ),
    // );
  }
}
