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
      appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/exhibition_manager');
            },
            icon: const Icon(Icons.arrow_back)
            ),
          title: const Text("Exhibition Manager Account"),
          centerTitle: true,
        ),
      backgroundColor: Colors.white,

      body: Center(
        child: SingleChildScrollView(
          child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(9.0))
                    )
                  ),
                ),

                const SizedBox(height: 40.0),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(9.0))
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
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(9.0))
                    )
                  ),
                ),

                const SizedBox(height: 40.0),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    hintText: 'Phone No',
                    labelText: 'Phone No',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(9.0))
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
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15
                    )
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            )
            
          ),
          
        ),
        ),
      )
    );
  }
}