import 'package:exhibition/screens/input_wrapper.dart';
import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'header.dart';

class ExhibitionManagerLogin extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  ExhibitionManagerLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        body: SingleChildScrollView(
          child: Container(
          width: double.infinity,
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
          child: Column(
            children: <Widget> [
              const SizedBox(
                height: 260,

                child: Header(),

              ),
              SizedBox(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)
                    )
                  ),

                  child: InputWrapper(),

                ),
                
              )
            ],
          ),
        ),
        ),
    );
  }
}



// body: Container(
        //   width: double.infinity,
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       colors: [
        //         Color.fromARGB(255, 3, 144, 163),
        //         Color.fromARGB(255, 3, 201, 227),
        //         Color.fromARGB(255, 2, 155, 175)
        //       ]
        //     )
        //   ),
        //   child: Column(
        //     children: <Widget> [
        //       const SizedBox(
        //         height: 80,
        //         child: Header(),
        //       ),
        //       SizedBox(
        //         child: Container(
        //           decoration: const BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(60),
        //               topRight: Radius.circular(60)
        //             )
        //           ),
        //           child: const InputWrapper(),
        //         ),
                
        //       )
        //     ],
        //   ),
        // ),

        //  body: Center(
        //   child: SingleChildScrollView(
        //     child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             TextFormField(
        //               controller: emailController,
        //               decoration: InputDecoration(
        //                   hintText: 'Email',
        //                   labelText: 'Email',
        //                   prefixIcon: const Icon(
        //                     Icons.email,
        //                     color: Colors.lightBlue,
        //                   ),
        //                   border: OutlineInputBorder(
        //                     borderSide: const BorderSide(color: Colors.red),
        //                     borderRadius: BorderRadius.circular(25.0),
        //                   )),
        //             ),
        //             const SizedBox(height: 40.0),
        //             TextFormField(
        //               controller: passwordController,
        //               obscureText: true,
        //               decoration: InputDecoration(
        //                   hintText: 'Password',
        //                   labelText: 'Password',
        //                   prefixIcon: const Icon(
        //                     Icons.key,
        //                     color: Colors.green,
        //                   ),
        //                   border: OutlineInputBorder(
        //                     borderSide: const BorderSide(color: Colors.red),
        //                     borderRadius: BorderRadius.circular(25.0),
        //                   )),
        //             ),
        //             const SizedBox(height: 40.0),
        //             ElevatedButton(
        //               onPressed: () async {
        //                 final supabase = Supabase.instance.client;
        //                 String email = emailController.text;
        //                 String password = passwordController.text;

        //                 if (email.isEmpty || password.isEmpty) {
        //                   ScaffoldMessenger.of(context)
        //                       .showSnackBar(const SnackBar(
        //                     content: Text('Fill the details.'),
        //                     duration: Duration(seconds: 2),
        //                   ));
        //                   return;
        //                 }
        //                 try {
        //                   await supabase.auth.signInWithPassword(
        //                     email: email,
        //                     password: password,
        //                   );
        //                   // ignore: use_build_context_synchronously
        //                   Navigator.pushNamedAndRemoveUntil(context,
        //                       '/exhibition_manager_main', (route) => false);
        //                 } catch (e) {
        //                   // ignore: use_build_context_synchronously
        //                   ScaffoldMessenger.of(context)
        //                       .showSnackBar(const SnackBar(
        //                     content: Text('Invalid entry.'),
        //                     duration: Duration(seconds: 2),
        //                   ));
        //                   return;
        //                 }
        //               },
        //               style: ElevatedButton.styleFrom(
        //                   backgroundColor: Colors.green,
        //                   padding: const EdgeInsets.symmetric(
        //                       horizontal: 50, vertical: 15)),
        //               child: const Text(
        //                 'Sign In',
        //                 style: TextStyle(fontSize: 20.0),
        //               ),
        //             ),
        //             const SizedBox(height: 30),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 const Text(
        //                   "Don't have an account..? ",
        //                   style: TextStyle(
        //                     fontSize: 18,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.black,
        //                   ),
        //                 ),
        //                 GestureDetector(
        //                   onTap: () {
        //                     Navigator.pushNamed(
        //                         context, '/exhibition_manager_account');
        //                   },
        //                   child: const Text(
        //                     'Sign up',
        //                     style: TextStyle(
        //                       fontSize: 18,
        //                       fontWeight: FontWeight.bold,
        //                       color: Colors.blue,
        //                       decoration: TextDecoration.underline,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         )),
        //   ),
        // )
