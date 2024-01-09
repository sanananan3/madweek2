import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madcamp_week2/providers//user.dart';
import 'package:madcamp_week2/rest_client.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;


class Tab2 extends StatefulWidget {

  const Tab2({super.key});

  State<Tab2> createState() => _SearchBarAppState();

}

class _SearchBarAppState extends State<Tab2> {

  late SearchController _searchController;

  bool isDark = true;
  List<String> videoIds =['D8VEhcPeSlc', '97_-_WugRFA','iUw3LPM7OBU','WGm2HmXeeRI','gvXsmI3Gdq8','5_n6t9G2TUQ','3kGAlp_PNUg','9JFi7MmjtGA','yFlxYHjHYAw',
    'j1uXcHwLhHM','KHouJsSH4PM','EIz09kLzN9k','6ZUIwj3FgUY','jOTfBlKSQYY','eQNHDV7lKgE','Dbxzh078jr4','ArmDp-zijuc','sVTy_wmn5SU','UNo0TG9LwwI'];

  String currentVideoId = 'D8VEhcPeSlc';

  YoutubePlayerController _con = YoutubePlayerController(
    initialVideoId: 'D8VEhcPeSlc',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
      startAt: 59,
    ),
  );

  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  void changeVideo(){
    final Random random = Random();
    final int randomIndex = random.nextInt(videoIds.length);
    final String newVideoId = videoIds[randomIndex];

    _con.load(newVideoId);

    setState(() {
      currentVideoId = newVideoId;


    });
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      changeVideo();
      print('지금~~' + currentVideoId);

    });
  }

  Widget build(BuildContext context){
    final ThemeData themeData = ThemeData (
      useMaterial3: true,
      brightness: isDark? Brightness.dark : Brightness.light
    );

    return MaterialApp(
      theme: themeData,
      home: Scaffold(

        appBar: AppBar(title: const Text ('검색', style: TextStyle(fontSize: 18.0,),),),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SearchAnchor(
                searchController: _searchController,
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),

                    onChanged: (String query) {

                    },
                    onTap:() async {

                    try {
                      final response = await restClient.searchUsers({
                        'userId': _searchController.text,
                        'name':  _searchController.text, // Add the appropriate property for name
                        'phone':  _searchController.text, // Add the appropriate property for phone


                      // Add the appropriate property for birthDate
                      });
                      if(response.success){
                        final user = response.user!;

                        print('지금 !! User found: $user');

                      } else {
                        print ('지금!!! user not found ');
                      }
                    } catch(error) {
                      print('지금!! 걍 catch로 유저 서치 에러남 $error');
                    }

                    },
                    leading: const Icon(Icons.search),
                    trailing: <Widget>[
                      Tooltip(
                        message: 'Change brightness mode',
                        child: IconButton(
                          isSelected: isDark,
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(Icons.wb_sunny_outlined),
                          selectedIcon:
                          const Icon(Icons.brightness_2_outlined),
                        ),
                      )
                    ],
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),

                    );
                  });
                },
              ),
            ),
            SizedBox(height:6),
            Text(
              '   지금 가장 핫한 국내 음악을 감상하세요! ' , style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
            ),
            SizedBox(height:15),
            YoutubePlayer(
              controller: _con,

            ),

            SizedBox(height:20),
            Text(
              '   나를 위한 실시간 트렌드' , style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),

          ),
        ),

          );
  }
}