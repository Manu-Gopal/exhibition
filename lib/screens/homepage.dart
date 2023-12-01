import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Container(
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          
          // image
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Exhibition',
                style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'NovaSquare',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Management',
                style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'NovaSquare',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'System',
                style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'NovaSquare',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/exhibition_manager');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(const Color.fromARGB(255, 99, 172, 172)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    child: const Text(
                      'Exhibition Manager',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/exhibitor');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(const Color.fromARGB(255, 99, 172, 172)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    child: const Text(
                      'Exhibitor',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/visitor');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(const Color.fromARGB(255, 99, 172, 172)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    child: const Text(
                      'Visitor',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          )
        ],
    ),
  ),
);

  }
}


