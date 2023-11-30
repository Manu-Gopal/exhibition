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
  final exhibition_list = Supabase.instance.client.from('ex_manager').stream(primaryKey: ['id']).order('id');

  dynamic exhibitions;
  // int _currentIndex = 0;
  bool isLoading = false;
  dynamic useremail = '';

  @override
  void initState(){
    super.initState();
    useremail = supabase.auth.currentUser!.email;
    getExhibitions();
  }

  Future getExhibitions() async{
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Visitor Main"),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: exhibition_list,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      final exhibitionList = snapshot.data!;
                      return ListView.builder(
                        itemCount: exhibitionList.length,
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
                                exhibitionList[index]['exhibition_name'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Place: ${exhibitionList[index]['exhibition_place']}'),
                                  Text('Organization: ${exhibitionList[index]['organization']}'),
                                  Text('Start Date: ${exhibitionList[index]['start_date']}'),
                                  Text('End Date: ${exhibitionList[index]['end_date']}'),
                                ],
                              ),
                              trailing: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/visitor_list_stall',arguments: {
                                        'exhibition_id' :exhibitionList[index]['id'] 
                                      });
                                    },
                                    child: const Icon(Icons.keyboard_arrow_right_outlined, size: 25, color: Colors.black),
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
              'Leo Messi',
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}