# Skills 디렉토리

## 주의사항

**Skills는 Cursor 공식 문서에서 직접 정의하지 않지만**, 에코시스템 표준으로 확장 가능한 기능입니다.

- Agent Skills는 일반적인 Agent 확장 패키지입니다
- 외부에서 정의된 도메인 지식/커맨드/워크플로우 확장 패키지입니다
- Cursor는 Agent Skills 표준을 지원합니다 (에코시스템 문서 기준)

## 현재 Skills

### `learning_helper.md`
- Flutter 학습 보조 Agent가 사용하는 핵심 기능들
- 질문 생성, 예시 코드 생성, 학습 자료 참조 등의 기능 제공
- Agent가 내부적으로 참조하는 스킬 파일

## 사용 방법

Agent 파일에서 Skills를 참조할 수 있습니다:
- [studyAgent.md](../agents/studyAgent.md)에서 `learning_helper.md`를 참조

## 참고

- **공식 규칙**: `.cursor/rules/*.mdc` 파일 사용
- **공식 Agent 지침**: `AGENTS.md` 파일 사용
- **Skills**: 에코시스템 확장 기능 (참고용)
