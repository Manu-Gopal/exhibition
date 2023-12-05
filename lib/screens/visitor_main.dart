// import 'package:exhibition/screens/visitor_bookings.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VisitorMain extends StatefulWidget {
  const VisitorMain({super.key});

  @override
  State<VisitorMain> createState() => _ExhibitorMainState();
}

class _ExhibitorMainState extends State<VisitorMain> {
  final supabase = Supabase.instance.client;
  // ignore: non_constant_identifier_names
  final exhibition_list = Supabase.instance.client
      .from('ex_manager')
      .stream(primaryKey: ['id']).order('id');

  dynamic exhibitions;
  // int _currentIndex = 0;
  bool isLoading = false;
  dynamic useremail = '';

  @override
  void initState() {
    super.initState();
    useremail = supabase.auth.currentUser!.email;
    getExhibitions();
  }

  Future getExhibitions() async {
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[400],
        title: const Text(
          "Visitor",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Container(
        decoration: const BoxDecoration(
            gradient:LinearGradient(
          colors: [Color(0xffe7fdf8), Color(0xff80ebf9)],
          stops: [0.25, 0.75],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      
      ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Exhibitions',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color:
                        Colors.black, // Choose the color you want for the title
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: StreamBuilder(
                    stream: exhibition_list,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        final exhibitionList = snapshot.data!;
                        return ListView.builder(
                          // gridDelegate:
                          //     const SliverGridDelegateWithFixedCrossAxisCount(
                          //   crossAxisCount:
                          //       1, // Adjust the crossAxisCount as needed
                          //   crossAxisSpacing:
                          //       8.0, // Adjust the crossAxisSpacing as needed
                          //   mainAxisSpacing:
                          //       8.0, // Adjust the mainAxisSpacing as needed
                          // ),
                          itemCount: exhibitionList.length,
                          itemBuilder: (context, index) {
                            return ClipRect(
                              child: Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Material(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 187, 186, 186)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              exhibitionList[index]
                                                  ['exhibition_name'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(context,
                                                      '/visitor_list_stall',
                                                      arguments: {
                                                        'exhibition_id':
                                                            exhibitionList[
                                                                index]['id'],
                                                      });
                                                },
                                                icon: const Icon(
                                                    Icons
                                                        .keyboard_arrow_right_outlined,
                                                    size: 35,
                                                    color: Colors.black),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            // const Icon(Icons.location_city),
                                            const Text(
                                              '@',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                '${exhibitionList[index]['exhibition_place']}',
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  // color: Colors.grey
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.eco),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                '${exhibitionList[index]['organization']}',
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.calendar_month),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                '${exhibitionList[index]['start_date']}',
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.remove,
                                              size: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Text(
                                                '${exhibitionList[index]['end_date']}',
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ],
                                        ),
                                      
                                      ],
                                    ),
                                  ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  final supabase = Supabase.instance.client;
  dynamic useremail = '';
  dynamic username = '';
  int bookQty = 0;

  @override
  void initState() {
    super.initState();
    useremail = supabase.auth.currentUser!.email;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            accountEmail: Text(useremail,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            decoration: const BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                image: AssetImage('images/exhibition_back.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/visitor_bookings');
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const VisitorBookings()));
            },
            leading: const Icon(
              Icons.shop,
              color: Colors.black,
            ),
            title: const Text(
              "My Orders",
              style: TextStyle(fontFamily: 'RobotoSlab',fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () async {
              await supabase.auth.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, '/');
            },
            leading: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: const Text(
              "Log Out",
              style: TextStyle(fontFamily: 'RobotoSlab',fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
