import 'package:flutter/material.dart';

class DataFetch extends StatefulWidget {
  DataFetch({
    super.key,
  });

  @override
  State<DataFetch> createState() => _DataFetchState();
}

class _DataFetchState extends State<DataFetch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.amber,
          ),
          Container(
            height: 100,
            width: double.infinity,
            color: Color.fromARGB(255, 71, 59, 23),
          ),
          Container(
            height: 100,
            width: double.infinity,
            color: Color.fromARGB(255, 142, 136, 118),
          ),
          Container(
            height: 100,
            width: double.infinity,
            color: Color.fromARGB(255, 243, 218, 143),
          ),
          Container(
            height: 100,
            width: double.infinity,
            color: Color.fromARGB(255, 34, 26, 152),
          ),
          Container(
            height: 100,
            width: double.infinity,
            color: Color.fromARGB(255, 31, 144, 85),
          ),
        ],
      ),
    ));
  }
}
