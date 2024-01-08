import 'package:flutter/material.dart';
import 'package:madcamp_week2/models/user_data.dart';
import 'package:intl/intl.dart';
import 'dart:math';



class Tab1 extends StatelessWidget {
  final UserData user;

  const Tab1({required this.user, super.key});

  Widget build(BuildContext context) {

    String formattedDate = DateFormat('yyyy년 MM월 dd일에 가입함').format(user.createdAt.toLocal());

    String formmatedBirth = DateFormat('yyyy년 MM월 dd일에 태어난').format(user.birthDate.toLocal());



    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
        backgroundColor: const Color(0xFF1F1F1F),
        body: CustomScrollView(
            slivers:[
              SliverAppBar(
              expandedHeight: 250.0,
              floating:false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
               background: Container(
                 padding: const EdgeInsets.symmetric( horizontal: 15),
                 color: const Color(0xFF1F1F1F),
                 child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,

                 children: [
                   const SizedBox(
                     height: 80,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             '$formmatedBirth',
                             style: TextStyle(
                               color: Colors.white.withOpacity(0.5),
                               fontSize: 12,
                               fontWeight: FontWeight.w400,
                             ),
                           ),
                           Text(
                             user.name,
                             style: TextStyle(
                               fontSize: 30,
                               fontWeight: FontWeight.w600,
                               color: Colors.white,
                             ),
                           ),
                         ],
                       ),
                       TextButton(
                         onPressed: () {},
                         style: TextButton.styleFrom(
                           backgroundColor: Color(0xFF3A393C),
                         ),
                         child: Text(
                           '프로필 수정',
                           style: TextStyle(
                             color: Colors.white,
                           ),
                         ),
                       ),
                     ],
                   ),
                   const SizedBox(
                     height: 10,
                   ),
                   Text(
                     ' @ ' + (user.userId != null ? user.userId! : user.kakaoId.toString()),
                     style: TextStyle(
                       color: Colors.white.withOpacity(0.8),
                       fontSize: 13,
                       fontWeight: FontWeight.w300,
                     ),
                   ),
                   Row(
                     children: [
                       const SizedBox(
                         height: 5,
                       ),
                       Icon(
                         Icons.calendar_month_outlined,
                         color: Colors.white70,
                         size: 16, // 아이콘 크기 조정
                       ),
                       SizedBox(
                         width: 3,
                       ),

                       Text(
                         '$formattedDate',
                         style: TextStyle(
                           fontSize: 13,
                           color: Colors.white.withOpacity(0.7),
                           fontWeight: FontWeight.w300,
                         ),
                       ),
                     ],
                   ),
                   const SizedBox(
                     height: 20,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       TextButton(
                         onPressed: () {},
                         style: TextButton.styleFrom(
                           backgroundColor: Color(0xFF1B33B),
                         ),
                         child: Text(
                           '팔로워',
                           style: TextStyle(
                             color: Colors.white,
                           ),
                         ),
                       ),
                       const SizedBox(
                         width: 30,
                       ),
                       TextButton(
                         onPressed: () {},
                         style: TextButton.styleFrom(
                           backgroundColor: Color(0xFF1B33B),
                         ),
                         child: Text(
                           '팔로잉',
                           style: TextStyle(
                             color: Colors.white,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ],
        ),),),),


              SliverToBoxAdapter(

                child: SizedBox(height: 10),

              ),

              SliverToBoxAdapter(
                child: const TabBar(
                  indicatorColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                  indicatorWeight: 3,
                  tabs: [
                    Tab(text: '게시물', height: 50),
                    Tab(text: '미디어', height: 50),
                    Tab(text: '마음에 들어요', height: 50),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: Stack(
                  children: [
                    TabBarView(
                      children: [
                        ListView.builder(
                          key: const PageStorageKey("POST"),
                          itemCount: 1000,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  "TEST DATA $index",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        GridView.builder(
                          key: const PageStorageKey("MEDIA"),
                          itemCount: 1000,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemBuilder: ((context, index) {
                            List<int> _number = [
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)
                            ];
                            return Container(
                              color: Color.fromRGBO(
                                _number[0],
                                _number[1],
                                _number[2],
                                1,
                              ),
                              child: Center(
                                child: Text(
                                  "Grid View $index",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }),
                        ),
                        GridView.builder(
                          key: const PageStorageKey("LIKE"),
                          itemCount: 1000,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemBuilder: ((context, index) {
                            List<int> _number = [
                              Random().nextInt(255),
                              Random().nextInt(255),
                              Random().nextInt(255)
                            ];
                            return Container(
                              color: Color.fromRGBO(
                                  _number[0], _number[1], _number[2], 1),
                              child: Center(
                                child: Text(
                                  "Grid View $index",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 18.0,
                      right: 13.0,
                      child: FloatingActionButton.small(

                        onPressed: () {

                          Navigator.push(
                            context, MaterialPageRoute(
                            builder: (cnotext) => PostPage(),
                          ),
                          );

                        },
                        backgroundColor: Color(0xFF42A5F5),
                        shape: CircleBorder(),
                        child: Container(

                          child: Center(
                            child: Icon(
                              Icons.add_circle_outline,
                              size: 26.0,
                              color: Colors.white.withOpacity(0.95),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
        ),
        ),
      ),
    );
  }
}


class PostPage extends StatelessWidget {

    Widget build(BuildContext context){
      return Scaffold(

        appBar: AppBar(
          title: Text(
            'New Post',
              style: TextStyle(fontSize:15, color:Colors.white),
          ),
          backgroundColor: Color(0xFF36465D),
        ),
        backgroundColor: Color(0xFF273347),
        body: Center(
          child: Container(

            width: MediaQuery.of(context).size.width*0.8,
            height: MediaQuery.of(context).size.height*0.6,

            child: Padding(
            padding: const EdgeInsets.all(16.0),
          child: Card(
              color: Color(0xFFE3F2FD),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0),),
            child: Padding(
              padding: const EdgeInsets.all(16.0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:[

                  TextField(maxLines:5,

                  decoration: InputDecoration(
                    hintText:'무슨 일이 일어나고 있나요?',
                    hintStyle:TextStyle(
                      fontSize: 11,
                      color: Colors.black12.withOpacity(0.7)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),),

                  SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF42A5F5),
                      ),
                      onPressed: (){},
                      child: Text(
                          '게시하기',
                        style: TextStyle(
                          color: Colors.white,
                        )
                      )
                  ),
                ]
              )
            )
          )
        )
          ),
        ),
      );
    }
    }