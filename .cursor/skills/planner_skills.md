# 📋 Planner Skills

## Language Separation (언어 구분)
**Internal Processing (Agent reads)**: All instructions, logic, and internal operations are in English.
**Agent-to-Agent Communication**: All communication between agents is in English.
**Agent Output (for other agents)**: All outputs that other agents read are in English.
**User-Facing Content (User sees)**: All explanations, questions, plans, and responses shown to users are in Korean.

## Overview
This skill provides core functions for the Planner agent. It includes functions for request analysis, task breakdown, priority management, resource estimation, checklist creation, and progress tracking.

**한글 설명 (사용자용)**: 이 스킬은 Planner가 사용하는 핵심 기능들을 제공합니다. 요청 분석, 작업 분해, 우선순위 관리, 리소스 추정, 체크리스트 생성, 진행 상황 추적 등의 기능을 포함합니다.

---

## Skills

### 1. Analyze User Request
**Purpose**: Understand user request and extract planning requirements

**Input**: 
- User request text
- Context from conversation
- Current project state

**Output**: 
- Project scope and goals
- Requirements and constraints
- Success criteria
- Complexity assessment

**Process**:
1. Parse request to extract key information
2. Identify implicit requirements
3. Determine project scope
4. Assess complexity
5. Identify stakeholders and dependencies

**Template (for agents, in English)**:
```
Request Analysis:
- Scope: {scope description}
- Goals: {goals}
- Requirements: {requirements}
- Constraints: {constraints}
- Complexity: {simple/moderate/complex}
```

**Template (for users, in Korean)**:
```
**프로젝트 분석:**
- 범위: {scope description}
- 목표: {goals}
- 요구사항: {requirements}
- 제약사항: {constraints}
- 복잡도: {simple/moderate/complex}
```

---

### 2. Break Down Tasks
**Purpose**: Decompose complex tasks into manageable, actionable steps

**Input**:
- Main task or project description
- Requirements and constraints
- Current project state

**Output**:
- List of atomic tasks
- Task dependencies
- Task groupings
- Deliverables per task

**Process**:
1. Identify main components
2. Break into sub-tasks
3. Ensure each task is atomic and actionable
4. Identify dependencies
5. Group related tasks
6. Define deliverables

**Template (for agents, in English)**:
```
Task Breakdown:
1. {task_id}: {task_name}
   - Dependencies: {dependencies}
   - Deliverables: {deliverables}
   - Group: {group_name}

2. {task_id}: {task_name}
   ...
```

**Template (for users, in Korean)**:
```
**작업 분해:**
1. {task_name}
   - 의존성: {dependencies}
   - 산출물: {deliverables}
   - 그룹: {group_name}

2. {task_name}
   ...
```

---

### 3. Determine Priorities
**Purpose**: Assign priority levels to tasks based on dependencies, importance, and urgency

**Input**:
- List of tasks
- Dependencies between tasks
- Importance assessment
- Urgency assessment

**Output**:
- Priority levels for each task
- Priority rationale
- Critical path identification

**Priority Levels**:
- **Critical**: Blocking other tasks, must be done first
- **High**: Important and time-sensitive
- **Medium**: Important but not urgent
- **Low**: Can be deferred

**Process**:
1. Analyze dependencies
2. Identify blocking tasks
3. Assess importance
4. Consider urgency
5. Assign priority levels
6. Identify critical path

**Template (for agents, in English)**:
```
Priorities:
- Critical: [{task_ids}]
- High: [{task_ids}]
- Medium: [{task_ids}]
- Low: [{task_ids}]

Critical Path: {task_sequence}
```

**Template (for users, in Korean)**:
```
**우선순위:**
- 🔴 Critical: {critical tasks}
- 🟠 High: {high priority tasks}
- 🟡 Medium: {medium priority tasks}
- 🟢 Low: {low priority tasks}

**중요 경로:** {critical path}
```

---

### 4. Estimate Resources
**Purpose**: Estimate time and resources required for each task

**Input**:
- Task list
- Task complexity
- Available resources
- Historical data (if available)

**Output**:
- Time estimates per task
- Resource requirements
- Total project duration
- Resource allocation

**Process**:
1. Assess task complexity
2. Estimate time per task
3. Identify required resources (tools, agents, data)
4. Consider dependencies
5. Add buffers for uncertainty
6. Calculate total duration

**Template (for agents, in English)**:
```
Resource Estimates:
- Task {id}: {time_estimate}, Resources: {resources}
- Total Duration: {total_duration}
- Buffer: {buffer_percentage}%
```

**Template (for users, in Korean)**:
```
**리소스 추정:**
- {task_name}: {time_estimate}, 필요한 리소스: {resources}
- 총 소요 시간: {total_duration}
- 여유 시간: {buffer_percentage}%
```

---

### 5. Create Checklist
**Purpose**: Generate actionable checklist for task tracking

**Input**:
- Task list
- Priorities
- Dependencies
- Milestones

**Output**:
- Structured checklist
- Acceptance criteria
- Milestones
- Progress tracking format

**Process**:
1. Convert tasks to checklist items
2. Add acceptance criteria
3. Set milestones
4. Organize by priority or phase
5. Create tracking format

**Template (for users, in Korean)**:
```
**체크리스트:**

**Phase 1: {phase_name}**
- [ ] {task 1} - {acceptance_criteria}
- [ ] {task 2} - {acceptance_criteria}

**마일스톤:**
- {milestone_name}: {date} - {tasks_completed}
```

---

### 6. Track Progress
**Purpose**: Monitor task completion and update plan status

**Input**:
- Current checklist status
- Completed tasks
- In-progress tasks
- Blocked tasks

**Output**:
- Progress report
- Updated checklist
- Next steps
- Risk identification

**Process**:
1. Check task completion status
2. Update checklist
3. Calculate progress percentage
4. Identify blockers
5. Update priorities if needed
6. Generate progress report

**Template (for agents, in English)**:
```
Progress Status:
- Completed: {task_ids}
- In Progress: {task_ids}
- Blocked: {task_ids} (blockers: {blockers})
- Progress: {percentage}%
- Next: {next_task_id}
```

**Template (for users, in Korean)**:
```
**진행 상황:**
- ✅ 완료: {completed tasks}
- ⏳ 진행 중: {in-progress tasks}
- ⏸️ 대기 중: {blocked tasks} (블로커: {blockers})
- 📊 진행률: {percentage}%
- 📌 다음 작업: {next task}
```

---

### 7. Use Sequential Thinking for Complex Planning
**Purpose**: Apply sequential thinking tool for complex planning scenarios

**Input**:
- Complex planning problem
- Multiple interdependent factors
- Need for deep analysis

**Output**:
- Structured thought process
- Planning hypothesis
- Evaluated approaches
- Refined plan

**Process**:
1. Identify complexity requiring sequential thinking
2. Use `mcp_sequential-thinking_sequentialthinking` tool
3. Break down into thought steps
4. Consider multiple approaches
5. Evaluate trade-offs
6. Generate planning hypothesis
7. Verify and refine

**When to use**:
- Multi-phase projects
- Complex dependencies
- Multiple implementation approaches
- Risk assessment needed
- Resource optimization required

**Template**:
```
Sequential Thinking Analysis:
- Problem: {problem_description}
- Approach 1: {approach} - Pros: {pros}, Cons: {cons}
- Approach 2: {approach} - Pros: {pros}, Cons: {cons}
- Selected Approach: {selected} - Reason: {reason}
- Refined Plan: {plan_structure}
```

---

### 8. Integrate with Other Agents
**Purpose**: Collaborate with other agents when their expertise is needed

**Input**:
- Planning task requiring specialized knowledge
- Agent capabilities registry

**Output**:
- Agent consultation results
- Integrated plan
- Agent recommendations

**Process**:
1. Identify need for agent expertise
2. Consult appropriate agent (studyAgent, agentBuilder, etc.)
3. Integrate agent input into plan
4. Update plan based on agent recommendations

**Example Scenarios**:
- Planning learning path → Consult studyAgent
- Planning agent creation → Consult agentBuilder
- Planning code implementation → Consult studyAgent for Flutter patterns

**Template (for agents, in English)**:
```
Agent Consultation:
- Consulted: {agent_name}
- Input: {agent_input}
- Integrated: {how_integrated}
```

---

## Usage Guidelines

### When to Use Each Skill

1. **Analyze User Request**: Always use at the start
2. **Use Sequential Thinking**: Use for complex planning scenarios
3. **Break Down Tasks**: Use after request analysis
4. **Determine Priorities**: Use after task breakdown
5. **Estimate Resources**: Use after priorities determined
6. **Create Checklist**: Use after all planning complete
7. **Track Progress**: Use during plan execution
8. **Integrate with Other Agents**: Use when specialized knowledge needed

### Quality Standards

- Always analyze request fully before planning
- Break tasks into atomic, actionable steps
- Consider all dependencies
- Provide realistic estimates with buffers
- Create trackable checklists
- Update plans based on progress
- Use English for agent communication
- Use Korean for user-facing content

---

## Integration with MCP Tools

### Sequential Thinking
- Use `mcp_sequential-thinking_sequentialthinking` for complex planning
- Break down complex problems into thought steps
- Evaluate multiple approaches

### Context7
- Use for technology documentation
- Understand framework capabilities
- Plan technical implementations

### Codebase Search
- Use to understand current project state
- Identify existing implementations
- Plan modifications

### Browser Tools
- Use for external documentation
- Research best practices
- Verify resource availability

---

## Example Workflow

### Scenario: User requests "Flutter 앱에 로그인 기능 추가하는 계획 세워줘"

1. **Analyze Request** (Skill 1)
   - Scope: Add login feature to Flutter app
   - Goals: User authentication
   - Complexity: Moderate

2. **Use Sequential Thinking** (Skill 7) - if needed for complex analysis
   - Evaluate different authentication approaches
   - Consider security implications
   - Plan implementation phases

3. **Break Down Tasks** (Skill 2)
   - UI implementation
   - API integration
   - State management
   - Security validation

4. **Determine Priorities** (Skill 3)
   - Critical: UI, API
   - High: State management, Security

5. **Estimate Resources** (Skill 4)
   - Time per task
   - Required packages
   - Agent consultations needed

6. **Create Checklist** (Skill 5)
   - Actionable items
   - Acceptance criteria
   - Milestones

7. **Present Plan** (in Korean for users)
   - Clear structure
   - All information in Korean
   - Agent-readable version in English

8. **Track Progress** (Skill 6) - during execution
   - Monitor completion
   - Update status
   - Report to user
