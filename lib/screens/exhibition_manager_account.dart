import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExhibitionManagerAccount extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  ExhibitionManagerAccount({super.key});

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
                const SizedBox(height: 80,),
                const Text(
                  'Exhibition Manager', // Heading text
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'NovaSquare',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 78, 66, 66),
                  ),
                ),
                const SizedBox(height: 80,),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 78, 66, 66),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                    )
                  ),
                ),

                const SizedBox(height: 40.0),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Color.fromARGB(255, 78, 66, 66),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                    )
                  ),
                ),

                const SizedBox(height: 40.0),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.key,
                      color: Color.fromARGB(255, 78, 66, 66),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                    )
                  ),
                ),

                const SizedBox(height: 40.0),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    hintText: 'Phone No',
                    labelText: 'Phone No',
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Color.fromARGB(255, 78, 66, 66),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                    )
                  ),
                ),

                const SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () async {
                    final supabase = Supabase.instance.client;
                    String name = nameController.text;
                    String email = emailController.text;
                    String password = passwordController.text;
                    String phone = phoneController.text;

                    if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all details.'),
                          duration: Duration(seconds: 3),
                        )
                      );
                      return;
                    }
                    else{
                      final AuthResponse res = await supabase.auth.signUp(
                        email: email,
                        password: password
                      );

                      final Map<String , dynamic> userDetails = {
                        'user_id' :res.user!.id,
                        'name' : name,
                        'phone' : phone
                      };

                      await supabase.from('profile').upsert([userDetails]);

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Account Created Successfully.'),
                          duration: Duration(seconds: 3),
                        )
                      );
                    }

                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, '/exhibition_manager');
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 99, 172, 172),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 90,
                      vertical: 15
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontFamily: 'NovaSquare',
                    ),
                  ),
                ),
                const SizedBox(height: 125,)
              ],
            )
            
          ),
          
        ),
        ),
      ) ;
  }
}