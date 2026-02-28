# 🧠 AGENT_NOTES - Agent 운용 메모 / 방향 / 교훈 모음

> 이 파일은 Agent 시스템 전반에 대한 **메모장 역할**을 합니다.  
> 방향, 실수 기록, 현재 운용 규칙, 참고할 docs 링크 등을 간단히 적어두고,  
> 세부 내용은 각 Agent / Rules / Docs 파일로 링크해두는 것을 목표로 합니다.

---

## 1. 전체 방향 (Direction)

- Deep Discovery Agent (`deepDiscoveryAgent`)를 **공통 컨텍스트 레이어**로 사용한다.
  - 새 프로젝트/브랜치/대규모 작업 전에는 baseline/standard 또는 baseline/deep으로 한 번 깊게 분석
  - 단순/국소 코드 수정에는 불필요하게 전체 Deep Discovery를 돌리지 않는다.
- `.cursor/docs` 디렉터리를 Agent 내부 산출물(JSON/Markdown 리포트)의 **공식 저장소**로 사용한다.
- 각 Agent는 가능하면 이미 만들어진 산출물(특히 Deep Discovery 리포트)을 먼저 읽고,  
  부족한 부분만 추가로 RAG/코드 스캔을 수행한다.

관련 파일:
- Deep Discovery 스펙: [`mockdowns/99_Deep_Discovery_Agent.md`](../..//mockdowns/99_Deep_Discovery_Agent.md)
- Deep Discovery Agent 정의: [`.cursor/agents/deepDiscoveryAgent.md`](../agents/deepDiscoveryAgent.md)

---

## 2. Docs 구조 (산출물 / 문서 정리)

- **Deep Discovery 산출물**
  - 디렉터리: `.cursor/docs/deep-discovery/`
  - JSON: `deep-discovery_{ref}_{depth}_{mode}.json`
  - Markdown: `deep-discovery_{ref}_{depth}_{mode}.md`
  - `ref` 기본 규칙:
    - 명시적인 `time_or_commit_ref`가 없을 때: `YYYYMMDD_HHMM_HEAD` 형식 사용 (예: `20260227_1530_HEAD`)
    - 브랜치/커밋 정보는 `basis_ref.time_or_commit_ref`에만 두고, 파일명은 타임스탬프 기반으로 정렬성 유지
  - 최신 리포트 선택:
    - 파일명 `ref`를 타임스탬프처럼 해석해 가장 최근 JSON을 우선 후보로 선택
    - `input_params.mode` / `input_params.depth_level`이 현재 작업과 유사한지 확인 후 사용

- **이 메모장 파일**: `.cursor/docs/AGENT_NOTES.md`
  - 역할:
    - 방향/규칙/교훈을 요약
    - 각 Agent / Rules / Docs 파일로 링크 허브 역할
    - 사람과 Agent 모두가 “현재 시스템 상태”를 빠르게 이해하는 데 사용

향후 확장 아이디어:
- 특정 Agent 전용 노트 섹션 추가 (예: studyAgent 관련 관찰, orchestrator 개선 아이디어 등)
- 중요한 회고/실수/교훈에 날짜 태그 붙이기 (예: `2026-02-27:` 형태)

---

## 3. 현재 운용 규칙 (요약)

- **Deep Discovery 사용 정책**
  - 기본 정책: **복잡/다단계 작업 (정책 B)** 에서는 가능하면 먼저 Deep Discovery를 baseline 모드로 실행
  - 단순/부분 작업:
    - planner나 다른 Agent가 국소적으로 `codebase_search` 정도만 사용
    - Deep Discovery는 필요할 때만 명시적으로 사용

- **Artifact 우선 사용**
  - planner / orchestrator / studyAgent 등은:
    1. `.cursor/docs/deep-discovery/`에 최신 리포트가 있는지 먼저 확인
    2. 있으면 그 JSON/Markdown을 1차 컨텍스트로 사용
    3. 없거나 부족하면 추가 스캔/RAG 수행

---

## 4. 실수/교훈 로그 (간단 메모용)

> 아직 구체적인 로그는 없지만, 다음과 같은 형식으로 추가하면 좋습니다.

예시 형식:

- `2026-02-27`  
  - Deep Discovery 없이 planner가 코드베이스를 여러 번 스캔 → 중복 작업 발생  
  - 교훈: 복잡한 계획 수립 전에는 baseline Deep Discovery를 먼저 돌리는 것이 효율적.

새로운 실수나 개선 포인트가 생기면 이 섹션에 간단히 추가하고,  
자세한 내용은 관련 Agent/Docs 파일에 정리한 뒤 링크를 남겨주세요.

---

## 5. 참고 링크 모음

- Agent 개요: [`AGENTS.md`](../../AGENTS.md)
- Agent Rules 디렉터리: [`.cursor/rules`](../rules/README.md)
- Skills 디렉터리: [`.cursor/skills`](../skills/README.md)
- Deep Discovery Agent:
  - 정의: [`.cursor/agents/deepDiscoveryAgent.md`](../agents/deepDiscoveryAgent.md)
  - 스펙 상세: [`mockdowns/99_Deep_Discovery_Agent.md`](../..//mockdowns/99_Deep_Discovery_Agent.md)

### Document Uploader 관련

- Agent 정의: [`.cursor/agents/documentUploader.md`](../agents/documentUploader.md)
- 업로드 결과 미니 JSON 계약:
  - 성공 시:
    - `upload_result.status = "success"`
    - `upload_result.platform = "notion"`
    - `upload_result.page_url = 생성된 페이지 URL`
    - `upload_result.source_file = 업로드한 로컬 파일 경로`
  - 실패 시(예시):
    - `upload_result.status = "error"`
    - `upload_result.error_code = "ERR_..."` 형태

