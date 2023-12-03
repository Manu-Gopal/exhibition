import 'package:exhibition/screens/exhibitor_input_wrapper.dart';
import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'header.dart';

class ExhibitorLogin extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  ExhibitorLogin({super.key});

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

                  child: ExhibitorInputWrapper(),

                ),
                
              )
            ],
          ),
        ),
        ),
    );
  }
}

