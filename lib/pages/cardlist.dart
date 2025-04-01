import 'package:flutter/material.dart';

class Cardlist extends StatefulWidget {
  final Map <String,dynamic> data;
  const Cardlist({super.key, required this.data});

  @override
  State<Cardlist> createState() => _CardlistState();
}

class _CardlistState extends State<Cardlist> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Center(child: Text(widget.data['short_description'],style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),)),
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.data['thumbnail']),
                    fit: BoxFit.cover,
                  ),
                  
                ),
              ),
            );
  }
}