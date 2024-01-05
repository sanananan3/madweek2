import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Week 2'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Container(
            color: Colors.black87,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8.0,
                childAspectRatio: 8.0,
                mainAxisSpacing: 2.0,
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: const Color(0xFF2B2B2B),
                  child: Center(
                    child: Text(
                      '$index',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Text('2'),
          Text('3'),
          Text('4'),
          Text('5'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Tap 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Tap 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Tap 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Tap 4',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Tap 5',
          ),
        ],
      ),
    );
  }
}
