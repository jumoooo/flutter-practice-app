# Cursor Rules 디렉토리

이 디렉토리는 Cursor의 **Project Rules** 시스템을 사용합니다 (2026 최신 표준).

## 규칙 파일 목록

### 1. `flutter-learning-agent.mdc`
- **타입**: Always (alwaysApply: true)
- **적용 범위**: 모든 Dart 및 Markdown 파일 (globs: "*.dart,*.md")
- **용도**: Flutter 학습 Agent 자동 호출 규칙
- **설명**: 학습 관련 질문 시 studyAgent를 자동으로 사용하도록 설정

### 2. `code-style.mdc`
- **타입**: Always (alwaysApply: true)
- **적용 범위**: Dart 파일 (globs: "*.dart")
- **용도**: Flutter 코드 스타일 및 모범 사례
- **설명**: 코드 작성 시 따라야 할 스타일 가이드

## 규칙 타입 설명

### Always (alwaysApply: true)
- 항상 Agent 컨텍스트에 포함됩니다
- 모든 요청에 자동으로 적용됩니다

### Auto Attached (globs 패턴)
- 특정 파일 패턴에 대응해 자동 적용됩니다
- 예: `globs: "*.dart"` → Dart 파일 작업 시 자동 적용

### Agent Requested
- AI가 필요하다고 판단하면 포함됩니다
- `description` 필드로 검색 가능

### Manual
- 명시적으로 `@ruleName` 형태로 호출합니다
- `alwaysApply: false`로 설정

## 참고

- **AGENTS.md**: 프로젝트 루트의 간단한 Agent 지침
- **.cursorrules**: 레거시 파일 (더 이상 권장되지 않음)
- **Skills**: 에코시스템 표준 (공식 문서에는 없지만 확장 가능)

## 최신 표준 (2026-02-24)

Cursor의 공식 권장 구조:
- ✅ `.cursor/rules/*.mdc` - Project Rules (현재 사용 중)
- ✅ `AGENTS.md` - 간단한 Agent 지침 (루트에 생성됨)
- ⚠️ `.cursorrules` - Legacy (지원되지만 권장 안 함)
- 📦 Skills - 에코시스템 표준 (확장 가능)
