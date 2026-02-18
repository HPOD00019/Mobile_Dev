import 'package:flutter/material.dart';

class MaximWidgets extends StatelessWidget {
  const MaximWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 25,
        children: [
          Container(
            height: 200,
            color: const Color.fromARGB(255, 138, 28, 118),
            child: Center(
              child: Text('Item 1', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 200,
            color: const Color.fromARGB(255, 166, 115, 40),
            child: Center(
              child: Text('Item 2', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 200,
            color: const Color.fromARGB(255, 105, 9, 9),
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
