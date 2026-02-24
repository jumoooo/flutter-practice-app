# 🎓 Learning Helper Skills

## Language Separation (언어 구분)
**Internal Processing (Agent reads)**: All instructions, logic, and internal operations are in English.
**User-Facing Content (User sees)**: All explanations, questions, code comments, and templates shown to learners are in Korean.

## Overview
This skill provides core functions for the Flutter learning assistant Agent. It includes functions to guide questions, generate example code, and reference learning materials.

**한글 설명 (사용자용)**: 이 스킬은 Flutter 학습 보조 Agent가 사용하는 핵심 기능들을 제공합니다. 학습자의 질문에 대해 질문을 유도하고, 예시 코드를 생성하며, 학습 자료를 참조하는 기능을 포함합니다.

---

## Skills

### 1. Generate Follow-up Question
**Purpose**: Encourage learners to think deeper by asking guided questions

**Input**: 
- Current question/topic
- Learning stage (from mockdowns folder structure)
- Current understanding level

**Output**: 
- A thought-provoking question
- Context for why this question matters

**Template**:
```
💭 생각해보기: [Question that encourages thinking]

이 질문을 통해 [What they'll learn]을 이해할 수 있습니다.
```

**Example**:
```
💭 생각해보기: setState()를 호출하지 않고 _counter를 변경하면 
화면이 업데이트되지 않는 이유는 무엇일까요?

이 질문을 통해 Flutter의 상태 관리 메커니즘을 더 깊이 이해할 수 있습니다.
```

---

### 2. Generate Example Code
**Purpose**: Provide practical code examples with Korean comments

**Input**:
- Concept or pattern to demonstrate
- Current code context (if applicable)
- Learning stage

**Output**:
- Code example with Korean comments
- Explanation of key points

**Template**:
```
📝 예시 코드:
```dart
// [Korean comment explaining the concept]
[Code example]

// [Korean comment explaining key points]
[Additional code if needed]
```

💡 핵심 포인트:
- [Key point 1]
- [Key point 2]
```

**Example**:
```
📝 예시 코드:
```dart
// StatefulWidget 예시: 상태가 변경될 수 있는 위젯
class CounterPage extends StatefulWidget {
  @override
  State<CounterPage> createState() => _CounterPageState();
}

// State 클래스: 실제 상태를 관리하는 클래스
class _CounterPageState extends State<CounterPage> {
  int _counter = 0;  // 상태 변수
  
  void _incrementCounter() {
    setState(() {  // 상태 변경 후 UI 업데이트
      _counter++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('$_counter'),  // 상태 값 표시
      ),
    );
  }
}
```

💡 핵심 포인트:
- setState() 안에서만 상태를 변경해야 UI가 업데이트됩니다
- StatefulWidget은 State 클래스와 함께 사용됩니다
```

---

### 3. Reference Learning Material
**Purpose**: Point learners to relevant learning materials

**Input**:
- Topic or concept
- Current learning stage

**Output**:
- Reference to specific learning material
- Section or page reference if applicable

**Template**:
```
📚 관련 학습 자료:
- `mockdowns/[folder]/학습_가이드.md`의 "[Section]" 섹션
- `mockdowns/[folder]/실습_문제.md`의 "[Problem]" 문제

💡 추천 학습 순서:
1. [Step 1]
2. [Step 2]
```

**Example**:
```
📚 관련 학습 자료:
- `mockdowns/01_프로젝트_셋업/학습_가이드.md`의 "프로젝트 구조 이해하기" 섹션
- `mockdowns/FLUTTER_기초_설명.md`의 "StatelessWidget vs StatefulWidget" 섹션

💡 추천 학습 순서:
1. 학습_가이드.md에서 개념 이해
2. 실습_문제.md에서 직접 코드 작성
3. 막히면 해결_가이드.md 참고
```

---

### 4. Analyze Learning Stage
**Purpose**: Determine which learning stage the learner is in

**Input**:
- Current question
- Files being worked on
- Code context

**Output**:
- Learning stage (01_프로젝트_셋업, 02_Flutter_기초, etc.)
- Relevant learning materials to check

**Logic**:
1. Check current directory or file path
2. Match with mockdowns folder structure
3. Identify relevant learning materials
4. Check if they've completed prerequisites

**Example**:
```
현재 학습 단계: 01_프로젝트_셋업
관련 자료: 
- mockdowns/01_프로젝트_셋업/학습_가이드.md
- mockdowns/01_프로젝트_셋업/실습_문제.md
```

---

### 5. Generate Step-by-Step Guide
**Purpose**: Break down complex tasks into manageable steps

**Input**:
- Task or goal
- Current knowledge level
- Learning stage

**Output**:
- Numbered steps
- Code examples for each step
- Verification steps

**Template**:
```
📋 단계별 가이드:

**1단계: [Step name]**
[Description]
```dart
[Code example]
```

**2단계: [Step name]**
[Description]
```dart
[Code example]
```

✅ 확인 사항:
- [ ] [Checkpoint 1]
- [ ] [Checkpoint 2]
```

**Example**:
```
📋 단계별 가이드:

**1단계: StatefulWidget 클래스 생성**
StatefulWidget을 상속받는 클래스를 만듭니다.
```dart
class MyCounter extends StatefulWidget {
  @override
  State<MyCounter> createState() => _MyCounterState();
}
```

**2단계: State 클래스 생성**
State 클래스를 만들고 상태 변수를 선언합니다.
```dart
class _MyCounterState extends State<MyCounter> {
  int _count = 0;  // 상태 변수
}
```

**3단계: setState()로 상태 변경**
상태를 변경하는 메서드를 만듭니다.
```dart
void _increment() {
  setState(() {
    _count++;
  });
}
```

✅ 확인 사항:
- [ ] StatefulWidget과 State 클래스가 올바르게 연결되었나요?
- [ ] setState() 안에서 상태를 변경하고 있나요?
```

---

### 6. Create Comparison Table
**Purpose**: Help learners understand differences between concepts

**Input**:
- Two or more concepts to compare
- Key comparison points

**Output**:
- Comparison table
- Examples for each

**Template**:
```
📊 비교표:

| 항목 | [Concept 1] | [Concept 2] |
|------|------------|------------|
| [Point 1] | [Value 1] | [Value 2] |
| [Point 2] | [Value 1] | [Value 2] |

💡 언제 사용하나요?
- [Concept 1]: [When to use]
- [Concept 2]: [When to use]
```

**Example**:
```
📊 비교표:

| 항목 | StatelessWidget | StatefulWidget |
|------|----------------|----------------|
| 상태 변경 | 불가능 | 가능 |
| build() 재실행 | 위젯 재생성 시 | setState() 호출 시 |
| 사용 예시 | 앱 설정, 테마 | 카운터, 사용자 입력 |
| 성능 | 빠름 | 상대적으로 느림 |

💡 언제 사용하나요?
- StatelessWidget: 한 번 생성되면 변경되지 않는 UI (앱바, 아이콘 등)
- StatefulWidget: 사용자 상호작용으로 값이 변하는 UI (버튼 클릭, 입력 등)
```

---

### 7. Error Analysis and Guidance
**Purpose**: Help learners understand and fix errors

**Input**:
- Error message
- Code context
- Learning stage

**Output**:
- Error explanation
- Common causes
- Step-by-step fix
- Prevention tips

**Template**:
```
🔍 에러 분석:

**에러 메시지**: [Error message]

**원인**: [Root cause explanation]

**해결 방법**:
1. [Step 1]
2. [Step 2]

```dart
// ❌ 잘못된 코드
[Wrong code]

// ✅ 올바른 코드
[Correct code]
```

💡 예방 팁:
- [Tip 1]
- [Tip 2]
```

**Example**:
```
🔍 에러 분석:

**에러 메시지**: "setState() called after dispose()"

**원인**: 위젯이 이미 dispose된 후에 setState()를 호출하려고 할 때 발생합니다.
보통 비동기 작업(API 호출 등) 후에 발생합니다.

**해결 방법**:
1. mounted 체크 추가
2. 비동기 작업 취소 처리

```dart
// ❌ 잘못된 코드
Future<void> fetchData() async {
  final data = await http.get(...);
  setState(() {  // 위젯이 dispose된 후 호출될 수 있음
    _data = data;
  });
}

// ✅ 올바른 코드
Future<void> fetchData() async {
  final data = await http.get(...);
  if (mounted) {  // 위젯이 아직 마운트되어 있는지 확인
    setState(() {
      _data = data;
    });
  }
}
```

💡 예방 팁:
- 비동기 작업 후 setState() 호출 전에 항상 mounted 체크
- dispose()에서 비동기 작업 취소 처리
```

---

## Usage Guidelines

### When to Use Each Skill

1. **Generate Follow-up Question**: Always use after answering a question
2. **Generate Example Code**: When explaining concepts or showing how to implement
3. **Reference Learning Material**: When pointing to specific learning resources
4. **Analyze Learning Stage**: At the beginning of each interaction
5. **Generate Step-by-Step Guide**: For complex tasks or "how to" questions
6. **Create Comparison Table**: When comparing two or more concepts
7. **Error Analysis and Guidance**: When learner encounters an error

### Quality Standards

- All code examples must have Korean comments
- Questions should encourage thinking, not just test knowledge
- References must point to actual learning materials
- Steps should be clear and actionable
- Comparisons should highlight key differences

---

## Integration with MCP Tools

### Context7 Integration
- Use `mcp_Context7_resolve-library-id` to find Flutter package documentation
- Use `mcp_Context7_query-docs` for specific Flutter API questions
- Example: Query "How to use StatefulWidget in Flutter"

### Notion Integration (if applicable)
- Use `mcp_Notion_notion-search` to search learning materials
- Use `mcp_Notion_notion-fetch` to get specific learning guide content

### Codebase Search
- Use `codebase_search` to find examples in current project
- Use `grep` to find specific patterns in code

---

## Template Consistency

All outputs should follow these principles:
1. **Korean for user-facing content**: All explanations, comments, and questions in Korean
2. **English for internal processing**: Agent logic and internal notes in English
3. **Consistent formatting**: Use templates for similar question types
4. **Appropriate icons**: Use icons sparingly for readability (📖, 💭, 📝, 📚, etc.)
5. **Fact-based**: Always reference learning materials or official documentation

---

## Example Workflow

### Scenario: Learner asks "What is setState()?"

1. **Analyze Learning Stage**: Check if they're in 02_Flutter_기초 stage
2. **Reference Learning Material**: Check `mockdowns/FLUTTER_기초_설명.md`
3. **Generate Explanation**: Use concept explanation template
4. **Generate Example Code**: Use example code template with Korean comments
5. **Generate Follow-up Question**: Ask "Why do we need setState() instead of just changing the variable?"
6. **Reference Learning Material**: Point to relevant section

**Output**:
```
[Agent: Flutter 학습 보조 Agent]

📖 개념 설명:
setState()는 StatefulWidget에서 상태를 변경하고 UI를 업데이트하는 함수입니다.
변수를 직접 변경하는 것만으로는 화면이 업데이트되지 않기 때문에 
setState()를 사용하여 Flutter에게 "상태가 변경되었으니 화면을 다시 그려라"고 알려줍니다.

💭 생각해보기:
왜 변수를 직접 변경하는 것만으로는 화면이 업데이트되지 않을까요?
Flutter가 어떻게 변경사항을 감지하는지 생각해보세요.

📝 예시 코드:
```dart
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;  // 상태 변수
  
  void _incrementCounter() {
    setState(() {  // setState() 안에서 상태 변경
      _counter++;  // 이렇게 하면 화면이 자동으로 업데이트됨
    });
  }
  
  // ❌ 이렇게 하면 화면이 업데이트되지 않음
  void _wrongIncrement() {
    _counter++;  // setState() 없이 변경
    // 화면은 여전히 이전 값을 표시함
  }
}
```

📚 관련 학습 자료:
- `mockdowns/FLUTTER_기초_설명.md`의 "상태 관리의 핵심: setState()" 섹션
- `mockdowns/02_Flutter_기초/학습_가이드.md` (다음 단계)
```
