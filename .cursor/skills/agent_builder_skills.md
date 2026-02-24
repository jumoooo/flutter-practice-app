# 🛠️ Agent Builder Skills

## Language Separation (언어 구분)
**Internal Processing (Agent reads)**: All instructions, logic, and internal operations are in English.
**User-Facing Content (User sees)**: All explanations, questions, prompts, and responses shown to users are in Korean.

## Overview
This skill provides core functions for the Agent Builder agent. It includes functions for structured information collection, conflict detection, template generation, and agent creation.

**한글 설명 (사용자용)**: 이 스킬은 Agent Builder가 사용하는 핵심 기능들을 제공합니다. 구조화된 정보 수집, 충돌 탐지, 템플릿 생성, Agent 생성 등의 기능을 포함합니다.

---

## Skills

### 1. Collect Required Information with Multiple-Choice
**Purpose**: Guide users through structured information collection using multiple-choice questions

**Input**: 
- User's initial request (may be vague)
- Context about what agent they want to create

**Output**: 
- Structured information collection prompts in Korean
- Multiple-choice questions for key decisions
- Summary of collected information

**Template**:
```
[Agent: Agent Builder]

📋 Agent 생성 정보 수집

{Agent purpose}를 위한 Agent를 생성하기 위해 다음 정보가 필요합니다:

1. Agent 이름을 정해주세요:
   - 예시: {example1}, {example2}, {example3}
   - 입력: [사용자 입력 대기]

2. Agent의 주요 목적을 선택해주세요:
   A) {option A}
   B) {option B}
   C) {option C}
   D) {option D}
   E) 모두 포함
   F) 기타 (직접 입력)

[... more questions ...]

위 정보를 입력해주시면 계속 진행하겠습니다.
```

**Example**:
```
[Agent: Agent Builder]

📋 Agent 생성 정보 수집

코드 리뷰 Agent를 생성하기 위해 다음 정보가 필요합니다:

1. Agent 이름을 정해주세요:
   - 예시: codeReviewer, reviewAgent, codeInspector
   - 입력: [사용자 입력 대기]

2. Agent의 주요 목적을 선택해주세요:
   A) 코드 품질 검사 및 개선 제안
   B) 보안 취약점 탐지
   C) 성능 최적화 제안
   D) 스타일 가이드 준수 확인
   E) 모두 포함
   F) 기타 (직접 입력)
```

---

### 2. Analyze Existing Agents and Skills
**Purpose**: Check existing agents, skills, and rules for reuse opportunities and conflicts

**Input**:
- Target agent name
- Agent purpose and functionality

**Output**:
- List of existing agents with similar functionality
- List of reusable skills
- List of existing rules
- Conflict detection results
- Reuse recommendations

**Process**:
1. List all files in `.cursor/agents/` directory
2. List all files in `.cursor/skills/` directory
3. List all files in `.cursor/rules/` directory
4. Read relevant files to understand functionality
5. Compare with new agent requirements
6. Identify conflicts or overlaps
7. Recommend reuse or new creation

**Template**:
```
기존 Agent 분석 중...
- {existingAgent1}.md 발견 ({description}, 충돌 {없음/있음})
- {existingAgent2}.md 발견 ({description}, 충돌 {없음/있음})

기존 Skills 분석 중...
- {existingSkill1}.md 발견 (재사용 {가능/불가능})
- {existingSkill2}.md 발견 (재사용 {가능/불가능})

기존 Rules 분석 중...
- {existingRule1}.mdc 발견 (관련 {있음/없음})

충돌 검사 결과:
- [ ] 이름 충돌: {없음/있음 - 상세 설명}
- [ ] 기능 중복: {없음/있음 - 상세 설명}
- [ ] 규칙 충돌: {없음/있음 - 상세 설명}

재사용 권장사항:
- {recommendation}
```

---

### 3. Detect Conflicts and Contradictions
**Purpose**: Check for naming conflicts, functional overlaps, and contradictions before and during agent creation

**Input**:
- New agent name
- New agent functionality
- Existing agents list
- Existing rules list

**Output**:
- Conflict detection report
- Stop signal if conflict found
- User notification in Korean

**Conflict Types**:
1. **Naming Conflict**: Same agent name exists
2. **Functional Overlap**: Similar functionality in existing agent
3. **Rule Contradiction**: Conflicting rules
4. **Skill Duplication**: Unnecessary skill duplication

**Template (No Conflict)**:
```
✅ 충돌 검사 완료

- 이름 충돌: 없음
- 기능 중복: 없음
- 규칙 충돌: 없음
- Skills 중복: 없음

계속 진행 가능합니다.
```

**Template (Conflict Detected)**:
```
⚠️ 충돌 감지!

다음 충돌이 발견되었습니다:

1. 이름 충돌:
   - {agentName}이라는 이름의 Agent가 이미 존재합니다.
   - 기존 파일: .cursor/agents/{existingAgent}.md

2. 기능 중복:
   - {newAgent}의 기능이 {existingAgent}와 유사합니다.
   - 중복 기능: {overlapping features}

작업을 중단합니다. 다음 중 선택해주세요:
A) Agent 이름 변경
B) 기존 Agent 수정
C) 기능 범위 조정
D) 취소
```

---

### 4. Generate Agent File from Template
**Purpose**: Create agent file using proven template structure

**Input**:
- Collected information (name, persona, tasks, etc.)
- Template structure
- MCP integration requirements

**Output**:
- Complete agent file with all required sections
- Proper language separation
- MCP integration sections
- Examples and templates

**Template Structure**:
```markdown
---
name: {agentName}
model: fast
description: {brief description}
---

# {Agent Title}

## Language Separation (언어 구분 - 중요!)
[Language separation explanation]

## Role (역할)
[English role]

**한글 설명 (사용자용)**: [Korean role]

## Goals (목표)
[English goals]

**한글 설명 (사용자용)**:
[Korean goals]

## Persona
[English persona]

## Core Principles
[English principles]

## Workflow (Internal Processing - English)
[English workflow]

## MCP Tools Usage Strategy
[English MCP strategy]

## Response Template
[Korean templates]

## Important Notes (Internal Processing - English)
[English notes]

## Skills to Use
[Skills references]

## Quality Checklist
[Checklist]
```

---

### 5. Generate Skills File from Template
**Purpose**: Create separated skills file when beneficial for maintainability

**Input**:
- Agent functionality
- Required skills list
- Template structure

**Output**:
- Complete skills file
- All skill definitions
- Examples and templates

**Template Structure**:
```markdown
# {Skill Name} Skills

## Language Separation
[Language separation]

## Overview
[English overview]

**한글 설명 (사용자용)**: [Korean overview]

## Skills

### 1. {Skill Name}
**Purpose**: [English]

**Input**: 
- [parameters]

**Output**: 
- [description]

**Template**:
[Korean template]

**Example**:
[Korean example]
```

---

### 6. Generate Rules File from Template
**Purpose**: Create rules file following Cursor standards (2026-02-24)

**Input**:
- Agent name
- Rule type (alwaysApply, globs, etc.)
- Rule content

**Output**:
- Complete `.mdc` rules file
- Proper frontmatter
- MDC link references

**Template Structure**:
```markdown
---
alwaysApply: true  # or false
description: "{Rule description}"
globs: "*.dart,*.md"  # optional
---

# {Rule Title}

[Rule content in Korean]

Agent 파일 참조: [agentName.md](mdc:.cursor/agents/agentName.md)
Skills 파일 참조: [skillName.md](mdc:.cursor/skills/skillName.md)
```

---

### 7. Verify Cursor Standards Compliance
**Purpose**: Ensure created agent follows Cursor's official standards (2026-02-24)

**Input**:
- Created agent file
- Created skills file (if any)
- Created rules file (if any)

**Output**:
- Compliance checklist results
- Issues found (if any)
- Recommendations

**Checklist**:
- [ ] Uses `.cursor/rules/*.mdc` format (not `.cursorrules`)
- [ ] Agent file has proper frontmatter
- [ ] Skills separated when beneficial
- [ ] MDC links used correctly: `[filename](mdc:path)`
- [ ] Language separation maintained
- [ ] MCP integration documented
- [ ] All required sections present
- [ ] Templates used correctly

---

### 8. Create Implementation Plan
**Purpose**: Generate detailed plan before implementation for user confirmation

**Input**:
- Collected information
- Analysis results
- Conflict check results

**Output**:
- Detailed implementation plan in Korean
- Files to create/modify list
- Reuse recommendations
- MCP integration strategy

**Template**:
```
[Agent: Agent Builder]

📋 생성 계획

수집된 정보:
1. Agent 이름: {name}
2. Agent 목적: {purpose}
3. 페르소나: {persona}
4. 주요 작업: {tasks}
5. MCP 도구: {mcpTools}
6. Skills 분리: {skillsSeparation}
7. Rules 필요: {rulesNeeded}

기존 코드 분석 결과:
- 기존 Agent: {existingAgents}
- 재사용 가능 Skills: {reusableSkills}
- 충돌 검사: {conflictStatus}

생성 계획:
1. .cursor/agents/{agentName}.md 생성
2. .cursor/skills/{skillName}.md 생성 (필요시)
3. .cursor/rules/{ruleName}.mdc 생성 (필요시)

MCP 통합 전략:
- {mcpStrategy}

위 계획이 맞나요? "진행" 또는 "계속"이라고 답변해주시면 생성하겠습니다.
```

---

## Usage Guidelines

### When to Use Each Skill

1. **Collect Required Information**: Always use at the start when user requests agent creation
2. **Analyze Existing Agents**: Use before creating plan to identify reuse opportunities
3. **Detect Conflicts**: Use before and during creation to prevent issues
4. **Generate Agent File**: Use after user confirmation to create agent
5. **Generate Skills File**: Use when skills separation is beneficial
6. **Generate Rules File**: Use when rules are needed
7. **Verify Standards Compliance**: Use after creation to ensure quality
8. **Create Implementation Plan**: Use before implementation for user confirmation

### Quality Standards

- All information collection must use multiple-choice when possible
- Never proceed without user confirmation
- Always check for conflicts before creating
- Always use templates for consistency
- Always verify standards compliance
- Always provide Korean explanations for users

---

## Integration with MCP Tools

### Codebase Search
- Use `codebase_search` to find existing agent patterns
- Use `grep` to find specific patterns in agent files
- Use `list_dir` to explore directory structure

### Context7 (if needed)
- Use for Cursor documentation queries
- Verify latest standards and best practices

---

## Example Workflow

### Scenario: User requests "코드 리뷰 Agent 만들어줘"

1. **Collect Information** (Skill 1)
   - Ask multiple-choice questions
   - Collect all required information

2. **Analyze Existing** (Skill 2)
   - Check existing agents
   - Check existing skills
   - Check existing rules

3. **Detect Conflicts** (Skill 3)
   - Check naming conflicts
   - Check functional overlaps
   - Report if conflicts found

4. **Create Plan** (Skill 8)
   - Generate detailed plan
   - Present to user
   - Wait for confirmation

5. **After Confirmation**:
   - Generate Agent File (Skill 4)
   - Generate Skills File (Skill 5) - if separated
   - Generate Rules File (Skill 6) - if needed

6. **Verify Compliance** (Skill 7)
   - Check standards compliance
   - Ensure quality

7. **Complete**
   - Report completion
   - Provide usage instructions
