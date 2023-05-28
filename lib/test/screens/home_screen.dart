import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'pubudu',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(8),
            height: 500,
            width: 300,
            color: Colors.black,
            child: Container(
              color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
