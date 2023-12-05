import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  // final TextEditingController itemdiscountController = TextEditingController();
  final TextEditingController itemquantityController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  dynamic imageFile;

  dynamic exhibitorId = Supabase.instance.client.auth.currentUser!.id;

  dynamic stallId;
  bool image = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
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
                  'Add an Item', // Heading text
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
                  height: 530, // Set the desired height for the container
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors
                        .white, // Set the background color for the container
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: itemnameController,
                        decoration: const InputDecoration(
                            hintText: 'Item Name',
                            labelText: 'Item Name',
                            prefixIcon: Icon(
                              Icons.local_offer,
                              color: Color.fromARGB(255, 78, 66, 66),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)))),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: itempriceController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            hintText: 'Price',
                            labelText: 'Price',
                            prefixIcon: Icon(
                              Icons.attach_money,
                              color: Color.fromARGB(255, 78, 66, 66),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)))),
                      ),
                      // const SizedBox(height: 20.0),
                      // TextFormField(
                      //   controller: itemdiscountController,
                      //   decoration: const InputDecoration(
                      //       hintText: 'Discount',
                      //       labelText: 'Discount',
                      //       prefixIcon: Icon(
                      //         Icons.percent,
                      //         color: Color.fromARGB(255, 78, 66, 66),
                      //       ),
                      //       border: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //               color: Colors.red
                      //           ),
                      //           borderRadius: BorderRadius.all(Radius.circular(20.0))
                      //       )
                      //   ),
                      // ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: itemquantityController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            hintText: 'Quantity',
                            labelText: 'Quantity',
                            prefixIcon: Icon(
                              Icons.add_shopping_cart,
                              color: Color.fromARGB(255, 78, 66, 66),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)))),
                      ),
                      const SizedBox(height: 10,),
                      if (imageFile != null)
                        Image.file(
                          File(imageFile!.path),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 20,),
                        
                        // IconButton(onPressed: (){
                        //   uploadImage();
                        // }, icon: Icon(Icons.upload_file_rounded)
                        // ),
                      ElevatedButton(
                          onPressed: () {
                            uploadImage();
                          },
                          
                          child: const Text("Upload Image")),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final supabase = Supabase.instance.client;
                          String itemName = itemnameController.text;
                          String itemPrice = itempriceController.text;
                          // String itemDiscount = itemdiscountController.text;
                          String itemQuantity = itemquantityController.text;

                          if (itemName.isEmpty ||
                              itemPrice.isEmpty ||
                              itemQuantity.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill all details.'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                            return;
                          } else {
                            if (imageFile != null) {
                              image = true;
                            }
                            final Map<String, dynamic> userDetails = {
                              'item_name': itemName,
                              'item_price': itemPrice,
                              // 'item_discount': itemDiscount,
                              'item_quantity': itemQuantity,
                              'stall_id': stallId['stall_id'],
                              'exhibitor_id': exhibitorId,
                              'image': image
                            };

                            final response = await supabase
                                .from('add_items')
                                .insert(userDetails)
                                .select();

                            if (imageFile != null) {
                              await Supabase.instance.client.storage
                                  .from('images')
                                  .upload(
                                    'item_images/${response[0]['id']}',
                                    imageFile,
                                    fileOptions: const FileOptions(
                                        cacheControl: '3600', upsert: false),
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
                    backgroundColor: const Color.fromARGB(255, 231, 162, 87),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust the value for circular edges
                    ),

                    // primary: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 60), // Adjust the padding for size
                  ),
                        child: const Text(
                          'Add',
                          style: TextStyle(fontSize: 20.0),
                        ),
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
  }

  Future uploadImage() async {
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
