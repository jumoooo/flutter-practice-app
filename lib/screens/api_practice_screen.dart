import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post.dart';

class ApiPracticeScreen extends StatefulWidget {
  const ApiPracticeScreen({super.key});

  @override
  State<ApiPracticeScreen> createState() => _ApiPracticeScreenState();
}

class _ApiPracticeScreenState extends State<ApiPracticeScreen> {
  // 상태 변수들
  List<Post> posts = []; // Post 리스트
  bool isLoading = false; // 로딩 상태
  String? errorMessage; // 에러 메시지

  @override
  void initState() {
    super.initState();
    // 화면이 처음 로드될 때 자동으로 데이터 가져오기
    fetchPosts();
  }

  // 리스트 API 호출 함수 (초기 로딩용)
  Future<void> fetchPosts() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        // JSON 배열을 List<dynamic>으로 변환
        List<dynamic> jsonList = jsonDecode(response.body);

        // 각 JSON 객체를 Post 객체로 변환하여 리스트에 추가
        List<Post> fetchedPosts = jsonList
            .map((json) => Post.fromJson(json as Map<String, dynamic>))
            .toList();

        setState(() {
          posts = fetchedPosts;
          isLoading = false;
        });

        print('✅ 리스트 데이터 가져오기 성공! 총 ${posts.length}개');
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
      print('❌ API 호출 오류: $e');
    }
  }

  // 새로고침용 함수 (RefreshIndicator에서 사용)
  Future<void> refreshPosts() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        // JSON 배열을 List<dynamic>으로 변환
        List<dynamic> jsonList = jsonDecode(response.body);

        // 각 JSON 객체를 Post 객체로 변환하여 리스트에 추가
        List<Post> fetchedPosts = jsonList
            .map((json) => Post.fromJson(json as Map<String, dynamic>))
            .toList();

        setState(() {
          posts = fetchedPosts;
          errorMessage = null; // 에러 메시지 초기화
        });

        print('✅ 새로고침 성공! 총 ${posts.length}개');
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
      print('❌ 새로고침 오류: $e');
      // RefreshIndicator가 에러를 처리할 수 있도록 rethrow
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API 연동 실습'),
        actions: [
          // 새로고침 버튼
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchPosts,
            tooltip: '새로고침',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  // 화면 본문 위젯
  Widget _buildBody() {
    // 로딩 중일 때
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러가 발생했을 때
    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              '에러 발생',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: fetchPosts,
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    // 데이터가 없을 때
    if (posts.isEmpty) {
      return const Center(
        child: Text('데이터가 없습니다'),
      );
    }

    // 리스트 표시 (RefreshIndicator로 감싸기)
    return RefreshIndicator(
      onRefresh: refreshPosts, // 아래로 당겨서 새로고침
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(
                '${post.id}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              post.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              post.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            isThreeLine: true,
            onTap: () {
              // 상세보기 (선택사항)
              _showPostDetail(post);
            },
          );
        },
      ),
    );
  }

  // Post 상세 정보 보기 (선택사항)
  void _showPostDetail(Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Post #${post.id}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '제목',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              Text(post.title),
              const SizedBox(height: 16),
              Text(
                '내용',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              Text(post.body),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }
}
