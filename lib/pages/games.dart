import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/pages/game_detail.dart';

class Games extends StatefulWidget {  
  const Games({super.key});
  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  bool isLoading = true;
  List<dynamic> gameData=[];
  int page=50;

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
      page+=50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[ Text(
          "Games",
          style: TextStyle(
            fontSize: 50.0,
            fontFamily: 'Algerian',
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.red[100]!,
                offset: const Offset(0, 0),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: isLoading?
            LoadingAnimationWidget.inkDrop(
               color: Colors.blue,
                size: 100,
              ):
             GridView.builder(
              itemCount: page,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 2,childAspectRatio: 2/3,
            mainAxisSpacing:3),
             itemBuilder: (context,index){
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => 
                      GameDetail(data: gameData[index])
                    )
                    );
                  },
                  child: Container(color: Colors.amber[200],
                  child: Image.network(gameData[index]['thumbnail'],fit: BoxFit.cover,),
                  ),
                );
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
      ],
      
      ),
    );
  }
}