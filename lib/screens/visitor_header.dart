import 'package:flutter/material.dart';

class VisitorHeader extends StatelessWidget {
  const VisitorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50),
          Center(
            child: Text('Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40
            ),),
          ),
          SizedBox(height: 10,),
          Center(
            child: Text("Welcome...!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),),
          )
        ],
      ),
    );
  }
}