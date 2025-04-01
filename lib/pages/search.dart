import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/pages/game_detail.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  bool isLoading=false;
  List<dynamic> gameData=[];
  String _platform="all",_sort="popularity";
  String _category="mmorpg";
  String _tag="3d.mmorpg.fantasy.pvp";

   @override
  void initState() {
    super.initState();
    fetchapi();
  }

  List<String> platforms = ["pc", "browser", "all"];
  List<String> sorts = [
    "release-date", 
    "popularity", 
    "alphabetical", 
    "relevance"
  ];
  List<String> categories = [
    "mmorpg", "shooter", "strategy", "moba", "racing", "sports", "social", 
    "sandbox", "open-world", "survival", "pvp", "pve", "pixel", "voxel", 
    "zombie", "turn-based", "first-person", "third-Person", "top-down", 
    "tank", "space", "sailing", "side-scroller", "superhero", "permadeath", 
    "card", "battle-royale", "mmo", "mmofps", "mmotps", "3d", "2d", "anime", 
    "fantasy", "sci-fi", "fighting", "action-rpg", "action", "military", 
    "martial-arts", "flight", "low-spec", "tower-defense", "horror", "mmorts"
  ];

Future<void>fetchapi() async {
  setState(() {
    isLoading = true; // Set loading to true before starting the fetch
  });

  try {
    final response = await http.get(Uri.parse(
      'https://www.freetogame.com/api/games?platform=$_platform&category=$_category&sort-by=$_sort'
    ));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);  // Decode the response body
      setState(() {
        gameData = data;
        isLoading = false;  // Set loading to false once data is fetched
      });
      print("Successfully fetched data");
    } else {
      setState(() {
        isLoading = false;  // Set loading to false in case of failure
      });
      print("Failed to load data with status: ${response.statusCode}");
    }
  } catch (e) {
    setState(() {
      isLoading = false;  // Set loading to false if an error occurs
    });
    print("Error fetching data: $e");
  }
}


Future<void>fetchTag(String query) async {
  setState(() {
    isLoading = true; // Set loading to true before starting the fetch
  });
  _tag=query;
  try {
    final response = await http.get(Uri.parse(
      'https://www.freetogame.com/api/filter?tag=$_tag'
    ));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);  // Decode the response body
      setState(() {
        gameData = data;
        isLoading = false;  // Set loading to false once data is fetched
      });
      print("Successfully fetched data");
    } else {
      setState(() {
        isLoading = false;  // Set loading to false in case of failure
      });
      print("Failed to load data with status: ${response.statusCode}");
    }
  } catch (e) {
    setState(() {
      isLoading = false;  // Set loading to false if an error occurs
    });
    print("Error fetching data: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
             Center(
              child: Text(
                "Search Anything",
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Algerian',
                  color: Colors.green[900],
                  shadows: const [
                    Shadow(
                      offset: Offset(0, 0),
                      blurRadius: 10,
                    ),
                  ],
                ),
                
              ),
            ),
            SizedBox(height: 16,),
            Row(
              spacing: 8,
              children: [
                 DropdownButton<String>(
                value: _platform,
                onChanged: (String? newValue) {
                  setState(() {
                    _platform = newValue!;
                  });
                  fetchapi(); // Fetch data when platform changes
                },
                items: platforms.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.toUpperCase()),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              
              // Sort Dropdown
              DropdownButton<String>(
                value: _sort,
                onChanged: (String? newValue) {
                  setState(() {
                    _sort = newValue!;
                  });
                  fetchapi(); // Fetch data when sort changes
                },
                items: sorts.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.toUpperCase()),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
        
              // Category Dropdown
              DropdownButton<String>(
                value: _category,
                onChanged: (String? newValue) {
                  setState(() {
                    _category = newValue!;
                  });
                  fetchapi(); // Fetch data when category changes
                },
                items: categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.toUpperCase()),
                  );
                }).toList(),
              ),
              ],
            ),
           
            const SizedBox(height: 20),
            TextField(
              onSubmitted: (query){
                fetchTag(query);
              },
              onChanged: fetchTag,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.green[900]!),
                ),
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, color: Colors.green[900]),
                
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
            child: Container(
              child: isLoading?
              LoadingAnimationWidget.inkDrop(
                 color: Colors.blue,
                  size: 100,
                ):
               GridView.builder(
                itemCount: gameData.length,
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
          ],
        ),
      ),
    );
  }
}