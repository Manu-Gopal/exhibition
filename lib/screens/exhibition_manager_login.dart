import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExhibitionManagerLogin extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  ExhibitionManagerLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/');
            },
            icon: const Icon(Icons.arrow_back)
            ),
          title: const Text("Exhibition Manager"),
          centerTitle: true,
        ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.lightBlue,
                    ),
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
                    prefixIcon: Icon(
                      Icons.key,
                      color: Colors.green,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(9.0))
                    )
                  ),
                ),
                const SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () async {
                    final supabase = Supabase.instance.client;
                    String email = emailController.text;
                    String password = passwordController.text;

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fill the details.'),
                          duration: Duration(seconds: 2),
                        )
                      );
                      return;
                    }
                    try{
                      await supabase.auth.signInWithPassword(
                        email: email,
                        password: password,
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(context, '/exhibition_manager_main', (route) => false);

                    }catch(e){
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid entry.'),
                          duration: Duration(seconds: 2),
                        )
                      );
                      return;
                      
                    }
 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15
                    )
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/exhibition_manager_account');
                        },
                        child: const Text('Create new account..?',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                        ),
                        ),
                      ), 
                    ],
                  )
                ],
              )
            
          
          ),
        ),
      )
    );
  }
}