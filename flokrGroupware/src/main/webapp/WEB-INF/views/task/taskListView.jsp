<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/@joeattardi/emoji-button@3.0.3/dist/index.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/taskListView.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/taskDetailView.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/taskInsertForm.css">
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
	<br>
	
	<div class="outer">
        <div class="content-container">
	        <div class="left-section">
	            <!-- 왼쪽 내용 들어가는 자리 -->
	            <div class="sidebar-title">업무 관리</div>
					<div class="sidebar-subtitle">업무를 한눈에 확인하고 관리하세요.</div>
					
					<a id="add-task-btn" class="add-btn">+ 새 업무 추가</a>
					
					<a href="${pageContext.request.contextPath}/task/list" class="nav-item">
					  <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
					    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
					  </svg>
					  홈
					</a>
					
					<div class="section-divider"></div>
					
					<div class="section-title" onclick="toggleSection('in-progress', this)">
					    진행 중인 업무 목록
					    <svg class="arrow rotate" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
					        <path d="M6 9l6 6 6-6" />
					    </svg>
					</div>
					
					<div class="task-group" id="in-progress">
					    <div class="task-subitem" data-task-id="1">🎨 화면 설계</div>
					    <div class="task-subitem" data-task-id="2">📄 데이터 설계</div>
					    <div class="task-subitem" data-task-id="3">📁 DB 스크립트 파일</div>
					    <div class="task-subitem">🛠 기능 구현</div>
					    
					    <!-- 여기서 1은 예시이므로 나중엔 ${task.taskId} 같은 동적 값으로 바꾸기 -->
					</div>
					
					<div class="section-divider"></div>
					
					<div class="section-title" onclick="toggleSection('completed', this)">
					    완료된 업무 목록
					    <svg class="arrow" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
					        <path d="M6 9l6 6 6-6" />
					    </svg>
					</div>
					
					<div class="task-group closed" id="completed">
					    <div class="task-subitem">📌 프로젝트 기획 및 요구사항 분석</div>
					</div>
	        </div>
	        
	        <div class="right-section">
	            <!-- 오른쪽 내용 들어가는 자리 -->
	            <div id="task-list-view">
				    <!-- 기존 검색창 + 카드 목록 들어가는 영역 -->
		            <!-- 검색창 -->
					<div class="search-header">
					    <div class="search-input-group">
					        <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
					            <circle cx="11" cy="11" r="8" />
					            <line x1="21" y1="21" x2="16.65" y2="16.65" />
					        </svg>
					        <input type="text" class="search-input-modern" placeholder="검색어를 입력하세요">
					        <button class="search-btn" title="검색">
							    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="none" stroke="white" stroke-width="2" viewBox="0 0 24 24">
							        <circle cx="11" cy="11" r="8" />
							        <line x1="21" y1="21" x2="16.65" y2="16.65" />
							    </svg>
							</button>
					    </div>
					    <div class="filter-group">
					        <label class="filter-label">검색 필터:</label>
					        <select class="filter-select">
					            <option value="">카테고리</option>
					            <option value="디자인">디자인</option>
					            <option value="데이터">데이터</option>
					        </select>
					        <select class="filter-select">
					            <option value="">상태</option>
					            <option value="진행중">진행중</option>
					            <option value="완료">완료</option>
					        </select>
					    </div>
					</div>
	
					
					<!-- 검색 정보 -->
					<div class="search-info">
					    ✅ 입력한 검색어를 자동으로 수정했습니다: <strong>설계</strong>
					    <br>
					    &nbsp;&nbsp;&nbsp; <a href="#">‘설ㄱㅖ’ 검색 결과 보기</a>
					</div>
					
					<div class="search-result-count">
					    <h3>‘설계’ 검색 결과 - 2건</h3>
					</div>
					
					<!-- 업무 카드 목록 -->
					<div class="task-cards">
					    <!-- 카드 1 -->
					    <div class="task-card" onclick="loadTaskDetail(1)">
					        <div class="task-header">
					            <span class="task-title">🎨 화면 설계</span>
					        </div>
					        <div class="task-meta">
					            <div><strong>업무 담당자:</strong> 👤 A, B 외</div>
					            <div><strong>카테고리:</strong> 디렉터</div>
					            <div><strong>마감일:</strong> 2025-04-18</div>
					            <div><strong>상태:</strong> <span class="badge 진행중">진행중</span></div>
					        </div>
					    </div>
					
					    <!-- 카드 2 (복붙해서 추가 가능) -->
					    <div class="task-card">
					        <div class="task-header">
					            <span class="task-title">📄 데이터 설계</span>
					        </div>
					        <div class="task-meta">
					            <div><strong>업무 담당자:</strong> 👤 C, D 외</div>
					            <div><strong>카테고리:</strong> 데이터</div>
					            <div><strong>마감일:</strong> 2025-04-18</div>
					            <div><strong>상태:</strong> <span class="badge 완료">완료</span></div>
					        </div>
					    </div>
					    
					    <div class="task-card">
					        <div class="task-header">
					            <span class="task-title">📄 데이터 설계</span>
					        </div>
					        <div class="task-meta">
					            <div><strong>업무 담당자:</strong> 👤 C, D 외</div>
					            <div><strong>카테고리:</strong> 데이터</div>
					            <div><strong>마감일:</strong> 2025-04-18</div>
					            <div><strong>상태:</strong> <span class="badge 완료">완료</span></div>
					        </div>
					    </div>
					    
					    <div class="task-card">
					        <div class="task-header">
					            <span class="task-title">📄 데이터 설계</span>
					        </div>
					        <div class="task-meta">
					            <div><strong>업무 담당자:</strong> 👤 C, D 외</div>
					            <div><strong>카테고리:</strong> 데이터</div>
					            <div><strong>마감일:</strong> 2025-04-18</div>
					            <div><strong>상태:</strong> <span class="badge 완료">완료</span></div>
					        </div>
					    </div>
					    
					    <div class="task-card">
					        <div class="task-header">
					            <span class="task-title">📄 데이터 설계</span>
					        </div>
					        <div class="task-meta">
					            <div><strong>업무 담당자:</strong> 👤 C, D 외</div>
					            <div><strong>카테고리:</strong> 데이터</div>
					            <div><strong>마감일:</strong> 2025-04-18</div>
					            <div><strong>상태:</strong> <span class="badge 완료">완료</span></div>
					        </div>
					    </div>
					    
					    <div class="task-card">
					        <div class="task-header">
					            <span class="task-title">📄 데이터 설계</span>
					        </div>
					        <div class="task-meta">
					            <div><strong>업무 담당자:</strong> 👤 C, D 외</div>
					            <div><strong>카테고리:</strong> 데이터</div>
					            <div><strong>마감일:</strong> 2025-04-18</div>
					            <div><strong>상태:</strong> <span class="badge 완료">완료</span></div>
					        </div>
					    </div>
					    
					    <div class="task-card">
					        <div class="task-header">
					            <span class="task-title">📄 데이터 설계</span>
					        </div>
					        <div class="task-meta">
					            <div><strong>업무 담당자:</strong> 👤 C, D 외</div>
					            <div><strong>카테고리:</strong> 데이터</div>
					            <div><strong>마감일:</strong> 2025-04-18</div>
					            <div><strong>상태:</strong> <span class="badge 완료">완료</span></div>
					        </div>
					    </div>
					</div>
				</div>
				
				<div id="task-detail-view" style="display:none;">
				    <!-- AJAX로 불러올 상세 JSP가 들어올 자리 -->
				</div>
				
				<div id="task-insert-view" style="display:none;"></div> 
				<!-- 새 업무 추가 -->
	            
	        </div>
        </div>
	</div>
	
	<script>
	  function toggleSection(id, triggerElement) {
	    const section = document.getElementById(id);
	    const arrow = triggerElement.querySelector('.arrow');
	    const isClosed = section.classList.contains('closed');
	
	    if (isClosed) {
	      section.classList.remove('closed');
	      section.style.maxHeight = section.scrollHeight + 'px';
	    } else {
	      section.style.maxHeight = '0px';
	      section.classList.add('closed');
	    }
	
	    if (arrow) {
	      arrow.classList.toggle('rotate', isClosed);
	    }
	  }
	</script>
	
	<script>
		function loadTaskDetail(taskId, clickedItem) {
		  document.getElementById("task-list-view").style.display = "none";
		  document.getElementById("task-detail-view").style.display = "block";

		  fetch("${pageContext.request.contextPath}/task/detail?taskId=" + taskId)
		    .then(res => res.text())
		    .then(html => {
		      document.getElementById("task-detail-view").innerHTML = html;
		    });

		  document.querySelectorAll('.task-subitem').forEach(item => {
		    item.classList.remove('selected');
		  });
		  clickedItem.classList.add('selected');
		}
		
		const taskItems = document.querySelectorAll('.task-subitem');

		taskItems.forEach(item => {
		  item.addEventListener('click', function() {
		    const taskId = this.dataset.taskId; // data-task-id 가져오기
		    loadTaskDetail(taskId, this);
		  });
		});

	
		function loadTaskInsert() {
			  document.getElementById("task-list-view").style.display = "none";
			  document.getElementById("task-detail-view").style.display = "none";
			  document.getElementById("task-insert-view").style.display = "block";

			  fetch("${pageContext.request.contextPath}/task/insert")
			    .then(res => res.text())
			    .then(html => {
			      document.getElementById("task-insert-view").innerHTML = html;

			      const emojiButton = document.querySelector('.emoji-btn');
			      const selectedEmojiInput = document.getElementById('selectedEmoji');

			      if (emojiButton && selectedEmojiInput) {
			        const picker = new EmojiButton({
			          position: 'bottom-start',
			          theme: 'light'
			        });

			        picker.on('emoji', selection => {
			          emojiButton.innerText = selection;
			          selectedEmojiInput.value = selection;
			        });

			        emojiButton.addEventListener('click', () => {
			          picker.togglePicker(emojiButton);
			        });
			      } else {
			        console.error('Emoji button or hidden input not found');
			      }
			    });

			  document.querySelectorAll('.task-subitem').forEach(item => {
			    item.classList.remove('selected');
			  });
			}


	
	  function backToList() {
	    document.getElementById("task-detail-view").style.display = "none";
	    document.getElementById("task-insert-view").style.display = "none";
	    document.getElementById("task-list-view").style.display = "block";
	  
	    document.querySelectorAll('.task-subitem').forEach(item => {
	        item.classList.remove('selected');
	      });
	  }
	
	  document.getElementById("add-task-btn").addEventListener("click", function(e) {
	    e.preventDefault(); // a태그라서 기본 이동 막기
	    loadTaskInsert();
	  });
	  
	  function resetInsertForm() {
	    // 입력된 값 초기화
	    document.querySelector('.insert-title-input').value = '';
	    document.querySelector('.insert-content-box').value = '';
	    document.querySelector('.insert-dropdown').selectedIndex = 0;
	    document.querySelector('.insert-date-input').value = '';
	    // 첨부파일 초기화
	    document.querySelector('.insert-attachment-box input[type="file"]').value = '';
	  }

	  function submitInsertForm() {
	    // 추후 폼 제출 처리 (AJAX나 폼 전송 예정)
	    alert('업무 등록 기능은 아직 연결되지 않았습니다.');
	  }
	  
	  </script>


</body>
</html>