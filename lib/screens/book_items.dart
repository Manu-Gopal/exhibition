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
  int availableQty=0;
  int bookExhibitorId = 0;
  dynamic bookItem;
  dynamic bookData;
  dynamic userData;
  dynamic stallData;
  dynamic exhibitionData;
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
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Booking Details"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Booking Details",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 25),
          Text(
            "User name : $userName",
            // useremail  = supabase.auth.currentUser!.email;
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 15),
          Text(
            "Item Name : $itemName",
            // useremail  = supabase.auth.currentUser!.email;
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 15),
          Text(
            "Price : $itemPrice",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Quantity : ",
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
                      minimumSize: const Size(4, 4),
                      backgroundColor: const Color.fromARGB(0, 204, 204, 213)),
                  child: const Icon(
                    Icons.remove,
                    size: 20,
                    color: Colors.black,
                  )),
              const SizedBox(
                width: 10,
              ),
              Text(
                quantity.toString(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      quantity += 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(40, 20),
                      backgroundColor: const Color.fromARGB(0, 204, 204, 213)),
                  child: const Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.black,
                  )),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              await supabase.from('book_item').insert({
                'item_id': bookItemId,
                'user_id': bookUserId,
                'quantity': quantity,
                'user_name' : userName.toString(),
                'item_name' : itemName.toString(),
                'phone' : userPhone.toString(),
                'stall_name' : stallName.toString(),
                'exhibition_name' : exhibitionName.toString(),
                'exhibitor_id' : bookExhibitorId,
                'stall_id' : stallData[0]['id'],
                'item_price' : itemPrice,
                'available_qty' : availableQty,
              });
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item booked successfully. Wait for the exhibitor response'),
                  duration: Duration(seconds: 3),
                )
              );
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child: const Text("Book Now"),
          ),
        ],
      ),
    );
  }
}
