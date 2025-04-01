import 'package:flutter/material.dart';

class GameDetail extends StatefulWidget {
  final Map data;
  const GameDetail({super.key, required this.data});

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('GAMIFY',style: TextStyle(color: Colors.green[900],fontSize: 30,fontFamily: 'Al gerian',fontWeight: FontWeight.bold),),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Image.network(widget.data['thumbnail']),
              height: 300,
            ),
            // Title
              Text(
                widget.data["title"] ?? "No Title Available",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline
                ),
              ),
              SizedBox(height: 8),
        
              // Short Description
              Text(
                widget.data["short_description"] ?? "No Description Available",
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16),
        
              // Game URL
              Text(
                "Game URL: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.data["game_url"] ?? "No URL Available",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 16),
        
              // Genre
              Text(
                "Genre: ${widget.data["genre"] ?? 'No Genre Available'}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
        
              // Platform
              Text(
                "Platform: ${widget.data["platform"] ?? 'No Platform Available'}",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Publisher: ${widget.data["publisher"] ?? 'No Platform Available'}",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Developer: ${widget.data["developer"] ?? 'No Platform Available'}",
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                "Freetogame profile URL: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.data["freetogame_profile_url"] ?? "No URL Available",
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}