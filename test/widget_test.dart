import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chapter_1/main.dart';

void main() {
  testWidgets('카운터 증가 테스트', (WidgetTester tester) async {
    // 앱 빌드 및 실행
    await tester.pumpWidget(const MyApp());

    // '0' 텍스트가 화면에 표시되는지 확인
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // 플로팅 액션 버튼 찾기 및 탭
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // 카운터가 증가했는지 확인
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
