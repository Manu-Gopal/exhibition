import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddItems extends StatefulWidget {
  const AddItems({super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  final TextEditingController itemnameController = TextEditingController();
  final TextEditingController itempriceController = TextEditingController();
  final TextEditingController itemdiscountController = TextEditingController();
  final TextEditingController itemquantityController = TextEditingController();

  dynamic stallId;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      stallId = ModalRoute.of(context)?.settings.arguments as Map?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 244, 244),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: itemnameController,
                    decoration: const InputDecoration(
                      hintText: 'Item Name',
                      labelText: 'Item Name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(9.0))),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    controller: itempriceController,
                    decoration: const InputDecoration(
                      hintText: 'Price',
                      labelText: 'Price',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(9.0))),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    controller: itemdiscountController,
                    decoration: const InputDecoration(
                      hintText: 'Discount',
                      labelText: 'Discount',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(9.0))),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    controller: itemquantityController,
                    decoration: const InputDecoration(
                      hintText: 'Quantity',
                      labelText: 'Quantity',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(9.0))
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: () async {
                      final supabase = Supabase.instance.client;
                      String itemName = itemnameController.text;
                      String itemPrice = itempriceController.text;
                      String itemDiscount = itemdiscountController.text;
                      String itemQuantity = itemquantityController.text;

                      if (itemName.isEmpty || itemPrice.isEmpty || itemDiscount.isEmpty || itemQuantity.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all details.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        return;
                      } else {
                        final Map<String, dynamic> userDetails = {
                          'item_name': itemName,
                          'item_price': itemPrice,
                          'item_discount': itemDiscount,
                          'item_quantity': itemQuantity,
                          'stall_id': stallId['stall_id']
                        };

                        await supabase.from('add_items').insert(userDetails);

                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Item added Successfully.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("back")
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}