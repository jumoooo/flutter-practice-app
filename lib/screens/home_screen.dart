import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('홈 화면'),
      ),
      body: Center(
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
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/detail');
              },
              child: const Text('상세보기'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: const Text('프로필 화면'),
            ),
          ],
        ),
      ),
    );
  }
}
