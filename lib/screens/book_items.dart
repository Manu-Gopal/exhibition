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
  dynamic itemName = "";
  dynamic itemPrice = "";
  dynamic userName = "";
  dynamic bookItem;
  dynamic bookData;
  dynamic userData;
  final supabase = Supabase.instance.client;

  Future getItems() async {
    final userId = supabase.auth.currentUser!.id;
    final itemId = item_id['item_id'];

    userData = await supabase
        .from('profile')
        .select()
        .eq('user_id', userId);

    bookData = await supabase
        .from('add_items')
        .select()
        .eq('id', itemId);

    // Handle the book_data as needed

    setState(() {
        userName = userData[0]['name'];
        itemName = bookData[0]['item_name'];
        itemPrice = bookData[0]['item_price'];
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   Future.delayed(Duration.zero, () {
  //     item_id = ModalRoute.of(context)?.settings.arguments as Map?;
  //     getItems();
  //   });
  // }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      item_id = ModalRoute.of(context)?.settings.arguments as Map?;
      getItems();
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   Future.delayed(Duration.zero, () {
  //     item_id = ModalRoute.of(context)?.settings.arguments as Map?;
  //     getItems();
  //   });

  //   Future getItems() async {
  //     final userId = supabase.auth.currentUser!.id;
  //     final itemId = item_id['item_id'];
  //     print(userId);
  //     print(itemId);

  //     final book_data = await supabase
  //       .from('add_items')
  //       .select()
  //       .eq('id', itemId);
  //   }
  // }
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
          const SizedBox(height: 30,),
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
                  const Text("Quantity : ",style: TextStyle(fontSize: 20),),
                  ElevatedButton(
                    onPressed:(){
                      setState(() {
                        if(quantity > 1){
                          quantity -= 1;
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(4, 4),
                      backgroundColor: const Color.fromARGB(0, 204, 204, 213)
                    ),
                    child: const Icon(
                      Icons.remove,
                      size: 20,
                      color: Colors.black,
                    )
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed:(){
                      setState(() {
                        quantity += 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(40, 20),
                      backgroundColor: const Color.fromARGB(0, 204, 204, 213)
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.black,
                    )
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: (){
                  // final Map<String , dynamic> details = {
                  //   'item_id' : itemId,
                    
                  // };
                },
                child: const Text("Book Now"),
              ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class BookItems extends StatefulWidget {
//   const BookItems({Key? key}) : super(key: key);

//   @override
//   State<BookItems> createState() => _BookItemsState();
// }

// class _BookItemsState extends State<BookItems> {
//   int quantity = 1;
//   // ignore: non_constant_identifier_names
//   dynamic item_id;
//   dynamic bookItem;
//   final supabase = Supabase.instance.client;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     Future.delayed(Duration.zero, () {
//       item_id = ModalRoute.of(context)?.settings.arguments as Map?;
//       getItems();
//     });
//   }

//   Future getItems() async {
//     // bookItem = Supabase.instance.client
//     //   .from('add_items')
//     //   .stream(primaryKey: ['id']).eq('item_id', itemId['item_id']);
//     //   setState(() {
//     //   });

//       final userId = supabase.auth.currentUser!.id;
//       final itemId = item_id['item_id'];
//       print(userId);
//       print(itemId);
      
//       // dynamic booked_item = Supabase.instance.client
//       //   .from('add_items')
//       //   .select();
//       final book_data = await supabase
//         .from('add_items')
//         .select()
//         .eq('id', itemId);

//   // Future getItems() async {
//   //   setState(() {
//   //     isLoading = true;
//   //   });

//   //   itemList = await supabase.from('add_items').select().ilike('item_name', '%${stallDetails["searchText"]}%')
//   //   .match({'stall_id': stallDetails['stallId']});

//   //   setState(() {
//   //     isLoading = false;
//   //   });

//   // }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         title: const Text("Booking Details"),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 30,),
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               "Booking Details",
//               style: TextStyle(
//                 fontSize: 30.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(height: 25),
//           //  const Text(
//           //       "Item Name : ${book_data[0][''item_name]}",
//           //       // useremail = supabase.auth.currentUser!.email;
//           //       style: TextStyle(fontSize: 20),
//           //     ),
//               const SizedBox(height: 15),
//               const Text(
//                 "Price : ",
//                 style: TextStyle(fontSize: 20),
//               ),
//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Quantity : ",style: TextStyle(fontSize: 20),),
//                   ElevatedButton(
//                     onPressed:(){
//                       setState(() {
//                         if(quantity > 1){
//                           quantity -= 1;
//                         }
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: const Size(4, 4),
//                       backgroundColor: const Color.fromARGB(0, 204, 204, 213)
//                     ),
//                     child: const Icon(
//                       Icons.remove,
//                       size: 20,
//                       color: Colors.black,
//                     )
//                   ),
//                   const SizedBox(width: 10,),
//                   Text(
//                     quantity.toString(),
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(width: 10,),
//                   ElevatedButton(
//                     onPressed:(){
//                       setState(() {
//                         quantity += 1;
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: const Size(40, 20),
//                       backgroundColor: const Color.fromARGB(0, 204, 204, 213)
//                     ),
//                     child: const Icon(
//                       Icons.add,
//                       size: 20,
//                       color: Colors.black,
//                     )
//                   ),
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: (){},
//                 child: const Text("Book Now"),
//               ),
//         ],
//       ),
//     );
//   }
// }
// }
