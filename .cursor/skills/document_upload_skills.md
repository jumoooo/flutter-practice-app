# 📤 Document Upload Skills

## Language Separation (언어 구분)
**Internal Processing (Agent reads)**: All instructions, logic, and internal operations are in English.
**User-Facing Content (User sees)**: All explanations, reports, and templates shown to users are in Korean.

## Overview
This skill provides core functions for the document upload Agent. It includes Notion upload logic (API + Browser automation), markdown analysis, upload planning, verification, and error handling. All logic is self-contained and does not reference external Notion_Agent folder.

**한글 설명 (사용자용)**: 이 스킬은 문서 업로드 Agent가 사용하는 핵심 기능들을 제공합니다. Notion 업로드 로직, 마크다운 분석, 업로드 계획 수립, 검증, 에러 처리 등 모든 기능을 포함합니다.

---

## Skills

### 1. Markdown File Analysis

**Purpose**: Analyze markdown file and prepare for upload

**Input**: 
- File path (absolute, relative, or filename)
- Workspace root path

**Output**: 
- File content (string)
- Line count (number)
- Formatted title (string)
- Chunk strategy (object)

**Implementation**:

```javascript
// 1. Resolve file path
function resolveFilePath(inputPath, workspaceRoot) {
  // Absolute path
  if (inputPath.startsWith("/") || inputPath.match(/^[A-Za-z]:/)) {
    return inputPath;
  }
  
  // Relative path
  if (inputPath.startsWith("./") || inputPath.includes("/")) {
    return workspaceRoot + "/" + inputPath.replace(/^\.\//, "");
  }
  
  // Filename only - need to search
  return inputPath; // Use glob_file_search
}

// 2. Extract page title from markdown file (preserves emojis and icons)
function extractPageTitle(fileContent, fileName) {
  // ⚡ Priority 1: Extract title from first line (# heading) to preserve emojis/icons
  const lines = fileContent.split('\n');
  for (const line of lines) {
    // Match markdown heading (# Title or ## Title)
    const headingMatch = line.match(/^#+\s+(.+)$/);
    if (headingMatch) {
      let title = headingMatch[1].trim();
      // Preserve emojis, icons, and special characters
      // Remove only consecutive spaces, keep everything else
      title = title.replace(/\s+/g, " ").trim();
      return title;
    }
  }
  
  // ⚡ Fallback: Use filename if no heading found
  // Remove .md extension
  let pageTitle = fileName.replace(/\.md$/i, "");  // Case insensitive
  
  // Replace underscore with space
  pageTitle = pageTitle.replace(/_/g, " ");
  
  // Remove consecutive spaces and trim
  pageTitle = pageTitle.replace(/\s+/g, " ").trim();
  
  // Preserve emojis and special characters (if any in filename)
  return pageTitle;
}

// 2.1. Format page title (legacy function - kept for backward compatibility)
function formatPageTitle(fileName) {
  // Remove .md extension
  let pageTitle = fileName.replace(/\.md$/i, "");  // Case insensitive
  
  // Replace underscore with space
  pageTitle = pageTitle.replace(/_/g, " ");
  
  // Remove consecutive spaces and trim
  pageTitle = pageTitle.replace(/\s+/g, " ").trim();
  
  // Preserve emojis and special characters
  return pageTitle;
}

// 2.5. Parse Notion page ID from URL or UUID
function parseNotionPageId(input) {
  if (!input) return null;
  
  // If it's already a UUID (with or without hyphens), return as is
  if (/^[0-9a-f]{32}$/i.test(input.replace(/-/g, ""))) {
    return input.replace(/-/g, "");  // Remove hyphens for consistency
  }
  
  // If it's a URL, extract ID
  if (input.startsWith("http")) {
    try {
      const url = new URL(input);
      const pathParts = url.pathname.split("/").filter(p => p);
      
      if (pathParts.length > 0) {
        let pageId = pathParts[pathParts.length - 1];
        // Remove anchor/hash if present
        pageId = pageId.split("#")[0];
        // Remove query params if present
        pageId = pageId.split("?")[0];
        // Remove hyphens (Notion IDs can have hyphens in URL but not in API)
        pageId = pageId.replace(/-/g, "");
        
        // Validate it's a valid UUID format (32 hex chars)
        if (/^[0-9a-f]{32}$/i.test(pageId)) {
          return pageId;
        }
      }
    } catch (e) {
      // Invalid URL format
      return null;
    }
  }
  
  return null;
}

// 2.6. Calculate file size
function calculateFileSize(content) {
  const sizeInBytes = new Blob([content]).size;
  const sizeInKB = sizeInBytes / 1024;
  const sizeInMB = sizeInKB / 1024;
  
  return {
    bytes: sizeInBytes,
    kb: sizeInKB.toFixed(2),
    mb: sizeInMB.toFixed(2),
    isLarge: sizeInMB > 2  // Warn if > 2MB
  };
}

// 3. Determine chunk strategy (Only needed for browser method)
// ⚡ Note: MCP API can upload full content, so chunking not needed for API method
function determineChunkStrategy(lineCount, fileSize) {
  // If using MCP API, no chunking needed
  // This is only for browser automation fallback
  
  let chunkSize;
  if (lineCount < 500) {
    chunkSize = lineCount; // 1 chunk
  } else if (lineCount <= 2000) {
    chunkSize = 250; // 200-300 lines per chunk
  } else {
    chunkSize = 400; // 300-500 lines per chunk
  }
  
  return {
    chunkSize: chunkSize,
    estimatedChunks: Math.ceil(lineCount / chunkSize),
    maxCharsPerChunk: 2000,
    needed: false  // ⚡ MCP API doesn't need chunking
  };
}

// 5. Idempotency check (중복 페이지 생성 방지용)
// Pseudo-logic: 실제 구현은 Notion 검색/트리 조회 방식에 따라 다를 수 있음
function shouldCreateNewPageOrReuse(existingPages, targetTitle) {
  // existingPages: 이미 부모 아래에 있는 페이지 목록 (제목 정보 포함)
  // targetTitle: 새로 생성하려는 제목
  //
  // Return value 예시:
  // - "create": 새 페이지 생성
  // - "append": 기존 페이지에 내용만 추가
  // - "cancel": 아무 것도 하지 않음
  //
  const hasSameTitle = existingPages.some((page) => page.title === targetTitle);
  if (!hasSameTitle) {
    return "create";
  }
  // 실제 구현에서는 사용자에게 선택지를 보여주고, 그 응답을 이 함수의 반환값으로 사용
  return "ask-user"; // Agent 쪽에서 사용자에게 물어본 뒤 최종 결정
}

// 4. Split into chunks
function splitIntoChunks(content, lineCount, strategy) {
  const lines = content.split("\n");
  const chunks = [];
  
  for (let i = 0; i < lines.length; i += strategy.chunkSize) {
    const chunk = lines.slice(i, i + strategy.chunkSize).join("\n");
    
    // Ensure max 2000 chars per chunk
    if (chunk.length > strategy.maxCharsPerChunk) {
      const subChunks = chunk.match(/.{1,2000}/g) || [];
      chunks.push(...subChunks);
    } else {
      chunks.push(chunk);
    }
  }
  
  return chunks;
}
```

**Template (Korean for users)**:
```
📄 파일 분석 완료

- 파일명: [파일명].md
- 라인 수: [라인 수]줄
- 예상 제목: [포맷팅된 제목] (이모지/아이콘 포함)
- 청크 전략: [전략 설명] ([청크 수]개 청크)

**참고**: 제목은 마크다운 첫 줄(# 제목)에서 추출되며, 이모지와 아이콘이 그대로 유지됩니다.
```

---

### 2. Upload Plan Creation

**Purpose**: Create detailed upload plan and get user confirmation

**Input**:
- File analysis result
- Parent page ID/URL (optional)
- Custom title (optional)
- Platform (currently Notion)

**Output**:
- Upload plan (object)
- User confirmation (boolean)

**Plan Structure**:
```typescript
interface UploadPlan {
  file: {
    path: string;
    lineCount: number;
    title: string;
  };
  platform: "notion" | "notebooklm" | "other";
  parentPage?: {
    id: string;
    url: string;
    title: string;
  };
  chunkStrategy: {
    chunkSize: number;
    estimatedChunks: number;
    maxCharsPerChunk: number;
  };
  verification: {
    titleVerification: boolean;
    chunkContinuity: boolean;
    finalContent: boolean;
  };
  estimatedTime: number; // minutes
}
```

**Template (Korean for users)**:
```
📋 업로드 계획

**파일 정보**:
- 파일명: [파일명].md
- 라인 수: [라인 수]줄
- 예상 제목: [포맷팅된 제목]

**업로드 전략**:
- 플랫폼: Notion
- 부모 페이지: [부모 페이지 제목 또는 "없음"]
- 청크 전략: [전략 설명] ([청크 수]개 청크)
- 예상 소요 시간: [시간]분

**검증 계획**:
- 제목 검증: 각 단계마다
- 청크 연결성 검증: 2번째 청크부터
- 최종 내용 검증: 업로드 완료 후

위 계획이 맞나요? '진행' 또는 '계속'이라고 답변해주시면 업로드를 시작하겠습니다.
```

---

### 3. Notion Upload - API Method (Option A) - ⚡ ALWAYS TRY FIRST

**Purpose**: Upload to Notion using API (primary method - proven successful!)

**⚡ CRITICAL: This method can upload full content in one call - no browser needed!**

**Input**:
- Formatted title (string)
- Parent page ID (optional, string)
- Page content (string) - **Can include full content in API call!**

**Output**:
- Page ID (string)
- Page URL (string)
- Success status (boolean)

**Implementation**:

```javascript
// 1. Fetch parent page info (if parent specified)
// ⚡ 실제 작업 순서: URL → notion-fetch → ID 추출
async function fetchParentPageInfo(parentPageUrlOrId) {
  // parentPageUrlOrId 예시:
  // - Full URL: "https://www.notion.so/2939168184838094b94bc4ad6aab8c88"
  // - UUID: "2939168184838094b94bc4ad6aab8c88"
  // - UUID with hyphens: "29391681-8483-8094-b94b-c4ad6aab8c88"
  
  // ⚡ Parse ID (handles both URL and UUID formats)
  const pageId = parseNotionPageId(parentPageUrlOrId);
  if (!pageId) {
    throw new Error(`Invalid parent page ID/URL: ${parentPageUrlOrId}`);
  }
  
  // ⚡ Fetch page info (can use either URL or UUID)
  const result = await notion_fetch({ id: parentPageUrlOrId });
  
  // ⚡ 반환 구조 (실제 notion-fetch 응답)
  // result.id = "2939168184838094b94bc4ad6aab8c88" (UUID, 하이픈 포함 가능)
  // result.title = "기타 공유" (페이지 제목)
  // result.url = "https://www.notion.so/..." (페이지 URL)
  
  return {
    id: result.id,        // ⚡ .id 사용 (UUID 형식, 하이픈 포함 가능)
    title: result.title,  // 페이지 제목
    url: result.url       // 페이지 URL
  };
}

// 2. Create page with parent AND content using Notion MCP
// ⚡ SUCCESSFUL PATTERN: Upload everything in one API call!
// ⚡ CRITICAL: 정확한 파라미터 구조 (실제 성공한 구조)
async function createNotionPageAPI(title, parentPageId, content) {
  // ⚡ Error handling: Validate inputs
  if (!title || title.trim() === "") {
    throw new Error("Title is required");
  }
  
  if (!content) {
    content = "";  // Allow empty content
  }
  
  // ⚡ 정확한 파라미터 구조
  // parent는 최상위 레벨, pages 배열과 같은 레벨에 위치
  const createParams = {
    pages: [{
      properties: {
        title: title.trim()  // ⚡ pages[0] 안에 properties, trim whitespace
      },
      content: content  // ⚡ pages[0] 안에 content
    }]
  };
  
  // CRITICAL: parent는 최상위 레벨에 추가 (pages와 같은 레벨)
  // NOT pages[0].parent (이건 잘못된 구조!)
  // ⚡ CRITICAL: Notion MCP API는 하이픈 없는 32자 hex UUID만 받습니다
  // parentPageId는 하이픈 포함/미포함 모두 가능하지만, API 호출 전에 반드시 하이픈 제거 필요
  if (parentPageId) {
    // ⚡ Remove hyphens - 필수! (Notion API 요구사항)
    // 예: "29391681-8483-8094-b94b-c4ad6aab8c88" → "2939168184838094b94bc4ad6aab8c88"
    const cleanParentId = parentPageId.replace(/-/g, "");
    createParams.parent = { page_id: cleanParentId };
  }
  
  // ⚡ 최종 구조 예시:
  // {
  //   parent: { page_id: "..." },  // 최상위 레벨
  //   pages: [{                     // 최상위 레벨
  //     properties: { title: "..." },
  //     content: "..."
  //   }]
  // }
  
  try {
    const result = await notion_create_pages(createParams);
    
    // ⚡ Validate response
    if (!result.pages || result.pages.length === 0) {
      throw new Error("API returned empty pages array");
    }
    
    return {
      pageId: result.pages[0].id,
      pageUrl: result.pages[0].url,
      success: true
    };
  } catch (error) {
    // ⚡ Error handling with specific error codes
    if (error.message.includes("parent")) {
      // ⚡ 하이픈 제거 확인: parent 파라미터 오류 시 하이픈 제거 여부 확인
      throw new Error(`ERR_INVALID_PARENT: ${error.message} - 하이픈 제거 확인: parentPageId.replace(/-/g, "") 사용했는지 확인`);
    }
    if (error.message.includes("size") || error.message.includes("large")) {
      throw new Error(`ERR_CONTENT_TOO_LARGE: ${error.message}`);
    }
    if (error.message.includes("timeout")) {
      throw new Error(`ERR_API_TIMEOUT: ${error.message}`);
    }
    throw error;
  }
}

// 3. Complete upload workflow (SUCCESSFUL PATTERN - 실제 작업 순서)
async function uploadToNotionAPI(title, parentPageUrl, content) {
  let parentPageId = null;
  
  // ⚡ Step 1: Fetch parent page info if parent specified
  // 작업 순서: URL → notion-fetch → ID 추출
  if (parentPageUrl) {
    // parentPageUrl 예시: "https://www.notion.so/2939168184838094b94bc4ad6aab8c88"
    const parentInfo = await fetchParentPageInfo(parentPageUrl);
    // parentInfo.id = "2939168184838094b94bc4ad6aab8c88" (UUID, 하이픈 포함 가능)
    parentPageId = parentInfo.id;  // ⚡ .id 사용 (not .pageId)
  }
  
  // ⚡ Step 2: Create page with parent + content in ONE call
  // 정확한 파라미터 구조로 호출
  const result = await createNotionPageAPI(title, parentPageId, content);
  
  // ⚡ Step 3: 결과 반환
  // result.pages[0].id = 생성된 페이지 ID
  // result.pages[0].url = 생성된 페이지 URL
  return result;
}

// 2. Move page to parent (FALLBACK ONLY - not primary method)
// NOTE: This should only be used if direct parent assignment during creation failed
// Primary method should always pass parent directly in createNotionPageAPI
async function movePageToParent(pageId, parentPageId) {
  try {
    await notion_move_pages({
      page_or_database_ids: [pageId],
      new_parent: { page_id: parentPageId }
    });
    return { success: true };
  } catch (error) {
    return { 
      success: false, 
      error: error.message,
      errorCode: "ERR_API_MOVE_FAILED"
    };
  }
}

// 3. Verify page location (browser check)
async function verifyPageUnderParent(parentPageUrl, expectedTitle) {
  await browser_navigate({ url: parentPageUrl });
  await browser_wait_for({ time: 2 });
  
  const result = await browser_run_code({
    code: `async (page) => {
      return await page.evaluate((title) => {
        const treeItems = Array.from(document.querySelectorAll('[role="treeitem"]'));
        
        // Find current page (parent)
        let currentPageItem = null;
        for (const item of treeItems) {
          const isExpanded = item.getAttribute('aria-expanded') === 'true';
          const isCurrent = item.querySelector('[aria-current="page"]') !== null;
          
          if ((isExpanded || isCurrent) && item.querySelector('[role="group"]')) {
            currentPageItem = item;
            break;
          }
        }
        
        if (!currentPageItem) {
          return { success: false, error: "부모 페이지를 찾을 수 없습니다" };
        }
        
        // Check child group
        const parentGroup = currentPageItem.querySelector('[role="group"]');
        if (!parentGroup) {
          return { success: false, hasChildren: false };
        }
        
        // Check child pages
        const childItems = Array.from(parentGroup.querySelectorAll('[role="treeitem"]'));
        const hasTargetPage = childItems.some(item => 
          item.textContent.includes(title) || 
          item.textContent.includes('새 페이지') ||
          item.textContent.includes('Untitled')
        );
        
        return {
          success: hasTargetPage,
          hasTargetPage: hasTargetPage,
          childCount: childItems.length
        };
      }, title);
    }`
  });
  
  return result;
}
```

**Error Handling**:
- If API move fails → Return error code `ERR_API_MOVE_FAILED`
- If verification fails → Return error code `ERR_API_PAGE_NOT_UNDER_PARENT`
- Both trigger fallback to browser automation

---

### 4. Notion Upload - Browser Automation (Option C)

**Purpose**: Upload to Notion using browser automation (fallback or direct method)

**Input**:
- Parent page URL (string)
- Formatted title (string)
- File content (string)
- Chunks (array of strings)

**Output**:
- Page URL (string)
- Success status (boolean)

**Critical Rules**:
1. **Never use `element`/`ref` parameters in `browser_evaluate`** (causes title corruption)
2. **Always verify edit permission** before proceeding
3. **Always verify page creation** after creating sub-page
4. **Always verify title input** after entering title
5. **Always verify content area** before uploading content

**Implementation**:

#### 4.1. Parse Parent Page ID

```javascript
function parseParentPageId(input) {
  // URL format
  if (input.startsWith("http")) {
    try {
      const url = new URL(input);
      const pathParts = url.pathname.split("/").filter((p) => p);
      let pageId = pathParts[pathParts.length - 1];
      pageId = pageId.split("#")[0]; // Remove anchor
      pageId = pageId.replace(/-/g, ""); // Remove hyphens
      return pageId;
    } catch (e) {
      throw new Error(`URL 파싱 실패: ${input}`);
    }
  }
  
  // UUID format (remove hyphens)
  return input.replace(/-/g, "");
}
```

#### 4.2. Verify Edit Permission

```javascript
async function verifyEditPermission() {
  const result = await browser_evaluate(() => {
    // 1. Check contenteditable areas
    const editableAreas = document.querySelectorAll('[contenteditable="true"]');
    const hasEditPermission = editableAreas.length > 0;
    
    // 2. Check add page button
    const addPageButton = document.querySelector('[aria-label*="Add a page"]') ||
                          document.querySelector('[aria-label*="페이지 추가"]') ||
                          document.querySelector('[aria-label*="하위 페이지 추가"]');
    
    // 3. Check if shared page
    const isSharedPage = document.body.innerText.includes('공유됨') || 
                         document.body.innerText.includes('Shared');
    
    if (!hasEditPermission || !addPageButton) {
      return {
        success: false,
        error: "ERR_BROWSER_NO_EDIT_PERMISSION",
        message: "페이지 편집 권한이 없습니다",
        isSharedPage: isSharedPage
      };
    }
    
    return {
      success: true,
      hasEditPermission: true,
      isSharedPage: isSharedPage
    };
  });
  
  return result;
}
```

#### 4.3. Create Sub-Page

```javascript
async function createSubPage(parentPageTitle) {
  // Method 1: UI Button (most stable)
  const result = await browser_evaluate(() => {
    const treeItems = Array.from(document.querySelectorAll('[role="treeitem"]'));
    
    // Find parent page item
    const targetItem = treeItems.find(item => 
      item.textContent.includes(parentPageTitle) ||
      item.querySelector('[aria-current="page"]') !== null
    );
    
    if (!targetItem) {
      return { success: false, error: "부모 페이지를 찾을 수 없습니다" };
    }
    
    // Find "하위 페이지 추가" button
    const addPageButton = targetItem.querySelector('[aria-label*="하위 페이지 추가"]') ||
                          targetItem.querySelector('[aria-label*="Add a page inside"]');
    
    if (!addPageButton) {
      return { success: false, error: "하위 페이지 추가 버튼을 찾을 수 없습니다" };
    }
    
    // Click button
    addPageButton.click();
    
    return { success: true };
  });
  
  if (!result.success) {
    // Method 2: Keyboard shortcut (fallback)
    await browser_press_key({ key: "Escape" }); // Close any dialogs
    await browser_wait_for({ time: 1 });
    await browser_press_key({ key: "Control+Shift+KeyP" }); // Windows
    await browser_wait_for({ time: 2 });
  } else {
    await browser_wait_for({ time: 2 }); // Wait for page creation
  }
  
  // Verify page creation
  const verification = await verifyPageCreation();
  if (!verification.success) {
    throw new Error("ERR_PAGE_CREATION_FAILED");
  }
  
  return verification;
}

async function verifyPageCreation() {
  const result = await browser_evaluate(() => {
    // 1. Check URL changed
    const currentUrl = window.location.href;
    const isNewPage = currentUrl.includes('?p=') || currentUrl !== previousUrl;
    
    // 2. Check title area exists
    const titleElement = document.querySelector('h1[contenteditable="true"]');
    const titleText = titleElement?.innerText.trim();
    const isNewPageTitle = titleText === 'Untitled' || titleText === '새 페이지' || titleText === '';
    
    // 3. Check /page command not remaining
    const hasPageCommand = document.body.innerText.includes('/page');
    
    if (!isNewPage || !titleElement || hasPageCommand) {
      return {
        success: false,
        error: "ERR_PAGE_CREATION_FAILED",
        hasPageCommand: hasPageCommand,
        hasTitleElement: !!titleElement,
        currentUrl: currentUrl
      };
    }
    
    return { success: true, pageUrl: currentUrl };
  });
  
  return result;
}
```

#### 4.4. Input Title

```javascript
async function inputTitle(expectedTitle) {
  // Get title element ref from snapshot
  const snapshot = await browser_snapshot();
  // Find h1[contenteditable="true"] ref from snapshot
  
  // Type title
  await browser_type({
    element: "제목 영역 (h1)",
    ref: "확인한_ref", // From snapshot
    text: expectedTitle
  });
  
  await browser_wait_for({ time: 1 });
  
  // Verify title input
  const verification = await verifyTitleInput(expectedTitle);
  if (!verification.success) {
    // Fix title if corrupted
    await fixTitle(expectedTitle);
  }
}

async function verifyTitleInput(expectedTitle) {
  const result = await browser_evaluate(() => {
    const expected = expectedTitle; // Define inside function
    const titleElement = document.querySelector('h1[contenteditable="true"]');
    const actualTitle = titleElement?.innerText.trim();
    
    if (actualTitle !== expected) {
      return {
        success: false,
        error: "ERR_TITLE_MISMATCH",
        expected: expected,
        actual: actualTitle
      };
    }
    
    // Check for command in title
    if (actualTitle.includes('/page') || actualTitle.includes('Ctrl+')) {
      return {
        success: false,
        error: "ERR_TITLE_HAS_COMMAND",
        actual: actualTitle
      };
    }
    
    return { success: true, title: actualTitle };
  });
  
  return result;
}

async function fixTitle(expectedTitle) {
  await browser_evaluate(() => {
    const expected = expectedTitle; // Define inside
    const titleElement = document.querySelector('h1[contenteditable="true"]');
    
    if (!titleElement) {
      return { success: false };
    }
    
    // Focus and select all
    titleElement.focus();
    titleElement.click();
    
    const range = document.createRange();
    range.selectNodeContents(titleElement);
    const selection = window.getSelection();
    selection.removeAllRanges();
    selection.addRange(range);
    
    // Insert correct title
    document.execCommand('insertText', false, expected);
    
    return { success: true };
  });
  
  await browser_wait_for({ time: 1 });
}
```

#### 4.5. Move to Content Area

```javascript
async function moveToContentArea() {
  const result = await browser_evaluate(() => {
    // 1. Check if focused on title
    const titleElement = document.querySelector('h1[contenteditable="true"]');
    const isFocusedOnTitle = titleElement?.contains(document.activeElement);
    
    if (isFocusedOnTitle) {
      // Move to content area
      const bodyElement = document.querySelector('[contenteditable="true"]:not(h1)');
      if (bodyElement) {
        bodyElement.focus();
        bodyElement.click();
      } else {
        return { success: false, error: "내용 영역을 찾을 수 없습니다" };
      }
    }
    
    // 2. Verify content area
    const contentArea = document.querySelector('[contenteditable="true"]:not(h1)');
    if (!contentArea) {
      return { success: false, error: "내용 영역을 찾을 수 없습니다" };
    }
    
    // 3. Move to bottom
    contentArea.focus();
    const range = document.createRange();
    range.selectNodeContents(contentArea);
    range.collapse(false); // To end
    
    const selection = window.getSelection();
    selection.removeAllRanges();
    selection.addRange(range);
    
    return { success: true, message: "내용 영역으로 이동 완료" };
  });
  
  if (!result.success) {
    throw new Error("내용 영역 이동 실패");
  }
}
```

#### 4.6. Upload Chunks with Verification

```javascript
async function uploadChunks(chunks, expectedTitle) {
  for (let i = 0; i < chunks.length; i++) {
    // Pre-chunk verification
    const preCheck = await preChunkUploadCheck(expectedTitle);
    if (!preCheck.success) {
      throw new Error(preCheck.error);
    }
    
    // Upload chunk
    await uploadSingleChunk(chunks[i]);
    
    // Post-chunk verification 1: Title check
    const titleCheck = await postChunkUploadTitleCheck(expectedTitle);
    if (!titleCheck.success) {
      throw new Error("제목 변경 감지");
    }
    
    // Post-chunk verification 2: Continuity check (from 2nd chunk)
    if (i > 0) {
      const previousEnd = chunks[i - 1].slice(-50);
      const currentStart = chunks[i].slice(0, 50);
      const continuityCheck = await verifyChunkContinuity(previousEnd, currentStart);
      if (!continuityCheck.success) {
        throw new Error(continuityCheck.error);
      }
    }
    
    // Progress report
    const progress = ((i + 1) / chunks.length * 100).toFixed(1);
    // Report: `📤 청크 ${i + 1}/${chunks.length} 업로드 완료 (${progress}%)`
  }
}

async function preChunkUploadCheck(expectedTitle) {
  const result = await browser_evaluate(() => {
    const expected = expectedTitle; // Define inside
    const titleElement = document.querySelector('h1[contenteditable="true"]');
    const currentTitle = titleElement?.innerText.trim();
    const isFocusedOnTitle = titleElement?.contains(document.activeElement);
    
    // 1. Check not focused on title
    if (isFocusedOnTitle) {
      return {
        success: false,
        error: "ERR_FOCUSED_ON_TITLE",
        message: "제목 영역에 포커스됨"
      };
    }
    
    // 2. Check title unchanged
    if (currentTitle !== expected) {
      return {
        success: false,
        error: "ERR_TITLE_CHANGED",
        expected: expected,
        actual: currentTitle
      };
    }
    
    return { success: true };
  });
  
  return result;
}

async function uploadSingleChunk(chunk) {
  // Use browser_run_code for large content
  await browser_run_code({
    code: `async (page) => {
      const content = \`${chunk.replace(/`/g, '\\`').replace(/\$/g, '\\$')}\`;
      
      // Copy to clipboard
      await page.evaluate((text) => {
        return navigator.clipboard.writeText(text);
      }, content);
      
      // Scroll to bottom
      await page.evaluate(() => {
        window.scrollTo(0, document.body.scrollHeight);
      });
      
      // Focus content area
      await page.evaluate(() => {
        const contentArea = document.querySelector('[contenteditable="true"]:not(h1)');
        if (contentArea) {
          contentArea.focus();
          contentArea.click();
        }
      });
      
      // Paste
      await page.keyboard.press('Control+KeyV');
      
      // Wait
      await page.waitForTimeout(2000);
      
      return { success: true };
    }`
  });
}

async function postChunkUploadTitleCheck(expectedTitle) {
  const result = await browser_evaluate(() => {
    const expected = expectedTitle; // Define inside
    const titleElement = document.querySelector('h1[contenteditable="true"]');
    const currentTitle = titleElement?.innerText.trim();
    
    if (currentTitle !== expected) {
      return {
        success: false,
        error: "ERR_TITLE_CORRUPTED",
        expected: expected,
        actual: currentTitle
      };
    }
    
    return { success: true, title: currentTitle };
  });
  
  return result;
}

async function verifyChunkContinuity(previousChunkEnd, currentChunkStart) {
  const result = await browser_evaluate(() => {
    const prevEnd = previousChunkEnd; // Define inside
    const currStart = currentChunkStart; // Define inside
    const bodyText = document.body.innerText;
    
    // Check previous chunk end exists
    const hasPreviousEnd = bodyText.includes(prevEnd);
    
    // Check current chunk start exists
    const hasCurrentStart = bodyText.includes(currStart);
    
    // Check order
    const previousEndIndex = bodyText.indexOf(prevEnd);
    const currentStartIndex = bodyText.indexOf(currStart);
    const isCorrectOrder = previousEndIndex !== -1 && 
                           currentStartIndex !== -1 && 
                           previousEndIndex < currentStartIndex;
    
    if (!hasPreviousEnd || !hasCurrentStart) {
      return {
        success: false,
        error: "ERR_CHUNK_MISSING",
        hasPreviousEnd: hasPreviousEnd,
        hasCurrentStart: hasCurrentStart
      };
    }
    
    if (!isCorrectOrder) {
      return {
        success: false,
        error: "ERR_CHUNK_ORDER",
        previousEndIndex: previousEndIndex,
        currentStartIndex: currentStartIndex
      };
    }
    
    return {
      success: true,
      previousEndIndex: previousEndIndex,
      currentStartIndex: currentStartIndex
    };
  });
  
  return result;
}
```

---

### 5. Final Verification

**Purpose**: Verify uploaded content matches source file

**Input**:
- Expected title (string)
- Last line of file (string)
- Page URL (string)

**Output**:
- Verification result (object)
- Page URL (string)

**Implementation**:

```javascript
async function finalVerification(expectedTitle, lastLineOfFile, pageUrl) {
  // Navigate to page if not already there
  await browser_navigate({ url: pageUrl });
  await browser_wait_for({ time: 2 });
  
  const result = await browser_evaluate(() => {
    const expectedTitleValue = expectedTitle; // Define inside
    const lastLine = lastLineOfFile; // Define inside
    
    // 1. Title verification
    const titleElement = document.querySelector('h1[contenteditable="true"]');
    const actualTitle = titleElement?.innerText.trim();
    const titleCorrect = actualTitle === expectedTitleValue;
    
    // 2. Content verification
    const pageText = document.body.innerText;
    const hasLastLine = pageText.includes(lastLine);
    
    // 3. Title and content separation
    const titleAreaText = titleElement?.innerText.trim() || "";
    const contentArea = document.querySelector('[contenteditable="true"]:not(h1)');
    const contentAreaText = contentArea?.innerText.trim() || "";
    const titleNotInContent = !contentAreaText.includes(expectedTitleValue) || 
                               contentAreaText.indexOf(expectedTitleValue) === -1;
    
    return {
      success: titleCorrect && hasLastLine && titleNotInContent,
      titleCorrect: titleCorrect,
      hasLastLine: hasLastLine,
      titleNotInContent: titleNotInContent,
      pageUrl: window.location.href,
      pageTextLength: pageText.length
    };
  });
  
  return result;
}
```

---

### 6. Error Handling

**Purpose**: Handle errors with standard format and automatic fallback

**Error Codes**:
- `ERR_FILE_NOT_FOUND`: File not found
- `ERR_API_MOVE_FAILED`: API move to parent failed
- `ERR_API_PAGE_NOT_UNDER_PARENT`: API page not under parent (verification failed)
- `ERR_BROWSER_LOGIN_REQUIRED`: Notion login required
- `ERR_BROWSER_NO_EDIT_PERMISSION`: No edit permission on page
- `ERR_PAGE_CREATION_FAILED`: Sub-page creation failed
- `ERR_TITLE_MISMATCH`: Title input mismatch
- `ERR_TITLE_CORRUPTED`: Title changed during upload
- `ERR_FOCUSED_ON_TITLE`: Focused on title area
- `ERR_CHUNK_MISSING`: Chunk missing
- `ERR_CHUNK_ORDER`: Chunk order incorrect
- `ERR_CONTENT_VERIFICATION_FAILED`: Final content verification failed

**Error Report Template (Korean)**:

```
🚨 에러 발생

**에러 코드**: [ERR_XXX]
**에러 메시지**: [상세 메시지]
**발생 단계**: [단계 설명]

**원인**:
- [원인 1]
- [원인 2]

**해결 방법**:
1. [해결 단계 1]
2. [해결 단계 2]

**자동 복구 시도 중...** (API 실패 시)
또는
**사용자 확인 필요**: [확인 사항]
```

**Automatic Fallback Rules**:
- `ERR_API_MOVE_FAILED` → Automatic fallback to browser automation
- `ERR_API_PAGE_NOT_UNDER_PARENT` → Automatic fallback to browser automation
- Other errors → Report to user and wait for response

---

## Usage Guidelines

### When to Use Each Skill

1. **Markdown File Analysis**: Always first, before any upload
2. **Upload Plan Creation**: After analysis, before upload
3. **Notion Upload - API Method**: Primary method, use first
4. **Notion Upload - Browser Automation**: Fallback or when API unavailable
5. **Final Verification**: Always after upload complete
6. **Error Handling**: At any error occurrence

### Quality Standards

- Always verify at every step
- Never modify or delete existing content
- Report progress clearly in Korean
- Get user confirmation before major operations
- Use automatic fallback when API fails
- Preserve data integrity above all

---

## Integration Notes

### MCP Tools Required

- **Notion MCP**: `notion-create-pages`, `notion-move-pages`, `notion-fetch`
- **Playwright MCP**: `browser_navigate`, `browser_evaluate`, `browser_type`, `browser_press_key`, `browser_click`, `browser_run_code`, `browser_wait_for`, `browser_snapshot`
- **Codebase Search**: `glob_file_search`, `read_file`

### Critical Browser Automation Rules

1. **Never use `element`/`ref` in `browser_evaluate`**: Causes title corruption
2. **Always verify after each operation**: Title, area, chunk continuity
3. **Use `browser_run_code` for large content**: Better for clipboard operations
4. **Define values inside `browser_evaluate` functions**: Don't pass as parameters

---

## Example Workflow

### Complete Upload Process (SUCCESSFUL PATTERN)

```javascript
// 1. Analyze file
const analysis = await analyzeMarkdownFile(filePath, workspaceRoot);
// Returns: { content, lineCount, title, chunkStrategy }

// 2. Create plan
const plan = await createUploadPlan(analysis, parentPageId, customTitle);
// Returns: UploadPlan object

// 3. Report plan and get confirmation (in Korean)
// User confirms: "진행" or "계속"

// 4. Setup verification
await verifyMCPSevers(); // Check Notion MCP first

// 5. Upload using MCP API (PREFERRED METHOD - proven successful!)
// ⚡ 실제 성공한 작업 순서와 파라미터 구조
if (parentPageUrl) {
  // ⚡ Step 1: Fetch parent page info (URL → ID 추출)
  // parentPageUrl 예시: "https://www.notion.so/2939168184838094b94bc4ad6aab8c88"
  const parentInfo = await fetchParentPageInfo(parentPageUrl);
  // parentInfo.id = "2939168184838094b94bc4ad6aab8c88"
  
  // ⚡ Step 2: Create page with parent + content in ONE call
  // 정확한 파라미터 구조 사용
  const result = await uploadToNotionAPI(
    plan.title,        // 포맷팅된 제목
    parentPageUrl,     // 부모 페이지 URL
    analysis.content   // ⚡ 전체 마크다운 내용 (한 번에 업로드!)
  );
  // result.pages[0].id = 생성된 페이지 ID
  // result.pages[0].url = 생성된 페이지 URL
  
  if (!result.success) {
    // ⚡ Retry Logic: 1회 재시도
    const retryResult = await uploadToNotionAPI(
      plan.title,
      parentPageUrl,
      analysis.content
    );
    
    if (!retryResult.success) {
      // Fallback to browser automation
      // ... (browser method)
    } else {
      pageUrl = retryResult.pageUrl;
    }
  } else {
    pageUrl = result.pageUrl;
  }
} else {
  // ⚡ No parent - create in workspace root with content
  // parent 없이 생성 (parent 파라미터 생략)
  const result = await createNotionPageAPI(plan.title, null, analysis.content);
  // 정확한 구조:
  // {
  //   pages: [{
  //     properties: { title: plan.title },
  //     content: analysis.content
  //   }]
  // }
  pageUrl = result.pageUrl;
}

// 6. Final verification (optional - can use notion-fetch)
const verification = await finalVerification(
  plan.title,
  analysis.lastLine,
  pageUrl
);

// 7. Report completion (in Korean)
// Note: If using MCP API, content is already uploaded - no chunk upload needed!
```

---

**Made with ❤️ for Document Upload Agent**
