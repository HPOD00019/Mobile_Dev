import 'package:flutter/material.dart';

class ArtyomWidgets extends StatelessWidget {
  const ArtyomWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 25,
        children: [
          Container(
            height: 200,
            color: const Color.fromARGB(255, 33, 90, 189),
            child: Center(
              child: Text('Item 1', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 200,
            color: const Color.fromARGB(255, 28, 197, 33),
            child: Center(
              child: Text('Item 2', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 200,
            color: const Color.fromARGB(255, 206, 167, 36),
            child: Center(
              child: Text('Item 3', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 200,
            color: const Color.fromARGB(255, 15, 153, 158),
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
