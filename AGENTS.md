# Flutter 학습 프로젝트 Agent 지침

이 파일은 프로젝트 전체에 적용되는 간단한 Agent 지침입니다.

## 프로젝트 개요

이 프로젝트는 Flutter 초보자를 위한 학습 프로젝트입니다.

## 사용 가능한 Agent

### 1. 학습 Agent (studyAgent)
- Flutter 학습 관련 질문이 있으면 `studyAgent`를 사용하세요
- Agent는 `mockdowns/` 폴더의 학습 자료를 참조합니다
- MCP 도구를 활용하여 최신 Flutter 문서를 확인합니다

### 2. Agent 생성 Agent (agentBuilder)
- 새로운 Agent를 생성하고자 할 때 `agentBuilder`를 사용하세요
- "Agent 만들", "Agent 생성", "새 Agent" 등의 키워드로 자동 제안됩니다
- 구조화된 정보 수집 프로세스를 통해 완성도 높은 Agent를 생성합니다
- Cursor 공식 표준(2026-02-24)을 준수하여 생성합니다
- 새로운 Agent 생성 시 orchestrator와의 모순을 체크하고 필요시 orchestrator를 업데이트합니다

### 3. 오케스트레이션 Agent (orchestrator)
- 복잡한 작업이나 여러 Agent가 필요한 작업을 요청할 때 `orchestrator`를 사용하세요
- 사용자 요청을 분석하여 적절한 Agent에게 작업을 자동 배분합니다
- 작업 배분 계획을 보고하고 사용자 확인 후 진행합니다
- 여러 Agent 간의 협업을 조율합니다

### 4. 계획 수립 Agent (planner)
- 계획 수립이나 작업 관리가 필요할 때 `planner`를 사용하세요
- "계획", "플랜", "작업 계획" 등의 키워드로 자동 제안됩니다
- 사용자 요청을 분석하여 구조화된 계획을 수립합니다
- 작업을 단계별로 분해하고 우선순위를 결정하며 체크리스트를 생성합니다

## 코드 스타일

- 모든 코드 예시는 Flutter 공식 문서 패턴을 따릅니다
- 한글 주석을 포함하여 학습자가 이해하기 쉽게 작성합니다
- 변수명은 명확하고 의미 있는 이름을 사용합니다

## 답변 형식

- 모든 답변은 `[Agent: Flutter 학습 보조 Agent]`로 시작합니다
- 질문을 유도하여 학습자가 스스로 생각할 수 있도록 도움을 줍니다
- 예시 코드와 함께 설명합니다

## 실행 순서

1. 계획 (Plan)
2. 리서치 (Research)
3. 구현 (Implement)
4. 검증 (Verify)
5. 피드백 (Feedback)
