import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chapter 1 - Flutter 학습',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const BottomNavigationExampleScreen(),
        '/home': (context) => const HomeScreen(),
        '/counter': (context) => const MyHomePage(title: '카운터 & Todo 예제'),
        '/detail': (context) =>
            const DetailScreen(id: 11, title: 'Named Route 예제'),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('홈 화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '홈 화면입니다',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/detail');
              },
              child: const Text('상세보기'),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigationExampleScreen extends StatefulWidget {
  const BottomNavigationExampleScreen({super.key});

  @override
  State<BottomNavigationExampleScreen> createState() =>
      _BottomNavigationExampleScreenState();
}

class _BottomNavigationExampleScreenState
    extends State<BottomNavigationExampleScreen> {
  int _selectedTabIndex = 0;

  final List<Widget> _navigationPages = const [
    BottomNavHomePage(),
    BottomNavSearchPage(),
    BottomNavProfilePage(),
  ];

  void _onBottomTabSelected(int newIndex) {
    if (_selectedTabIndex == newIndex) return;

    setState(() {
      _selectedTabIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Bottom Navigation + Drawer 예제'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '메뉴',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('홈'),
              onTap: () {
                Navigator.of(context).pop();
                _onBottomTabSelected(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('검색'),
              onTap: () {
                Navigator.of(context).pop();
                _onBottomTabSelected(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('프로필'),
              onTap: () {
                Navigator.of(context).pop();
                _onBottomTabSelected(2);
              },
            ),
          ],
        ),
      ),
      body: _navigationPages[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _onBottomTabSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}

class BottomNavHomePage extends StatelessWidget {
  const BottomNavHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '홈 화면입니다 🏠',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class BottomNavSearchPage extends StatelessWidget {
  const BottomNavSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '검색 화면입니다 🔍',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class BottomNavProfilePage extends StatelessWidget {
  const BottomNavProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '프로필 화면입니다 👤',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.id, required this.title});
  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('상세 화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ID: $id, Title: $title',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('돌아가기'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<String> todos = [];
  TextEditingController controller = TextEditingController();

  void addTodo() {
    if (controller.text.trim().isEmpty) {
      return;
    }
    setState(() {
      todos.add(controller.text.trim());
      controller.clear();
    });
  }

  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void _incrementCounter() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if (response.statusCode == 200) {
        print('✅ HTTP 패키지 작동 확인! 상태 코드: ${response.statusCode}');
        print('응답 데이터: ${response.body.substring(0, 100)}...');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('❌ HTTP 패키지 오류: $e');
    }
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(children: [
        Center(
          child: orientation == Orientation.portrait
              ? _buildPortraitLayout()
              : _buildLandscapeLayout(),
        ),
        Positioned(
          left: 20,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: '감소',
            child: const Icon(Icons.remove),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '증가',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildPortraitLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          '버튼을 눌러 카운터를 증가시켜보세요:',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text('$_counter',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: _counter >= 10 ? Colors.red : Colors.blue,
            )),
        Container(
          width: 200,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: const Column(children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            Text('홍길동'),
            Text('Flutter 개발자'),
            Text('📧 email@example.com'),
            Text('📱 010-1234-5678'),
          ]),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              hintText: '할 일을 입력하세요',
                              border: OutlineInputBorder()))),
                  const SizedBox(width: 10),
                  ElevatedButton(onPressed: addTodo, child: const Text('추가')),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: todos.isEmpty
                    ? const Center(
                        child: Text(
                          '할 일이 없습니다. 추가해보세요!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(todos[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => removeTodo(index),
                              tooltip: '삭제',
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
            Icon(Icons.remove),
            Icon(Icons.refresh),
          ],
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('위'),
            Text('중간'),
            Text('아래'),
          ],
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '카운터',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text('$_counter',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: _counter >= 10 ? Colors.red : Colors.blue,
                  )),
              const SizedBox(height: 20),
              Container(
                width: 200,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                    Text('홍길동'),
                    Text('Flutter 개발자'),
                    Text('📧 email@example.com'),
                    Text('📱 010-1234-5678'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                                hintText: '할 일을 입력하세요',
                                border: OutlineInputBorder()))),
                    const SizedBox(width: 10),
                    ElevatedButton(onPressed: addTodo, child: const Text('추가')),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: todos.isEmpty
                      ? const Center(
                          child: Text(
                            '할 일이 없습니다. 추가해보세요!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(todos[index]),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => removeTodo(index),
                                tooltip: '삭제',
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
