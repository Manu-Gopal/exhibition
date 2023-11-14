import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 177, 167),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // image
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Exhibition Management System',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
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
                  onPressed: (){
                    Navigator.pushNamed(context, '/exhibition_manager');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                  ),
                  child: const Text('Exhibition Manager',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  )
                ),
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
                  onPressed: (){
                    Navigator.pushNamed(context, '/exhibitor');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                  child: const Text('Exhibitor',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  )
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/visitor');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                  child: const Text('Visitor',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  )
                ),
              )
            ],
          )
              
              
            ],
          ),
      
      );
  
  }
}