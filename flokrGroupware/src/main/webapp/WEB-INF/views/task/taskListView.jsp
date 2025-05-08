<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/@joeattardi/emoji-button@3.0.3/dist/index.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/taskListView.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/taskDetailView.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/taskInsertForm.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
					
					
					<div class="left-scrollable">
					<div class="section-divider"></div>
						<div class="section-title" onclick="toggleSection('in-progress', this)">
						    진행 중인 업무 목록
						    <svg class="arrow rotate" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
						        <path d="M6 9l6 6 6-6" />
						    </svg>
						</div>
						
						<div class="task-group" id="in-progress">
							<c:forEach var="list" items="${ list }">
						    	<div class="task-subitem" data-task-id="${list.taskNo}">${ list.emoji } ${ list.taskTitle }</div>
							</c:forEach>
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
					    <c:forEach var="list" items="${ list }">
						    <div class="task-card" data-task-id="${list.taskNo}">
						        <div class="task-header">
						            <span class="task-title">${ list.emoji } ${ list.taskTitle }</span>
						        </div>
						        <div class="task-meta">
						            <div><strong>업무 담당자:</strong> 👤 A, B 외</div>
						            <div><strong>카테고리:</strong> ${ list.category }</div>
						            <div><strong>마감일:</strong> ${ list.dueDate }</div>
						            
						            <div>
							            <strong>상태:</strong> 
							            <span class="badge ${statusColorMap[list.taskStatus]}">
							            	${statusNameMap[list.taskStatus]}
							            </span>
						            </div>
						        </div>
						    </div>
					    </c:forEach>
					</div>
				</div>
				
				<div id="task-detail-view" style="display:none;"></div>
				
				<div id="task-insert-view" style="display:none;"></div>
				
				<div id="task-update-view" style="display:none;"></div> 
	            
	        </div>
        </div>
	</div>
	
<script>
  function toggleSection(id, triggerElement) {
    const section = document.getElementById(id);
    const arrow = triggerElement.querySelector('.arrow');
    const isClosed = section.classList.contains('closed');

    section.classList.toggle('closed', !isClosed);
    section.style.maxHeight = isClosed ? section.scrollHeight + 'px' : '0px';
    if (arrow) arrow.classList.toggle('rotate', isClosed);
  }

  function loadTaskDetail(taskId, clickedItem) {
	  document.getElementById("task-list-view").style.display = "none";
	  document.getElementById("task-detail-view").style.display = "block";
	  document.getElementById("task-insert-view").style.display = "none";
	  document.getElementById("task-update-view").style.display = "none";

	  fetch("${pageContext.request.contextPath}/task/detail?taskId=" + taskId)
	    .then(res => res.text())
	    .then(html => {
	      document.getElementById("task-detail-view").innerHTML = html;
	    });

	  document.querySelectorAll('.task-subitem').forEach(item => {
	    item.classList.remove('selected');
	  });

	  const matchingListItem = document.querySelector('.task-subitem[data-task-id="' + taskId + '"]');
	  if (matchingListItem) {
	    matchingListItem.classList.add('selected');
	  }
	}


  function loadTaskInsert() {
    document.getElementById("task-list-view").style.display = "none";
    document.getElementById("task-detail-view").style.display = "none";
    document.getElementById("task-insert-view").style.display = "block";
    document.getElementById("task-update-view").style.display = "none";

    fetch("${pageContext.request.contextPath}/task/insertForm")
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
        }
      });

    // 삽입 모드일 땐 좌측 리스트 선택 해제
    document.querySelectorAll('.task-subitem').forEach(item => {
      item.classList.remove('selected');
    });
  }

  function backToList() {
    document.getElementById("task-detail-view").style.display = "none";
    document.getElementById("task-insert-view").style.display = "none";
    document.getElementById("task-list-view").style.display = "block";
    document.getElementById("task-update-view").style.display = "none";

    document.querySelectorAll('.task-subitem').forEach(item => {
      item.classList.remove('selected');
    });
  }

  function resetInsertForm() {
    document.querySelector('.insert-title-input').value = '';
    document.querySelector('.insert-content-box').value = '';
    document.querySelector('.insert-dropdown').selectedIndex = 0;
    document.querySelector('.insert-date-input').value = '';
    document.querySelector('#selectedEmoji').value = '';
    document.querySelector('.emoji-btn').innerHTML = '<span class="material-icons">add_circle_outline</span>';
    document.querySelector('.insert-attachment-box input[type="file"]').value = '';
  }

  // 새 업무 추가 버튼
  document.getElementById("add-task-btn").addEventListener("click", function(e) {
    e.preventDefault();
    loadTaskInsert();
  });

  window.addEventListener('DOMContentLoaded', function () {
	  // ✅ 등록 실패 시 처리
	  fetch("${pageContext.request.contextPath}/task/checkFailFlag")
	    .then(res => res.json())
	    .then(fail => {
	      if (fail) {
	        alertify.alert("업무 등록에 실패했습니다. 다시 시도해주세요.", function () {
	          loadTaskInsert();
	        });
	      }
	    });

	  // ✅ 리스트 클릭 바인딩
	  document.querySelectorAll('.task-subitem').forEach(item => {
	    item.addEventListener('click', function () {
	      const taskId = this.dataset.taskId;
	      loadTaskDetail(taskId, this);
	    });
	  });

	  // ✅ 카드 클릭 바인딩
	  document.querySelectorAll('.task-card').forEach(item => {
	    item.addEventListener('click', function () {
	      const taskId = this.dataset.taskId;
	      loadTaskDetail(taskId, null);
	    });
	  });
	});
  
    function toggleOptions(e) {
	  e.stopPropagation();
	  const menu = document.getElementById("actionMenu");
	  if (menu) {
	    menu.style.display = menu.style.display === "block" ? "none" : "block";
	  }
	}

	// 바깥 클릭 시 닫기
	document.addEventListener("click", function() {
	  const menu = document.getElementById("actionMenu");
	  if (menu) {
	    menu.style.display = "none";
	  }
	});
	
	function editTask(taskId) {
	  // 뷰 상태 변경
	  document.getElementById("task-list-view").style.display = "none";
	  document.getElementById("task-detail-view").style.display = "none";
	  document.getElementById("task-insert-view").style.display = "none";
	  document.getElementById("task-update-view").style.display = "block";

	  // AJAX로 폼 로딩
	  fetch(`${pageContext.request.contextPath}/task/updateForm?taskId=` + taskId)
	    .then(res => res.text())
	    .then(html => {
	      document.getElementById("task-update-view").innerHTML = html;
	      
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
	        }
	    });
	}


	function deleteTask(taskId) {
	  if (confirm("정말 삭제하시겠습니까?")) {
	    location.href = `${pageContext.request.contextPath}/task/delete?taskId=` + taskId;
	  }
	}
	
	function updateFileName(input) {
	  const fileNameSpan = document.getElementById("fileName");
	  const fileName = input.files.length > 0 ? input.files[0].name : "선택된 파일 없음";
	  fileNameSpan.textContent = fileName;
	}

	function selectStatus(status, clickedSpan) {
	  document.getElementById("taskStatus").value = status;
	  document.querySelectorAll('.status-tags .tag').forEach(tag => tag.classList.remove('active'));
	  clickedSpan.classList.add('active');
	}
	
	function submitUpdate() {
		  
		  const form = document.getElementById("update-task-form");
		  const formData = new FormData(form);

		  fetch(`${pageContext.request.contextPath}/task/update`, {
		    method: "POST",
		    body: formData
		  })
		  .then(async res => {
			  const contentType = res.headers.get("content-type");
			  if (res.ok && contentType && contentType.includes("application/json")) {
			    return res.json();
			  } else {
			    const text = await res.text();  // 만약 HTML 에러 페이지 같은 게 응답으로 오면 여기서 잡힘
			    throw new Error("Unexpected response:\n\n" + text);
			  }
			})
		  .then(data => {
		    if (data.success) {
		      console.log("업무 수정 성공~");
		      location.href = `${pageContext.request.contextPath}/task/list`;
		    } else {
		      console.log("업무 수정 실패");
		      location.href = `${pageContext.request.contextPath}/task/list`;
		    }
		  })
		  .catch(err => {
		    console.error("업데이트 중 오류 발생", err);
		    alert("서버 오류로 수정에 실패했습니다.");
		  });
		}


</script>


</body>
</html>