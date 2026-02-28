import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'bottom_nav_pages.dart';

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
            ListTile(
              leading: const Icon(Icons.api),
              title: const Text('API 연동 실습'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/api-practice');
              },
            ),
            ListTile(
              leading: const Icon(Icons.api),
              title: const Text('Provider 실습'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/provider-test');
              },
            ),
            const Divider(),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return ListTile(
                  leading: Icon(
                    themeProvider.isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                  title: Text(
                    themeProvider.isDarkMode ? '라이트 모드' : '다크 모드',
                  ),
                  onTap: () {
                    themeProvider.toggleTheme();
                  },
                );
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
