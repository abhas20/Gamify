import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/games.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/search.dart';
import 'package:myapp/theme/theme.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
      theme:lightMode,
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int selectedIndex=1;
   PageController pageControl=PageController(initialPage: 1,keepPage: true);

  void onTap(int i){
    setState(() {
      selectedIndex=i;
    });
    pageControl.jumpToPage(i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red[100]!,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]
              ),child: Text('GAMIFY',style: TextStyle(color: Colors.green[900],fontSize: 30,fontFamily: 'Al gerian',fontWeight: FontWeight.bold),),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500]!,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]
              ),
              child: 
                Image.network('https://th.bing.com/th/id/OIP.cPhQ9HUWzrpHItco8P36GwHaEK?w=263&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              ),
            ),
          ],
          
        ),
      ),
      
      body: Center(
        child: PageView(
          controller: pageControl,
          children: const [
            Search(),
            HomePage(),
            Games(),
          ],
        )
      ),
      bottomNavigationBar: CurvedNavigationBar(items:const [
         Icon(Icons.search,color: Colors.green,),
         Icon(Icons.home,color: Colors.green,),
         Icon(Icons.gamepad,color: Colors.green,),
      ],
      animationDuration: const Duration(milliseconds: 200),
      color: Colors.amber.shade100,
      backgroundColor: Colors.transparent,
      index: 1,
      onTap: onTap,
      
      ),
    );
    
  }
}