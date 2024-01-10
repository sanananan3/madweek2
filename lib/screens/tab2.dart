import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madcamp_week2/providers//user.dart';
import 'package:madcamp_week2/models/user.dart';
import 'package:madcamp_week2/providers/tweet.dart';
import 'package:madcamp_week2/rest_client.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:madcamp_week2/screens/userprofile.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class Tab2 extends StatefulWidget {

  const Tab2({super.key});

  State<Tab2> createState() => _SearchBarAppState();

}

class _SearchBarAppState extends State<Tab2>  with TickerProviderStateMixin {

  final con = FlipCardController();
  final cong1 = GestureFlipCardController();
  late Timer autoFlipTimer;
  bool isCardFlipped = false;




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

    autoFlipTimer = Timer.periodic(Duration( seconds: 1), (timer) {
      setState(() {
        isCardFlipped = !isCardFlipped;
      });
    });
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
                    onSubmitted:(String query) async {

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
                        _openUserProfilePage(user);

                      } else {
                        print ('지금!!! user not found ');
                        _shownotfoundDialog();
                      }
                    } catch(error) {
                      print('지금!! 걍 catch로 유저 서치 에러남 $error');
                      _shownotfoundDialog();
                    }


                    _searchController.clear();


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
            SizedBox(height:20),
            Text('    대한민국에서 트렌드 중', style: TextStyle(fontSize: 12, color:Colors.white70,fontWeight: FontWeight.w100)),
            SizedBox(height:20),


            AnimatedSwitcher(
              duration: Duration(milliseconds: 1000),
              child: isCardFlipped
                  ? Container(
                key: UniqueKey(),
                height: 30,
                width: 400,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi*180), // Flip the card
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue, // Adjust the color as needed
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        '    과자파티',
                        style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
                  : Container(
                key: UniqueKey(),
                height: 30,
                width: 400,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue, // Adjust the color as needed
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '    제주항공',
                      style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height:20),
            Text('    Only on X 실시간 트렌드', style: TextStyle(fontSize: 12, color:Colors.white70,fontWeight: FontWeight.w300)),
            SizedBox(height:20),



            AnimatedSwitcher(
              duration: Duration(milliseconds: 900),
              child: isCardFlipped
                  ? Container(
                key: UniqueKey(),
                height: 30,
                width: 400,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi*180), // Flip the card
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue, // Adjust the color as needed
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        '    솔로지옥',
                        style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
                  : Container(
                key: UniqueKey(),
                height: 30,
                width: 400,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue, // Adjust the color as needed
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '    환승연애',
                      style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height:20),
            Text('    대한민국에서 트렌드 중', style: TextStyle(fontSize: 12, color:Colors.white70,fontWeight: FontWeight.w100)),
            SizedBox(height:20),



            AnimatedSwitcher(
              duration: Duration(milliseconds: 1100),
              child: isCardFlipped
                  ? Container(
                key: UniqueKey(),
                height: 30,
                width: 400,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi*180), // Flip the card
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue, // Adjust the color as needed
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        '    대설주의보',
                        style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
                  : Container(
                key: UniqueKey(),
                height: 30,
                width: 400,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue, // Adjust the color as needed
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '    잇츠라이브',
                      style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height:20),
            Text('    대한민국에서 트렌드 중', style: TextStyle(fontSize: 12, color:Colors.white70,fontWeight: FontWeight.w100)),
            SizedBox(height:20),



            AnimatedSwitcher(
              duration: Duration(milliseconds: 1000),
              child: isCardFlipped
                  ? Container(
                key: UniqueKey(),
                height: 30,
                width: 400,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi*180), // Flip the card
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue, // Adjust the color as needed
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        '    누나 잠들면 안대',
                        style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
                  : Container(
                key: UniqueKey(),
                height: 30,
                width: 400,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue, // Adjust the color as needed
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '    #LALISA',
                      style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height:20),
            Text('    패션, 뷰티 실시간 트렌드', style: TextStyle(fontSize: 12, color:Colors.white70,fontWeight: FontWeight.w100)),
            SizedBox(height:20),



            AnimatedSwitcher(
              duration: Duration(milliseconds: 900),
              child: isCardFlipped
                  ? Container(
                key: UniqueKey(),
                height: 30,
                width: 400,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi*180), // Flip the card
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue, // Adjust the color as needed
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        '    쌍계피지떡',
                        style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
                  : Container(
                key: UniqueKey(),
                height: 30,
                width: 400,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue, // Adjust the color as needed
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '    좌석 추첨',
                      style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height:40),




          ],
          ),
        ),
      ),
    );
  }


  void _openUserProfilePage(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserProfilePage(user: user)),
    );
  }


  void _shownotfoundDialog(){

    showDialog(

        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text('           사용자를 찾을 수 없습니다', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold ,)),
            backgroundColor: Color(0xFF1DA1F2),

            content: Column (
              crossAxisAlignment:  CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [

                SizedBox(height: 20),
                Text('유효한 인물이나 토픽 또는 키워드를 검색해 보세요', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)
                ),
              ],
            ),

            actions:[
              TextButton(

                onPressed: () {
                  Navigator.of(context).pop();

                },
                style: TextButton.styleFrom(
                minimumSize: Size(40,30),
                ),
                child: Text('확인', style: TextStyle(fontSize: 11)),
              ),
            ],
          );
        }

    );
  }
}