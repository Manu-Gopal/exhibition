import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookItems extends StatefulWidget {
  const BookItems({super.key});

  @override
  State<BookItems> createState() => _BookItemsState();
}

class _BookItemsState extends State<BookItems> {
  int quantity = 1;
  // ignore: non_constant_identifier_names
  dynamic item_id;
  // ignore: non_constant_identifier_names
  dynamic stall_id;
  dynamic itemName = "";
  dynamic itemPrice = "";
  dynamic userName = "";
  dynamic userPhone = "";
  dynamic stallName = "";
  dynamic exhibitionName = "";
  int bookItemId = 0;
  int bookUserId = 0;
  int bookQuantity = 0;
  int availableQty = 0;
  dynamic bookExhibitorId;
  dynamic bookItem;
  dynamic bookData;
  dynamic userData;
  dynamic stallData;
  dynamic exhibitionData;
  dynamic imageUrl;
  final supabase = Supabase.instance.client;

  Future getItems() async {
    final userId = supabase.auth.currentUser!.id;
    final itemId = item_id['item_id'];
    final stallId = item_id['stall_id'];
    final exId = item_id['exhibition_id']['exhibition_id'];

    userData = await supabase.from('profile').select().eq('user_id', userId);

    bookData = await supabase.from('add_items').select().eq('id', itemId);

    stallData = await supabase.from('add_stall').select().eq('id', stallId);

    exhibitionData = await supabase.from('ex_manager').select().eq('id', exId);
    if(bookData[0]['image'] == true){
      final String publicUrl = supabase
          .storage
          .from('images')
          .getPublicUrl('item_images/$itemId');

          setState(() {
          imageUrl = publicUrl;
        });
    }

    setState(() {
      userName = userData[0]['name'];
      userPhone = userData[0]['phone'];
      itemName = bookData[0]['item_name'];
      itemPrice = bookData[0]['item_price'];
      bookItemId = bookData[0]['id'];
      bookUserId = userData[0]['id'];
      stallName = stallData[0]['stall_name'];
      exhibitionName = exhibitionData[0]['exhibition_name'];
      bookExhibitorId = stallData[0]['exhibitor_id'];
      availableQty = bookData[0]['item_quantity'];

      // errerocheckkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk(vpriya)
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      item_id = ModalRoute.of(context)?.settings.arguments as Map?;
      getItems();
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
                      color: Colors.white
                      // color: Color.fromARGB(255, 78, 66, 66),
                      ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 590, // Set the desired height for the container
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors
                        .white, // Set the background color for the container
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Aligns children to the start (left)
                        children: [

                          const SizedBox(height: 25),
                                    imageUrl != null
                          ? Container(
                            height: 150,
                            width: 200,
                            child: Image.network(imageUrl))
                          :const Text('No image available'),

                          const SizedBox(height: 25),
                          Text(
                            "User Name : $userName",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Item Name : $itemName",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const SizedBox(width: 25,),
                              Text(
                                "Price      : $itemPrice",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            
                            children: [
                              const SizedBox(width: 10,),
                              const Text(
                                "Quantity   : ",
                                style: TextStyle(fontSize: 20),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 1) {
                                      quantity -= 1;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(40, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(0, 204, 204, 213),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                quantity.toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    quantity += 1;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(40, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(0, 204, 204, 213),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          await supabase.from('book_item').insert({
                            'item_id': bookItemId,
                            'user_id': bookUserId,
                            'quantity': quantity,
                            'user_name': userName.toString(),
                            'item_name': itemName.toString(),
                            'phone': userPhone.toString(),
                            'stall_name': stallName.toString(),
                            'exhibition_name': exhibitionName.toString(),
                            'stall_id': stallData[0]['id'],
                            'item_price': itemPrice,
                            'available_qty': availableQty,
                            'exhibitor_id': bookExhibitorId,
                          });
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'Item booked successfully. Wait for the exhibitor response'),
                            duration: Duration(seconds: 3),
                          ));
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        },
                        child: const Text("Book Now"),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors
                              .yellow, // Set the background color for the warning
                          borderRadius: BorderRadius.circular(
                              8), // Add rounded corners if desired
                          border: Border.all(
                              color: Colors.orange), // Add a border if desired
                        ),
                        child: const Text(
                          '*The cancellation of bookings is permitted up to one day prior to the delivery date provided by the Exhibitor.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black, // Set the text color
                          ),
                        ),
                        
                      ),
                    ],
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
