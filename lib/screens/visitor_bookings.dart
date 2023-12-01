import 'dart:async';
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
  dynamic bookQty;
  dynamic itemQty;

  @override
  void initState() {
    super.initState();
    getBookingDetails();
  }

  Future getBookingDetails() async{

    final visitorProfile = await supabase.from('profile').select('id').match({'user_id': supabase.auth.currentUser!.id});

    items = Supabase.instance.client
      .from('book_item')
      .stream(primaryKey: ['id'])
      .eq('user_id', visitorProfile[0]['id'])
      .order('id');
      
    setState(() {
    });
  }

  void openSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visitor Bookings"),
      ),
      body: RefreshIndicator(
        onRefresh: getBookingDetails,
        child: Center(
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
                                itemList[index]['item_name'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                      if (itemList[index]["delivery_date"] != null){
                                      
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
                                                      onPressed: () async {
                                                        // bookQty = itemList[index]['quantity'];
                                                        itemQty = itemList[index]['available_qty'];
                                                        bool isApproved = itemList[index]['approved'] ?? false;
                                                        if(isApproved){
                                                          int newQty = itemQty;
                                                        await supabase.from('add_items')
                                                          .update({'item_quantity': newQty})
                                                          .match({'id': itemList[index]['item_id']});
                                                        }
                                                        
                                                        await supabase
                                                            .from('book_item')
                                                            .delete()
                                                            .match({
                                                          'id': itemList[index]['id']
                                                        });                                                         
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.pop(context);

                                                        openSnackBar("Your booking has been cancelled successfully");
                                                            
                                                      },
                                                      child: const Text('Yes'),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context); // Close the dialog
                                                        openSnackBar("Your booking has not been cancelled");
                                                      },
                                                      child: const Text('No'),
                                                    ),
                                                  ],
                                                );
                                                
                                              },
                                            );
                                      }
                                      else{
                                        showDialog(
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
                                                        openSnackBar("Your booking has been cancelled successfully!");
                                                      },
                                                      child: const Text('Yes'),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context); // Close the dialog
                                                            openSnackBar("Your booking has not been cancelled");
                                                      },
                                                      child: const Text('No'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                      }
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
      ),
    );
  }
}