# 🚀 Flutter 학습 프로젝트

Flutter 기초부터 배포까지 체계적으로 학습한 결과물입니다.  
**Cursor Agent 시스템**을 활용하여 질문 유도형 학습 방식으로 진행했습니다.

---

## 📋 프로젝트 소개

이 프로젝트는 **7단계 체계적 커리큘럼**을 따라 Flutter를 학습하며 만든 프로젝트입니다.  
각 단계는 **학습 가이드 → 실습 문제 → 해결 가이드** 순서로 진행했으며,  
**Cursor Agent**의 안내를 받아 질문을 통해 스스로 코드를 작성하며 학습했습니다.

### 학습 방식

- ✅ **질문 유도형 학습**: Agent가 직접 코드를 작성하지 않고, 질문을 통해 스스로 학습
- ✅ **단계별 체계적 학습**: 7단계로 나누어 점진적으로 Flutter 개념 학습
- ✅ **실습 중심**: 이론보다 실습 문제를 통해 실제로 코드를 작성하며 학습
- ✅ **완전한 프로젝트**: 학습 과정에서 완성된 Flutter 앱 제작

---

## 🎓 학습한 내용

### 완료된 단계 (1-6단계)

#### 1️⃣ 프로젝트 셋업
- Flutter 개발 환경 설정
- 프로젝트 구조 이해
- Git 초기 설정 및 버전 관리
- 개발 도구 사용법

#### 2️⃣ Flutter 기초
- 위젯의 개념 (StatelessWidget, StatefulWidget)
- 기본 위젯 사용 (Text, Container, Row, Column)
- 레이아웃 위젯 (Scaffold, AppBar, ListView)
- 상태 관리 기초 (setState)
- 할 일 리스트 구현
- 반응형 레이아웃 (가로/세로 모드)

#### 3️⃣ 네비게이션 및 라우팅
- 화면 간 이동 (Navigator)
- 파라미터 전달 및 결과 받기
- Bottom Navigation Bar 구현
- Drawer 메뉴 구현
- Named Routes 설정

#### 4️⃣ API 연동
- HTTP 요청 (http 패키지)
- JSON 파싱 및 모델 변환
- 비동기 처리 (async/await, Future)
- 로딩 상태 관리
- 에러 핸들링
- Pull-to-refresh 기능

#### 5️⃣ 상태 관리 심화
- Provider 패키지 사용
- CounterProvider 구현
- UserProvider 구현 (로그인/로그아웃)
- ThemeProvider 구현 (다크/라이트 모드)
- SharedPreferences를 통한 테마 영구 저장

#### 6️⃣ 앱 배포 준비
- 앱 아이콘 설정 (flutter_launcher_icons)
- Android APK 릴리스 빌드
- Android SDK 설정 및 라이선스 동의

#### 7️⃣ GitHub 배포
- ✅ GitHub 저장소 생성 및 푸시 완료
- ✅ README 작성 완료

---

## 📁 프로젝트 구조

```
flutter-practice-app/
├── lib/
│   ├── main.dart                    # 앱 진입점, MultiProvider 설정
│   ├── models/                      # 데이터 모델
│   │   ├── post.dart               # API Post 모델
│   │   └── user.dart               # 사용자 모델
│   ├── providers/                   # 상태 관리 Provider
│   │   ├── counter_provider.dart   # 카운터 상태 관리
│   │   ├── user_providers.dart    # 사용자 인증 상태 관리
│   │   └── theme_provider.dart    # 테마 상태 관리 (SharedPreferences)
│   ├── screens/                     # 화면 위젯
│   │   ├── home_screen.dart        # 홈 화면
│   │   ├── login_screen.dart       # 로그인 화면
│   │   ├── profile_screen.dart     # 프로필 화면
│   │   ├── provider_testscreen.dart # Provider 실습 화면
│   │   ├── api_practice_screen.dart # API 연동 실습 화면
│   │   ├── counter_screen.dart     # 카운터 & Todo 화면
│   │   ├── detail_screen.dart      # 상세 화면
│   │   ├── bottom_navigation_screen.dart # Bottom Nav + Drawer
│   │   └── bottom_nav_pages.dart   # Bottom Nav 페이지들
│   └── themes/                      # 테마 설정
│       ├── light_theme.dart        # 라이트 테마
│       └── dark_theme.dart         # 다크 테마
├── mockdowns/                       # 학습 자료
│   ├── 00_학습_로드맵.md
│   ├── 01_프로젝트_셋업/
│   ├── 02_Flutter_기초/
│   ├── 03_네비게이션_라우팅/
│   ├── 04_API_연동/
│   ├── 05_상태관리_심화/
│   ├── 06_앱_배포_준비/
│   └── 07_GitHub_배포_이력서/
├── .cursor/                         # Cursor Agent 설정
│   ├── agents/                      # Agent 정의
│   ├── rules/                       # Agent 규칙
│   └── skills/                      # Agent 스킬
└── pubspec.yaml                     # 프로젝트 설정 및 의존성
```

---

## 🤖 Cursor Agent 시스템

이 프로젝트는 **Cursor IDE의 Agent 시스템**을 활용하여 학습했습니다.  
각 Agent는 특정 역할을 담당하며, 학습 과정에서 안내를 제공했습니다.

### 사용된 Agent 목록

#### 1. **studyAgent** - 학습 보조 Agent
- **역할**: Flutter 학습 관련 질문에 대한 답변 제공
- **특징**: MCP 도구(Context7, Notion) 활용, 질문 유도형 학습
- **사용 시점**: Flutter 개념 질문, 학습 가이드 참조 필요 시

#### 2. **orchestrator** - 오케스트레이션 Agent
- **역할**: 여러 Agent 간 작업 배분 및 조율
- **특징**: 복잡한 작업을 분석하여 적절한 Agent에게 배분
- **사용 시점**: 여러 Agent가 필요한 복잡한 작업

#### 3. **planner** - 계획 수립 Agent
- **역할**: 작업 계획 수립 및 우선순위 관리
- **특징**: 작업을 단계별로 분해, 체크리스트 생성
- **사용 시점**: 계획 수립, 작업 관리 필요 시

#### 4. **agentBuilder** - Agent 생성 Agent
- **역할**: 새로운 Agent 생성 및 관리
- **특징**: Cursor 공식 표준 준수, 구조화된 정보 수집
- **사용 시점**: 새로운 Agent 생성 필요 시

#### 5. **deepDiscoveryAgent** - 프로젝트 분석 Agent
- **역할**: 프로젝트 구조 및 컨텍스트 분석
- **특징**: JSON/Markdown 리포트 생성, 다른 Agent와 공유
- **사용 시점**: 프로젝트 구조 파악 필요 시

#### 6. **documentUploader** - 문서 업로드 Agent
- **역할**: 마크다운 파일을 Notion 등에 자동 업로드
- **특징**: 2단계 Fallback 전략, 데이터 보존
- **사용 시점**: 학습 자료를 외부 플랫폼에 업로드 필요 시

### Agent 설계 의도

#### 핵심 설계 원칙

1. **학습자 중심 설계**
   - Agent가 코드를 대신 작성하지 않음
   - 질문을 통해 학습자가 스스로 생각하도록 유도
   - 실습 중심 학습

2. **단계별 체계적 학습**
   - 7단계로 나누어 점진적 학습
   - 각 단계별 학습 가이드 → 실습 → 해결 가이드 순서

3. **확장 가능한 구조**
   - Agent 간 독립성 유지
   - Orchestrator를 통한 협업 가능
   - 새로운 Agent 추가 용이

4. **안정성과 일관성**
   - Cursor 공식 표준 준수
   - 템플릿과 예제 기반
   - 모순 및 충돌 검사

---

## 💻 직접 구현한 부분

이 프로젝트의 **모든 코드는 직접 작성**했습니다.  
Agent는 질문에 대한 답변과 가이드를 제공했으며, 실제 코드 작성은 스스로 수행했습니다.

### 구현한 주요 기능

#### 상태 관리
- **CounterProvider**: 카운터 증가/감소 로직 직접 구현
- **UserProvider**: 로그인/로그아웃 로직 직접 구현
- **ThemeProvider**: 다크/라이트 모드 전환 및 SharedPreferences 저장 로직 직접 구현

#### 화면 구현
- **9개 화면** 모두 직접 작성
  - HomeScreen, LoginScreen, ProfileScreen
  - ProviderTestScreen, ApiPracticeScreen
  - CounterScreen, DetailScreen
  - BottomNavigationScreen, BottomNavPages
- UI 레이아웃 및 스타일링 직접 설계

#### 테마 시스템
- `light_theme.dart`, `dark_theme.dart` 파일 직접 작성
- Material 3 디자인 적용
- ColorScheme 기반 테마 구성

#### API 연동
- JSONPlaceholder API 연동 직접 구현
- JSON 파싱 및 모델 변환 로직 직접 작성
- 에러 핸들링 및 로딩 상태 관리 직접 구현

#### 네비게이션 구조
- Named Routes 설정 직접 구성
- Bottom Navigation + Drawer 구조 직접 설계

---

## 🛠️ 기술 스택

### 프레임워크 & 언어
- **Flutter**: ^3.0.0
- **Dart**: >=3.0.0 <4.0.0

### 주요 패키지
- **provider**: ^6.1.1 - 상태 관리
- **shared_preferences**: ^2.2.2 - 로컬 데이터 저장
- **http**: ^1.1.0 - HTTP 요청

### 개발 도구
- **flutter_launcher_icons**: ^0.13.1 - 앱 아이콘 생성
- **Cursor IDE** - Agent 기반 개발 환경

---

## 🚀 실행 방법

### 필수 요구사항

- Flutter SDK 설치
- Dart SDK (Flutter와 함께 설치됨)
- Android Studio 또는 VS Code
- Android/iOS 에뮬레이터 또는 실제 기기

### 설치 및 실행

```bash
# 1. 저장소 클론
git clone https://github.com/jumoooo/flutter-practice-app.git
cd flutter-practice-app

# 2. 의존성 설치
flutter pub get

# 3. 앱 실행
flutter run
```

### 주요 기능

#### Provider 테스트
1. 앱 실행 후 Drawer 메뉴 열기
2. "Provider 실습" 선택
3. 증가/감소 버튼으로 카운터 테스트

#### 사용자 로그인
1. 홈 화면에서 "로그인 화면으로 이동" 클릭
2. 이름과 이메일 입력
3. 로그인 후 프로필 화면에서 확인

#### 테마 전환
1. Drawer 메뉴 열기
2. "다크 모드" 또는 "라이트 모드" 선택
3. 테마가 즉시 변경되며 앱 재시작 시에도 유지됨

#### API 연동 테스트
1. Drawer 메뉴에서 "API 연동 실습" 선택
2. JSONPlaceholder API에서 데이터 로드 확인
3. 아래로 당겨서 새로고침 테스트

---

## ✅ 완료 현황

### 구현 완료된 기능

#### 상태 관리
- ✅ CounterProvider (증가/감소)
- ✅ UserProvider (로그인/로그아웃)
- ✅ ThemeProvider (다크/라이트 모드, SharedPreferences 저장)

#### 화면 구현
- ✅ 홈 화면 (사용자 정보 표시)
- ✅ 로그인 화면 (폼 검증 포함)
- ✅ 프로필 화면 (사용자 정보 상세)
- ✅ Provider 테스트 화면
- ✅ API 연동 실습 화면
- ✅ 카운터 & Todo 화면
- ✅ Bottom Navigation + Drawer

#### 기능 구현
- ✅ HTTP API 연동 (JSONPlaceholder)
- ✅ JSON 파싱 및 모델 변환
- ✅ 로딩 상태 관리
- ✅ 에러 핸들링
- ✅ Pull-to-refresh
- ✅ 테마 전환 및 영구 저장
- ✅ Named Routes 네비게이션

#### 배포 준비
- ✅ 앱 아이콘 설정
- ✅ Android APK 릴리스 빌드
- ✅ GitHub 저장소 생성 및 푸시
- ✅ README 작성 완료
- ✅ 웹 배포 (GitHub Pages)

---

## 🌐 웹 데모

프로젝트를 웹에서 직접 확인할 수 있습니다:

🔗 **[웹 앱 보기](https://jumoooo.github.io/flutter-practice-app/)**

> **참고**: GitHub Pages 설정이 완료되면 위 링크가 활성화됩니다.  
> GitHub Actions가 자동으로 웹 빌드 및 배포를 수행합니다.

---

## 📚 참고 자료

프로젝트의 `mockdowns/` 폴더에는 학습 과정에서 참고했던 자료들이 포함되어 있습니다.  
이 자료들을 바탕으로 단계별로 학습하며 프로젝트를 진행했습니다.

---

## 🎯 학습 성과

이 프로젝트를 통해 다음을 학습하고 구현했습니다:

- ✅ Flutter 기본 개념 이해
- ✅ 위젯과 레이아웃 활용
- ✅ 상태 관리 패턴 학습 및 구현
- ✅ API 연동 및 비동기 처리
- ✅ 네비게이션 구조 설계
- ✅ 앱 배포 프로세스 이해 및 실행
- ✅ GitHub를 통한 프로젝트 관리

---

## 🙏 후기

이 프로젝트는 **Cursor IDE의 Agent 시스템**을 활용하여 체계적으로 학습했습니다.  
질문 유도형 학습 방식을 통해 스스로 코드를 작성하며 Flutter를 학습할 수 있었고,  
Agent의 안내를 받아도 직접 코드를 작성해야 하기 때문에 더 깊이 이해할 수 있었습니다~

---