import 'package:flutter/material.dart';

class AlexiyWidgets extends StatelessWidget {
  const AlexiyWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 25,
        children: [
          Container(
            height: 200,
            color: Colors.red,
            child: Center(
              child: Text('Item 1', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 200,
            color: Colors.green,
            child: Center(
              child: Text('Item 2', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 200,
            color: Colors.blue,
            child: Center(
              child: Text('Item 3', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 200,
            color: Colors.orange,
            child: Center(
              child: Text('Item 4', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 200,
            color: Colors.purple,
            child: Center(
              child: Text('Item 5', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
