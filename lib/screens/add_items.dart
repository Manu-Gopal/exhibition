import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  final ImagePicker imagePicker = ImagePicker();
  dynamic imageFile;


  dynamic exhibitorId = Supabase.instance.client.auth.currentUser!.id;

  dynamic stallId;
  bool image = false;

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
      backgroundColor: Colors.cyan,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(255, 3, 144, 163),
                    Color.fromARGB(255, 3, 201, 227),
                    Color.fromARGB(255, 2, 155, 175)
                  ]
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 120,),
                const Text(
                  'Add an Item', // Heading text
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'NovaSquare',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 78, 66, 66),
                  ),
                ),
                const SizedBox(height: 50,),
                Container(
                  height: 600, // Set the desired height for the container
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color for the container
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: itemnameController,
                        decoration: const InputDecoration(
                            hintText: 'Item Name',
                            labelText: 'Item Name', 
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                            )
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: itempriceController,
                        decoration: const InputDecoration(
                            hintText: 'Price',
                            labelText: 'Price',
                            // prefixIcon: Icon(
                            //   Icons.mail,
                            //   color: Color.fromARGB(255, 78, 66, 66),
                            // ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                            )
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: itemdiscountController,
                        decoration: const InputDecoration(
                            hintText: 'Discount',
                            labelText: 'Discount',
                            // prefixIcon: Icon(
                            //   Icons.key,
                            //   color: Color.fromARGB(255, 78, 66, 66),
                            // ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                            )
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: itemquantityController,
                        decoration: const InputDecoration(
                            hintText: 'Quantity',
                            labelText: 'Quantity',
                            // prefixIcon: Icon(
                            //   Icons.key,
                            //   color: Color.fromARGB(255, 78, 66, 66),
                            // ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                            )
                        ),
                      ),
                      if (imageFile != null)
                        Image.file(
                          File(imageFile!.path),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                    
                      ElevatedButton(onPressed: (){
                        uploadImage();
                      }, child: Text("Add")),                   
                      const SizedBox(height: 30,),
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
                        if(imageFile!= null){
                            image =  true;
                          }
                        final Map<String, dynamic> userDetails = {
                          'item_name': itemName,
                          'item_price': itemPrice,
                          'item_discount': itemDiscount,
                          'item_quantity': itemQuantity,
                          'stall_id': stallId['stall_id'],
                          'exhibitor_id' : exhibitorId,
                          'image':image   
                        };

                        final response = await supabase.from('add_items').insert(userDetails).select();

                        if(imageFile != null){
                          await Supabase.instance.client.storage.from('images').upload(
                          'item_images/${response[0]['id']}',
                          imageFile,
                          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
                          );
                        }
                          

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
                    ],
                  ),
                ),
                const SizedBox(height: 125,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future uploadImage() async{
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imagePath = pickedImage.path;
      setState(() {
        imageFile = File(imagePath);
        
      });
    }
  }
}