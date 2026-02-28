import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_providers.dart';
import 'profile_screen.dart';

class BottomNavHomePage extends StatelessWidget {
  const BottomNavHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 사용자 정보 표시
          if (userProvider.isLoggedIn) ...[
            const Icon(Icons.person, size: 60, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              '안녕하세요, ${userProvider.user!.name}님!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              userProvider.user!.email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                userProvider.logout();
              },
              child: const Text('로그아웃'),
            ),
          ] else ...[
            const Icon(Icons.person_outline, size: 60, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              '로그인이 필요합니다',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('로그인 화면으로 이동'),
            ),
          ],
        ],
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
    // ProfileScreen을 재사용
    return const ProfileScreen();
  }
}
