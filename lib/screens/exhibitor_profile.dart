import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExhibitorProfile extends StatefulWidget {
  const ExhibitorProfile({super.key});

  @override
  State<ExhibitorProfile> createState() => _ExhibitorProfileState();
}

class _ExhibitorProfileState extends State<ExhibitorProfile> {
  final supabase = Supabase.instance.client;
  // ignore: non_constant_identifier_names
  dynamic ex_profile;
  bool isLoading = false;
  dynamic uId = Supabase.instance.client.auth.currentUser!.id;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  // final TextEditingController cityController =  TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future getProfile() async {
    setState(() {
      isLoading = true;
    });
    ex_profile =
        await supabase.from('ex_profile').select().match({'exhibitor_id': uId});
    nameController.text = ex_profile[0]['name'];
    phoneController.text = ex_profile[0]['phone'];
    // cityController.text = profile[0]['city'];
    emailController.text = supabase.auth.currentUser!.email!;
    setState(() {
      isLoading = false;
    });
  }

  Widget textFields(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0), // Adjust the left padding as needed
      child: TextField(
        controller: controller,
        enabled: false,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xffe7fdf8), Color(0xff80ebf9)],
            stops: [0.25, 0.75],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200,),
            Text(
              "Account Details",
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'NovaSquare',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text('   Name'),
        textFields(nameController),
        const SizedBox(height: 15),
        const Text("   PhoneNumber"),
        textFields(phoneController),
        const SizedBox(height: 15),
        const Text("   Email"),
        textFields(emailController),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
              elevation: MaterialStateProperty.all(3),
              backgroundColor: MaterialStateProperty.all(
                  Colors.grey), // Set the background color here
            ),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, '/');
            },
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RobotoSlab',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                      width: 8), // Add some spacing between text and icon
                  Icon(Icons.logout, color: Colors.black),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
