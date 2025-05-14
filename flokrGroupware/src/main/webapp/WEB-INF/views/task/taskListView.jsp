<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://cdn.jsdelivr.net/npm/@joeattardi/emoji-button@3.0.3/dist/index.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/taskListView.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/taskDetailView.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/taskInsertForm.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<style>
  .hidden {
    display: none;
  }
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />

	<br>

	<div class="outer">
		<div class="content-container">
			<div class="left-section">
				<!-- 왼쪽 내용 들어가는 자리 -->
				<div class="sidebar-title">업무 관리</div>
				<div class="sidebar-subtitle">업무를 한눈에 확인하고 관리하세요.</div>

				<a id="add-task-btn" class="add-btn">+ 새 업무 추가</a> <a
					href="${pageContext.request.contextPath}/task/list"
					class="nav-item"> <svg xmlns="http://www.w3.org/2000/svg"
						fill="none" stroke="currentColor" stroke-width="2"
						viewBox="0 0 24 24">
					    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z" />
					  </svg> 홈
				</a>


				<div class="left-scrollable">
					<div class="section-divider"></div>
					<div class="section-title"
						onclick="toggleSection('in-progress', this)">
						진행 중인 업무 목록
						<svg class="arrow rotate" xmlns="http://www.w3.org/2000/svg"
							fill="none" stroke="currentColor" stroke-width="2"
							viewBox="0 0 24 24">
						        <path d="M6 9l6 6 6-6" />
						    </svg>
					</div>

					<div class="task-group" id="in-progress">
						<c:forEach var="list" items="${ list }">
							<div class="task-subitem" data-task-id="${list.taskNo}">${ list.emoji }
								${ list.taskTitle }</div>
						</c:forEach>
					</div>

					<div class="section-divider"></div>

					<div class="section-title"
						onclick="toggleSection('completed', this)">
						완료된 업무 목록
						<svg class="arrow" xmlns="http://www.w3.org/2000/svg" fill="none"
							stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
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
							<svg class="search-icon" xmlns="http://www.w3.org/2000/svg"
								width="16" height="16" fill="none" stroke="currentColor"
								stroke-width="2" viewBox="0 0 24 24">
					            <circle cx="11" cy="11" r="8" />
					            <line x1="21" y1="21" x2="16.65" y2="16.65" />
					        </svg>
							<input type="text" id="autocomplete-input"
								class="search-input-modern" placeholder="검색어를 입력하세요"
								value="${keyword}">
							<ul id="autocomplete-results"></ul>

							<button class="search-btn" title="검색">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="none" stroke="white" stroke-width="2" viewBox="0 0 24 24">
							        <circle cx="11" cy="11" r="8" />
							        <line x1="21" y1="21" x2="16.65" y2="16.65" />
							    </svg>
							</button>
						</div>
						<div class="filter-group">
							<label class="filter-label">검색 필터:</label> <select
								class="filter-select">
								<option value="">카테고리</option>
								<option value="디자인">디자인</option>
								<option value="데이터">데이터</option>
							</select> <select class="filter-select">
								<option value="">상태</option>
								<option value="진행중">진행중</option>
								<option value="완료">완료</option>
							</select>
						</div>
					</div>


					<!-- 검색 정보 -->
					<div class="search-info hidden">
					</div>

					<div class="search-result-count hidden">
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
									<div>
										<strong>업무 담당자:</strong> 👤 A, B 외
									</div>
									<div>
										<strong>카테고리:</strong> ${ list.category }
									</div>
									<div>
										<strong>마감일:</strong> ${ list.dueDate }
									</div>

									<div>
										<strong>상태:</strong> <span
											class="badge ${statusColorMap[list.taskStatus]}">
											${statusNameMap[list.taskStatus]} </span>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>

				<div id="task-detail-view" style="display: none;"></div>

				<div id="task-insert-view" style="display: none;"></div>

				<div id="task-update-view" style="display: none;"></div>

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

	  // 수정: 템플릿 리터럴을 사용하지 않고 문자열 연결 사용
	  const detailUrl = "${pageContext.request.contextPath}/task/detail?taskId=" + taskId;
	  fetch(detailUrl)
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
	  // 검색 정보와 결과 카운트 영역 숨기기
	  document.querySelector(".search-info").classList.add("hidden");
	  document.querySelector(".search-result-count").classList.add("hidden");
	  
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

	  // AJAX로 폼 로딩 - 수정: 템플릿 리터럴을 사용하지 않고 문자열 연결 사용
	  const updateUrl = "${pageContext.request.contextPath}/task/updateForm?taskId=" + taskId;
	  fetch(updateUrl)
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
	    // 수정: 템플릿 리터럴을 사용하지 않고 문자열 연결 사용
	    location.href = "${pageContext.request.contextPath}/task/delete?taskId=" + taskId;
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

		  // 수정: 템플릿 리터럴을 사용하지 않고 문자열 연결 사용
		  const updateUrl = "${pageContext.request.contextPath}/task/update";
		  fetch(updateUrl, {
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
		      location.href = "${pageContext.request.contextPath}/task/list";
		    } else {
		      console.log("업무 수정 실패");
		      location.href = "${pageContext.request.contextPath}/task/list";
		    }
		  })
		  .catch(err => {
		    console.error("업데이트 중 오류 발생", err);
		    alert("서버 오류로 수정에 실패했습니다.");
		  });
		}
	
	document.addEventListener("DOMContentLoaded", function () {
		  const input = document.getElementById("autocomplete-input");
		  const resultsContainer = document.getElementById("autocomplete-results");

		  input.addEventListener("input", function () {
		    const keyword = input.value.trim();
		    if (keyword.length < 1) {
		      resultsContainer.style.display = "none";
		      return;
		    }

		    // 수정된 코드: encodeURIComponent를 JavaScript 내에서만 사용
		    const autocompleteUrl = "${pageContext.request.contextPath}/autocomplete?prefix=" + encodeURIComponent(keyword);
		    fetch(autocompleteUrl)
		      .then(res => res.json())
		      .then(data => {
		        resultsContainer.innerHTML = "";
		        if (data.length === 0) {
		          resultsContainer.style.display = "none";
		          return;
		        }

		        data.forEach(suggestion => {
		          const li = document.createElement("li");
		          li.textContent = suggestion;
		          li.style.padding = "10px 16px";
		          li.style.cursor = "pointer";
		          li.style.borderBottom = "1px solid #eee";
		          li.style.fontSize = "14px";
		          li.style.transition = "background 0.2s";
		          li.addEventListener("mouseover", () => {
		            li.style.background = "#f1f1f1";
		          });
		          li.addEventListener("mouseout", () => {
		            li.style.background = "white";
		          });
		          li.addEventListener("click", function () {
		            input.value = suggestion;
		            resultsContainer.style.display = "none";
		            document.querySelector(".search-btn").click();
		          });
		          resultsContainer.appendChild(li);
		        });

		        resultsContainer.style.display = "block";
		      });
		  });

		  // 클릭 외부 시 닫기
		  document.addEventListener("click", function (e) {
		    if (!resultsContainer.contains(e.target) && e.target !== input) {
		      resultsContainer.style.display = "none";
		    }
		  });
		});
	
	document.querySelector(".search-btn").addEventListener("click", function(e) {
		  e.preventDefault();

		  const keyword = document.getElementById("autocomplete-input").value.trim();
		  if (!keyword) return;
		  
		  const forceOriginal = this.hasAttribute("data-force-original");
		  if (forceOriginal) {
		    this.removeAttribute("data-force-original"); // 플래그 제거
		  }
		  
		  const searchUrl = "${pageContext.request.contextPath}/searchTasks?keyword=" + encodeURIComponent(keyword) + 
		                   (forceOriginal ? "&forceOriginal=true" : "");
		  
		  fetch(searchUrl)
		    .then(res => res.json())
		    .then(data => {
		      console.log("데이터 받음:", data);
		      
		      const container = document.querySelector(".task-cards");
		      const searchInfoEl = document.querySelector(".search-info");
		      const resultCountEl = document.querySelector(".search-result-count");
		      
		      container.innerHTML = ""; // 기존 결과 지움
		      
		      searchInfoEl.classList.add("hidden");
		      resultCountEl.classList.remove("hidden");
		      
		      let correctedKeyword = null;
		      let actualResults = [...data]; // 배열 복사
		      
		   // 첫 번째 항목에 _corrected 필드가 있는지 확인하고, 원본 검색이 아닐 때만 처리
		      if (!forceOriginal && data.length > 0 && data[0]._corrected && data[0]._corrected !== keyword) {
		        correctedKeyword = data[0]._corrected;
		        // 교정 정보는 결과에서 제외
		        actualResults = data.filter(item => !item._corrected);
		        
		        // 오타 수정 정보 표시
		        searchInfoEl.classList.remove("hidden");
		        searchInfoEl.innerHTML = 
		          "✅ 입력한 검색어를 자동으로 수정했습니다: <strong>" + correctedKeyword + "</strong><br>" +
		          "&nbsp;&nbsp;&nbsp; <a href='#' onclick='searchAgain(\"!" + keyword + "\"); return false;'>" +
		          "'" + keyword + "' 검색 결과 보기</a>";
		        
		        // 검색창의 값을 교정된 키워드로 변경하지 않음
		        // document.getElementById("autocomplete-input").value = correctedKeyword;
		      } else {
		        // 오타 수정이 없으면 검색 정보 영역 숨김
		        searchInfoEl.classList.add("hidden");
		      }
		      
		      // 결과 카운트 표시
		      if (actualResults.length === 0) {
		        resultCountEl.innerHTML = "<h3>검색 결과가 없습니다.</h3>";
		      } else {
		        const displayKeyword = forceOriginal ? searchKeyword : (correctedKeyword || keyword);
		        resultCountEl.innerHTML = "<h3>'" + displayKeyword + "' 검색 결과 - " + actualResults.length + "건</h3>";
		      }
		      
		      // 단계별로 데이터 추가하기
		      for (let i = 0; i < actualResults.length; i++) {
		        const task = actualResults[i];
		        console.log("작업 데이터:", task);
		        
		        // 카드 생성
		        const card = document.createElement("div");
		        card.className = "task-card";
		        card.setAttribute("data-task-id", task.taskNo || "");
		        
		        // 카드 내용 작성
		        const headerDiv = document.createElement("div");
		        headerDiv.className = "task-header";
		        
		        const titleSpan = document.createElement("span");
		        titleSpan.className = "task-title";
		        
		        // 이모지와 제목 추가
		        if (task.emoji) {
		          titleSpan.textContent = task.emoji + " ";
		        }
		        if (task.taskTitle) {
		          titleSpan.textContent += task.taskTitle;
		        }
		        
		        headerDiv.appendChild(titleSpan);
		        card.appendChild(headerDiv);
		        
		        // 메타 정보 영역 생성
		        const metaDiv = document.createElement("div");
		        metaDiv.className = "task-meta";
		        
		        // 담당자 정보
		        const assigneeDiv = document.createElement("div");
		        assigneeDiv.innerHTML = "<strong>업무 담당자:</strong> 👤 A, B 외";
		        metaDiv.appendChild(assigneeDiv);
		        
		        // 카테고리
		        const categoryDiv = document.createElement("div");
		        categoryDiv.innerHTML = "<strong>카테고리:</strong> " + (task.category || "");
		        metaDiv.appendChild(categoryDiv);
		        
		        // 마감일
		        const dueDateDiv = document.createElement("div");
		        dueDateDiv.innerHTML = "<strong>마감일:</strong> " + (task.dueDate || "");
		        metaDiv.appendChild(dueDateDiv);
		        
		        // 상태
		        const statusDiv = document.createElement("div");
		        statusDiv.innerHTML = "<strong>상태:</strong> ";
		        
		        // 상태 매핑
		        const statusColorMap = {
		          TODO: "gray",
		          IN_PROGRESS: "blue",
		          FEEDBACK: "pink",
		          ON_HOLD: "yellow",
		          DONE: "green",
		          REQUEST: "purple"
		        };
		        
		        const statusNameMap = {
		          TODO: "요청",
		          IN_PROGRESS: "진행 중",
		          FEEDBACK: "피드백",
		          ON_HOLD: "보류",
		          DONE: "완료",
		          REQUEST: "요청"
		        };
		        
		        const statusColor = statusColorMap[task.taskStatus] || "gray";
		        const statusName = statusNameMap[task.taskStatus] || "상태 미정";
		        
		        const statusBadge = document.createElement("span");
		        statusBadge.className = "badge " + statusColor;
		        statusBadge.textContent = statusName;
		        
		        statusDiv.appendChild(statusBadge);
		        metaDiv.appendChild(statusDiv);
		        
		        card.appendChild(metaDiv);
		        
		        // 클릭 이벤트 추가
		        card.addEventListener("click", function() {
		          loadTaskDetail(task.taskNo);
		        });
		        
		        // 카드를 컨테이너에 추가
		        container.appendChild(card);
		      }
		    })
		    .catch(error => {
		      console.error("오류 발생:", error);
		    });
		});
	
	function searchAgain(originalKeyword) {
	  // 느낌표는 실제로 보이지 않도록 처리
	  const input = document.getElementById("autocomplete-input");
	  input.value = originalKeyword;
	  
	  // 원본 검색 강제 플래그 설정
	  const searchBtn = document.querySelector(".search-btn");
	  
	  // 데이터 속성으로 원본 검색 플래그 추가
	  searchBtn.setAttribute("data-force-original", "true");
	  searchBtn.click();
	}

</script>


</body>
</html>