# MCP 통합 가이드 (2026 최신 버전)

## 개요

이 프로젝트의 Flutter 학습 보조 Agent는 MCP (Model Context Protocol)를 활용하여 최신 Flutter 문서와 정보를 제공합니다.

## 활성화된 MCP 도구

### 1. Context7 - Flutter 공식 문서
- **Library ID**: `/llmstxt/flutter_dev_llms_txt`
- **용도**: Flutter 공식 문서 조회, 코드 예시 확인
- **특징**: 
  - 1990개의 코드 스니펫
  - High 신뢰도
  - Benchmark Score: 78.6

**사용 예시:**
- Flutter 위젯 사용법 확인
- 공식 문서 기반 코드 예시 제공
- 최신 Flutter 패턴 확인

### 2. Notion (선택적)
- **용도**: 학습 자료가 Notion에 저장된 경우 검색
- **현재 상태**: 학습 자료는 `mockdowns/` 폴더에 있음

### 3. Codebase Search
- **용도**: 프로젝트 내 코드 예시 찾기
- **사용**: `codebase_search` 도구 활용

### 4. Browser Tools (선택적)
- **용도**: Flutter 공식 웹사이트 확인
- **사용**: 필요시 공식 문서 직접 확인

## Agent 자동 호출

### 자동 제안 조건
다음 상황에서 `studyAgent`가 자동으로 제안됩니다:
- Flutter 관련 질문
- 학습 관련 질문
- 코드 이해 질문
- `mockdowns/` 폴더 관련 질문

### 수동 호출
채팅창에서 `@studyAgent`를 입력하여 직접 호출할 수 있습니다.

## 사용 방법

1. **질문하기**: Flutter 학습 관련 질문을 입력
2. **Agent 자동 제안**: Cursor가 `studyAgent` 사용을 제안
3. **MCP 자동 활용**: Agent가 필요한 정보를 MCP를 통해 자동으로 조회
4. **답변 받기**: 검증된 정보와 예시 코드를 받음

## 주의사항

- Agent는 항상 MCP를 통해 정보를 검증합니다
- Flutter 공식 문서를 우선 참조합니다
- 학습 자료(`mockdowns/`)와 공식 문서를 함께 활용합니다
