// Flutter Material Design 패키지 가져오기
// Material Design은 Google의 디자인 시스템입니다
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// main 함수: 모든 Dart 프로그램의 시작점
// Flutter 앱은 여기서 시작됩니다
void main() {
  // MyApp 위젯을 실행하여 앱을 시작합니다
  runApp(const MyApp());
}

// StatelessWidget: 상태가 없는 위젯
// 한 번 생성되면 변경되지 않는 정적인 위젯입니다
// 앱의 전체 설정(테마, 라우팅 등)을 담당합니다
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // build 메서드: 위젯의 UI를 구성하는 메서드
  // 이 메서드가 반환하는 위젯이 화면에 표시됩니다
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 앱의 제목 (작업 관리자 등에서 표시됨)
      title: 'Chapter 1 - Flutter 학습',

      // 앱의 테마 설정 (색상, 폰트 등)
      theme: ThemeData(
        // 파란색을 기반으로 한 색상 스키마 생성
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // Material Design 3 사용
        useMaterial3: true,
      ),

      // 앱이 시작될 때 보여줄 첫 화면
      home: const MyHomePage(title: 'Flutter 학습 - Chapter 1'),
    );
  }
}

// StatefulWidget: 상태가 있는 위젯
// 데이터가 변경될 수 있는 동적인 위젯입니다
// 카운터처럼 값이 변하는 UI에 사용됩니다
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // final: 한 번 할당되면 변경할 수 없는 변수
  // required: 이 값을 반드시 전달해야 함
  final String title;

  // State 객체를 생성하는 메서드
  // StatefulWidget은 State 클래스와 함께 작동합니다
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// State 클래스: 실제 상태(데이터)를 관리하는 클래스
// 언더스코어(_)로 시작하면 private (외부에서 접근 불가)
class _MyHomePageState extends State<MyHomePage> {
  // 상태 변수: 변경 가능한 데이터
  // int는 정수형 타입입니다
  int _counter = 0;

  // 카운터를 증가시키는 함수
  // 버튼을 클릭하면 이 함수가 호출됩니다
  void _incrementCounter() async {
    // setState: 상태를 변경하고 UI를 업데이트하는 함수
    // 이 함수 안에서 상태를 변경하면 화면이 자동으로 다시 그려집니다
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
      _counter++; // 카운터를 1 증가
    });
  }

  // build 메서드: 화면의 UI를 구성합니다
  @override
  Widget build(BuildContext context) {
    // Scaffold: Material Design의 기본 화면 레이아웃
    // 앱바, 본문, 플로팅 버튼 등의 영역을 제공합니다
    return Scaffold(
      // AppBar: 화면 상단의 앱 바
      appBar: AppBar(
        // 배경색: 테마의 역색상 사용
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // 앱바에 표시될 제목
        title: Text(widget.title), // widget은 부모 위젯(MyHomePage)을 가리킴
      ),

      // body: 화면의 본문 영역
      body: Center(
        // Column: 자식 위젯들을 세로로 배치하는 위젯
        child: Column(
          // mainAxisAlignment: 주축(세로축) 정렬 방식
          mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
          // children: Column 안에 들어갈 자식 위젯들의 리스트
          children: <Widget>[
            // const Text: 변경되지 않는 텍스트 위젯
            const Text(
              '버튼을 눌러 카운터를 증가시켜보세요:',
            ),
            // Text: 카운터 값을 표시하는 텍스트
            // $_counter: 문자열 안에 변수 값을 삽입 (문자열 보간)
            Text(
              '$_counter',
              // 스타일: 테마의 headlineMedium 스타일 사용
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

      // floatingActionButton: 화면 우측 하단의 둥근 플로팅 버튼
      floatingActionButton: FloatingActionButton(
        // onPressed: 버튼을 클릭했을 때 실행될 함수
        onPressed: _incrementCounter,
        // tooltip: 버튼에 마우스를 올렸을 때 표시되는 설명
        tooltip: '증가',
        // child: 버튼 안에 들어갈 위젯
        child: const Icon(Icons.add), // 더하기 아이콘
      ),
    );
  }
}
