// import 'package:exhibition/screens/button.dart';
// import 'package:exhibition/screens/input_field.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InputWrapper extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  InputWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          // const SizedBox(height: 50,),
          const SizedBox(height: 25,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            

            // child: InputField(),


            child : Column(
      children: <Widget>[
        // const SizedBox(height: 50,),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey //200
              )
            )
          ),
          
          child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.lightBlue,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  ),
                ),
          //  const TextField(
          //   controller: emailController,
          //   decoration: InputDecoration(
          //     hintText: "Enter your email",
          //     hintStyle: TextStyle(color: Colors.grey),
          //     border: InputBorder.none
          //   ),
          // ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey //200
              )
            )
          ),
          child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Colors.lightBlue,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    )
                  ),
                ),
          // const TextField(
          //   obscureText: true,
          //   decoration: InputDecoration(
          //     hintText: "Enter your password",
          //     hintStyle: TextStyle(color: Colors.grey),
          //     border: InputBorder.none
          //   ),
          // ),
        ),
      ],
    ),

          ),
          const SizedBox(height: 30,),
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
                    backgroundColor: const Color.fromARGB(255, 99, 172, 172),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 15
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      // color: Colors.black,
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'NovaSquare',
                    ),
                    
                  ),
          ),
                const SizedBox(height: 40,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account..? ",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NovaSquare',
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/exhibition_manager_account');
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NovaSquare',
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),

        ],
      ), 
    );
  }
}

// const Text('forgot',
          // style: TextStyle(color: Colors.grey),
          // ),
          // const SizedBox(
          //   height: 40,
          // ),


          // const Button()


          // ElevatedButton(
          //         onPressed: () async {
          //           final supabase = Supabase.instance.client;
          //           String email = emailController.text;
          //           String password = passwordController.text;

          //           if (email.isEmpty || password.isEmpty) {
          //             ScaffoldMessenger.of(context).showSnackBar(
          //               const SnackBar(
          //                 content: Text('Fill the details.'),
          //                 duration: Duration(seconds: 2),
          //               )
          //             );
          //             return;
          //           }

          //           try{
          //             await supabase.auth.signInWithPassword(
          //               email: email,
          //               password: password,
          //             );
          //             // ignore: use_build_context_synchronously
          //             Navigator.pushNamedAndRemoveUntil(context, '/exhibitor_main', (route) => false);

          //           }catch(e){
          //             // ignore: use_build_context_synchronously
          //             ScaffoldMessenger.of(context).showSnackBar(
          //               const SnackBar(
          //                 content: Text('Invalid entry.'),
          //                 duration: Duration(seconds: 2),
          //               )
          //             );
          //             return;
                      
          //           }

                    
          //         },
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Colors.green,
          //           padding: const EdgeInsets.symmetric(
          //             horizontal: 50,
          //             vertical: 15
          //           )
          //         ),
          //         child: const Text(
          //           'Sign In',
          //           style: TextStyle(fontSize: 20.0),
          //         ),
          //       ),

          // Container(
          //   height: 50,
          //     margin: const EdgeInsets.symmetric(horizontal: 50),
          //     decoration: BoxDecoration(
          //       color: Colors.cyan,   //500
          //       borderRadius: BorderRadius.circular(10)
          //     ),
              
          //     child: const Center(
                
          //       child: Text('Login', style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 15,
          //         fontWeight: FontWeight.bold
          //       ),),
          //     ),
          // )