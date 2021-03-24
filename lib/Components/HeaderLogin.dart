import 'package:flutter/material.dart';

class HeaderLogin extends StatefulWidget {
  @override
  _HeaderLoginState createState() => _HeaderLoginState();
}

class _HeaderLoginState extends State<HeaderLogin> {
  
  @override
  Widget build(BuildContext context) {
   //double top = MediaQuery.of(context).size.height * 0.2;

    return  Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/food4.jpg', fit: BoxFit.cover,)
            ],
          ),
        );   
  }
}