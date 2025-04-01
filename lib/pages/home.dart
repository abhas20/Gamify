import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:convert';

import 'package:myapp/pages/cardlist.dart';
import 'package:myapp/pages/game_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    bool isLoading = true;
  List<dynamic> gameData=[];
  int page=10;

  @override
  void initState() {
    super.initState();
    fetchapi();
  }

   fetchapi() async{
      final response=await http.get(Uri.parse('https://www.freetogame.com/api/games')).then((value){
        List data=jsonDecode(value.body);
        setState(() {
          gameData=data;
           isLoading = false;
        });
        if(value.statusCode==200) {
          print("Successfully fetched data");
        } else {
          print("Failed to load");
        }
      });
  }

  loadMore() async{
    setState(() {
      page+=5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
        children:[AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              "Let's GAMIFY",
              textStyle: TextStyle(
                fontSize: 50.0,
                fontFamily: 'Algerian',
                color: Colors.green[900],
                shadows: [
                  Shadow(
                    color: Colors.red[100]!,
                    offset: const Offset(0, 0),
                    blurRadius: 10,
                  ),
                ],
              ),
              speed: const Duration(milliseconds: 200),
            ),
          ],
          totalRepeatCount: 2,
          pause: const Duration(milliseconds: 100),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
        Container(
          child:Expanded(
            child:isLoading?  LoadingAnimationWidget.inkDrop(
               color: Colors.blue,
                size: 100,
              ): ListView.builder(
              itemCount: page,
              itemBuilder: (context,index){
              return InkWell( onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => 
                      GameDetail(data: gameData[index])
                    ));
              },
               child: Cardlist(data: gameData[index]));
            }),
          ),
        ),
         InkWell(
          onTap: loadMore,
          child: Container(
            height: 60,
            width: double.infinity,
            child: Center(child: Text("Load More",style: TextStyle(color: Colors.red[200]),)),
          ),
        )
        ]
        
      ),
    );
  }
}