<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flokr</title>
<!-- chatList CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chatList.css">
<!-- Material Icons 추가 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"rel="stylesheet">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- sockjs -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- Stomp -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="chat-outer">

        <div class="chat-content">
            <div class="chat-sidebar">
                <div class="search-box">
                    <div class="chat-list-header">
                        <div class="sub-title">채팅</div>
                        <%-- 채팅방 추가 버튼 (+ 모양) --%>
                        <button type="button" id="addChatBtn" class="material-icons">add</button>
                    </div>
                    <div class="search-input">
                        <span class="material-icons">search</span>
                        <input type="text" placeholder="검색...">
                    </div>
                </div>
                <div class="chat-list">
                	<c:forEach var="room" items="${ chatRoomList }">
                    <div class="chat-item" data-roomno="${room.roomNo}">
                        <div class="avatar">
                        <c:choose>
							<c:when test="${ room.roomType == 'P' }">
								<c:choose>
									<c:when test="${ not empty room.chatUserImgPath }">
										<img src="${pageContext.request.contextPath}/${room.chatUserImgPath}" alt="${room.roomName}">
									</c:when>
									<c:otherwise>
										<svg class="header-profile-img" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
				                            <circle cx="12" cy="7" r="5" fill="#E2E8F0"/>
				                            <path d="M3 19c0-3.314 4.03-6 9-6s9 2.686 9 6v1H3v-1z" fill="#E2E8F0"/>
				                        </svg>
									</c:otherwise>
								</c:choose>
							</c:when>                        
                        </c:choose>
                            
                        </div>
                        <div class="chat-message">
                            <div class="chat-name">${ room.roomName }</div>
                            <div class="chat-text">${ room.lastMessageContent }</div>
                        </div>
                        <c:if test="${room.roomType == 'G'}">
				             <span class="member-count">(${room.memberCount})</span> 
				        </c:if>
                    </div>
                	</c:forEach>
                    
                </div>
            </div>
	        <div id="chat-placeholder">
	            <span class="material-icons" id="chat-placeholder-icon">chat</span>
	            <p style="font-size: 16px;">대화 상대를 선택해주세요</p>
	        </div>
	        
                <div class="chat-main hidden">

                    <%-- ========= 채팅방 메인 헤더 추가 시작 ========= --%>
                    <div class="chat-main-header" >
                        <div class="chat-header-left">
                            <%-- 1:1 채팅 시 상대방 프로필 이미지 (옵션) --%>
                            <div class="header-avatar"></div>
                            <div class="chat-header-info">
                                <%-- 채팅방 이름 또는 상대방 이름 표시될 곳 --%>
                                <span class="chat-header-title"></span>
                                <%-- 상태(온라인/오프라인) 또는 인원수 표시될 곳 --%>
                                <span class="chat-header-subtitle">
                                    <%-- 1:1 채팅 시 온라인 상태 표시 (초록색 점) --%>
                                        <span class="status-dot online"></span>
                                    <%-- 단체 채팅 시 인원수 표시 (예: 아이콘 + 숫자) --%>
                                    </span>
                            </div>
                        </div>
                        <div class="chat-header-right">
                            <%-- 오른쪽 아이콘 버튼들 --%>
                            <button type="button" class="material-icons">call</button>
                            <button type="button" class="material-icons">search</i></button>
                            <button type="button" class="material-icons">more_vert</button>
                        </div>
                    </div>
                    <%-- ========= 채팅방 메인 헤더 추가 끝 =========== --%>

                    <div class="message-list">
                        <!-- 사용자(파벨 쿠나) 메시지 - 오른쪽 정렬 -->
                        <div class="message user-message">
                            <!-- 
                                <div class="message-content">
                                    <div class="message-header">
                                        <span class="message-time">09:32</span>
                                        <span class="message-name">파벨 쿠나</span>
                                    </div>
                                    <div class="message-bubble user-bubble">
                                        여러분, 방금 <span class="badge">개발</span> 브랜치에 새 커밋을 푸시했어요. 확인 후 의견 부탁드립니다.
                                    </div>
                                </div>
                                <div class="avatar">
                                    <img src="/api/placeholder/32/32" alt="파벨 쿠나">
                                </div>
                                -->
                        </div>

                    </div>

                    <%-- 메시지 입력창 등 추가 ... --%>
                    <div class="message-input-area">
                        <input type="text" placeholder="메시지를 입력하세요...">
                        <button>전송</button>
                    </div>

                </div>
            
        </div>
    

    </div>

        <!-- 채팅 만들기 Modal -->
        <div class="modal fade" id="createChatModal" tabindex="-1" aria-labelledby="createChatModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createChatModalLabel">채팅 만들기</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="createChatForm">
                            <!-- 채팅 유형 선택 -->
                            <div class="chat-type-selector">
                                <label class="form-label">채팅 유형</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="chatType" id="oneToOneChat" value="oneToOne" checked>
                                    <label class="form-check-label" for="oneToOneChat">
                                        1:1 채팅
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="chatType" id="groupChat" value="group">
                                    <label class="form-check-label" for="groupChat">
                                        단체 채팅방
                                    </label>
                                </div>
                            </div>
                            
                            <!-- 단체 채팅방 이름 설정 (단체 채팅 선택 시에만 표시) -->
                            <div class="mb-3 group-name-input" id="groupNameContainer">
                                <label for="groupName" class="form-label">채팅방 이름</label>
                                <input type="text" class="form-control" id="groupName" placeholder="채팅방 이름을 입력하세요">
                            </div>
                            
                            <!-- 대화 상대 검색 -->
                            <!-- 부서별 대화 상대 목록으로 수정 -->
                            <div class="mb-3">
                                <label class="form-label">대화 상대 선택</label>
                                <div class="accordion department-accordion" id="departmentAccordion">
                                    <!-- 인사팀 -->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="hr-heading">
                                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#hr-collapse" aria-expanded="true" aria-controls="hr-collapse">
                                                인사팀
                                            </button>
                                        </h2>
                                        <div id="hr-collapse" class="accordion-collapse collapse show" aria-labelledby="hr-heading" data-bs-parent="#departmentAccordion">
                                            <div class="accordion-body">
                                                <div class="participant-list">
                                                    <div class="participant-item">
                                                        <input type="checkbox" class="form-check-input participant-checkbox" id="hr-participant1" data-department="인사팀">
                                                        <div class="participant-avatar">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <label class="participant-name" for="hr-participant1">김인사</label>
                                                    </div>
                                                    <div class="participant-item">
                                                        <input type="checkbox" class="form-check-input participant-checkbox" id="hr-participant2" data-department="인사팀">
                                                        <div class="participant-avatar">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <label class="participant-name" for="hr-participant2">박인사</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- 재무팀 -->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="finance-heading">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#finance-collapse" aria-expanded="false" aria-controls="finance-collapse">
                                                재무팀
                                            </button>
                                        </h2>
                                        <div id="finance-collapse" class="accordion-collapse collapse" aria-labelledby="finance-heading" data-bs-parent="#departmentAccordion">
                                            <div class="accordion-body">
                                                <div class="participant-list">
                                                    <div class="participant-item">
                                                        <input type="checkbox" class="form-check-input participant-checkbox" id="finance-participant1" data-department="재무팀">
                                                        <div class="participant-avatar">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <label class="participant-name" for="finance-participant1">이재무</label>
                                                    </div>
                                                    <div class="participant-item">
                                                        <input type="checkbox" class="form-check-input participant-checkbox" id="finance-participant2" data-department="재무팀">
                                                        <div class="participant-avatar">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <label class="participant-name" for="finance-participant2">최재무</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- 마케팅팀 -->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="marketing-heading">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#marketing-collapse" aria-expanded="false" aria-controls="marketing-collapse">
                                                마케팅팀
                                            </button>
                                        </h2>
                                        <div id="marketing-collapse" class="accordion-collapse collapse" aria-labelledby="marketing-heading" data-bs-parent="#departmentAccordion">
                                            <div class="accordion-body">
                                                <div class="participant-list">
                                                    <div class="participant-item">
                                                        <input type="checkbox" class="form-check-input participant-checkbox" id="marketing-participant1" data-department="마케팅팀">
                                                        <div class="participant-avatar">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <label class="participant-name" for="marketing-participant1">정마케팅</label>
                                                    </div>
                                                    <div class="participant-item">
                                                        <input type="checkbox" class="form-check-input participant-checkbox" id="marketing-participant2" data-department="마케팅팀">
                                                        <div class="participant-avatar">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <label class="participant-name" for="marketing-participant2">한마케팅</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- 개발팀 -->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="dev-heading">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#dev-collapse" aria-expanded="false" aria-controls="dev-collapse">
                                                개발팀
                                            </button>
                                        </h2>
                                        <div id="dev-collapse" class="accordion-collapse collapse" aria-labelledby="dev-heading" data-bs-parent="#departmentAccordion">
                                            <div class="accordion-body">
                                                <div class="participant-list">
                                                    <div class="participant-item">
                                                        <input type="checkbox" class="form-check-input participant-checkbox" id="dev-participant1" data-department="개발팀">
                                                        <div class="participant-avatar">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <label class="participant-name" for="dev-participant1">강개발</label>
                                                    </div>
                                                    <div class="participant-item">
                                                        <input type="checkbox" class="form-check-input participant-checkbox" id="dev-participant2" data-department="개발팀">
                                                        <div class="participant-avatar">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <label class="participant-name" for="dev-participant2">서개발</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- 영업팀 -->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="sales-heading">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sales-collapse" aria-expanded="false" aria-controls="sales-collapse">
                                                영업팀
                                            </button>
                                        </h2>
                                        <div id="sales-collapse" class="accordion-collapse collapse" aria-labelledby="sales-heading" data-bs-parent="#departmentAccordion">
                                            <div class="accordion-body">
                                                <div class="participant-list">
                                                    <div class="participant-item">
                                                        <input type="checkbox" class="form-check-input participant-checkbox" id="sales-participant1" data-department="영업팀">
                                                        <div class="participant-avatar">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <label class="participant-name" for="sales-participant1">조영업</label>
                                                    </div>
                                                    <div class="participant-item">
                                                        <input type="checkbox" class="form-check-input participant-checkbox" id="sales-participant2" data-department="영업팀">
                                                        <div class="participant-avatar">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <label class="participant-name" for="sales-participant2">임영업</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" id="createChatBtn">채팅방 만들기</button>
                    </div>
                </div>
            </div>
        </div>

    <!-- Bootstrap JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    

    <script>
        //+ 버튼 클릭 시 모달 열기
        document.getElementById('addChatBtn').addEventListener('click', function() {
           const modal = new bootstrap.Modal(document.getElementById('createChatModal'));
           modal.show();
       });
        
        // 채팅 유형 변경 시 그룹 이름 입력란 표시/숨김
        document.querySelectorAll('input[name="chatType"]').forEach(function(radio) {
            radio.addEventListener('change', function() {
                const groupNameContainer = document.getElementById('groupNameContainer');
                if (this.value === 'group') {
                    groupNameContainer.style.display = 'block';
                } else {
                    groupNameContainer.style.display = 'none';
                }
            });
        });
        
        // 대화 상대 검색 기능
        document.getElementById('participantSearch').addEventListener('input', function() {
            const searchText = this.value.toLowerCase();
            const participants = document.querySelectorAll('.participant-item');
            
            participants.forEach(function(item) {
                const name = item.querySelector('.participant-name').textContent.toLowerCase();
                if (name.includes(searchText)) {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
            });
        });
        
        // 채팅방 만들기 버튼 클릭 시 실행될 함수
        document.getElementById('createChatBtn').addEventListener('click', function() {
            // 선택된 채팅 유형 확인
            const chatType = document.querySelector('input[name="chatType"]:checked').value;
            
            // 선택된 참가자 확인
            const selectedParticipants = [];
            document.querySelectorAll('.participant-checkbox:checked').forEach(function(checkbox) {
                selectedParticipants.push(checkbox.nextElementSibling.nextElementSibling.textContent);
            });
            
            // 그룹명 가져오기 (그룹 채팅인 경우)
            let groupName = '';
            if (chatType === 'group') {
                groupName = document.getElementById('groupName').value;
                if (!groupName.trim()) {
                    alert('채팅방 이름을 입력해주세요.');
                    return;
                }
            }
            
            // 참가자 선택 확인
            if (selectedParticipants.length === 0) {
                alert('최소 한 명 이상의 대화 상대를 선택해주세요.');
                return;
            }
            
            // 1:1 채팅인 경우 참가자는 한 명만 선택 가능
            if (chatType === 'oneToOne' && selectedParticipants.length > 1) {
                alert('1:1 채팅은 한 명의 대화 상대만 선택할 수 있습니다.');
                return;
            }
            
            // 여기서 채팅방 생성 로직이 들어갈 수 있습니다.
            // 모달 닫기
            const modal = bootstrap.Modal.getInstance(document.getElementById('createChatModal'));
            modal.hide();
            
            // 간단한 성공 메시지 표시
            alert(chatType === 'group' 
                ? `'${groupName}' 단체 채팅방이 생성되었습니다.` 
                : `${selectedParticipants[0]}님과의 1:1 채팅방이 생성되었습니다.`);
        });

        // 대화 상대 검색 기능 업데이트 - 부서별 검색 지원
document.getElementById('participantSearch').addEventListener('input', function() {
    const searchText = this.value.toLowerCase();
    const accordionItems = document.querySelectorAll('.department-accordion .accordion-item');
    
    // 모든 아코디언 아이템을 순회
    accordionItems.forEach(function(accordionItem) {
        const participantItems = accordionItem.querySelectorAll('.participant-item');
        let hasVisibleParticipants = false;
        
        // 각 참가자 아이템 검색
        participantItems.forEach(function(item) {
            const name = item.querySelector('.participant-name').textContent.toLowerCase();
            if (name.includes(searchText)) {
                item.style.display = 'flex';
                hasVisibleParticipants = true;
            } else {
                item.style.display = 'none';
            }
        });
        
        // 표시할 참가자가 없는 부서는 숨김
        if (hasVisibleParticipants || searchText === '') {
            accordionItem.style.display = '';
            
            // 검색어가 있을 때는 모든 부서를 펼쳐서 보여줌
            if (searchText !== '') {
                const collapseElement = accordionItem.querySelector('.accordion-collapse');
                const bootstrapCollapse = new bootstrap.Collapse(collapseElement, {
                    toggle: false
                });
                bootstrapCollapse.show();
            }
        } else {
            accordionItem.style.display = 'none';
        }
            });
        });

        // 채팅방 만들기 버튼 클릭 시 실행될 함수 업데이트
        document.getElementById('createChatBtn').addEventListener('click', function() {
            // 선택된 채팅 유형 확인
            const chatType = document.querySelector('input[name="chatType"]:checked').value;
            
            // 선택된 참가자 확인 - 부서 정보 포함
            const selectedParticipants = [];
            document.querySelectorAll('.participant-checkbox:checked').forEach(function(checkbox) {
                const name = checkbox.nextElementSibling.nextElementSibling.textContent;
                const department = checkbox.getAttribute('data-department') || '기타';
                selectedParticipants.push({
                    name: name,
                    department: department
                });
            });
            
            // 그룹명 가져오기 (그룹 채팅인 경우)
            let groupName = '';
            if (chatType === 'group') {
                groupName = document.getElementById('groupName').value;
                if (!groupName.trim()) {
                    alert('채팅방 이름을 입력해주세요.');
                    return;
                }
            }
            
            // 참가자 선택 확인
            if (selectedParticipants.length === 0) {
                alert('최소 한 명 이상의 대화 상대를 선택해주세요.');
                return;
            }
            
            // 1:1 채팅인 경우 참가자는 한 명만 선택 가능
            if (chatType === 'oneToOne' && selectedParticipants.length > 1) {
                alert('1:1 채팅은 한 명의 대화 상대만 선택할 수 있습니다.');
                return;
            }
            
            // 여기서 채팅방 생성 로직이 들어갈 수 있습니다.
            // 모달 닫기
            const modal = bootstrap.Modal.getInstance(document.getElementById('createChatModal'));
            modal.hide();
            
            // 간단한 성공 메시지 표시 - 부서 정보 포함
            if (chatType === 'group') {
                alert(`'${groupName}' 단체 채팅방이 생성되었습니다.`);
            } else {
                const participant = selectedParticipants[0];
                alert(`${participant.department} ${participant.name}님과의 1:1 채팅방이 생성되었습니다.`);
            }
        });


    </script>



    <script>
        const pageContextPath = '${pageContext.request.contextPath}';
        const loginUserEmpNo = '${loginUser.empNo}';
    </script>


    
    <script>

    

    $(document).ready(function(){

        // --- jQuery 객체 및 전역 변수 선언 ---
        const $chatList = $('.chat-list'); // 왼쪽 채팅 목록 div
        const $messageList = $('.message-list'); // 오른쪽 메시지 표시 div
        const $chatHeaderTitle = $('.chat-header-title'); // 헤더 제목 span
        const $chatHeaderSubtitle = $('.chat-header-subtitle'); // 헤더 부제목/상태 span
        const $chatHeaderAvatar = $('.header-avatar'); // 헤더 아바타 img (필요시)
        const $messageInput = $('.message-input-area input[type="text"]'); // 메시지 입력 필드
        const $sendButton = $('.message-input-area button'); // 전송 버튼
       	
       	// 안전하게 값 가져오기 (JSP 변수가 없을 경우 대비)
        const contextPath = (typeof pageContextPath !== 'undefined') ? pageContextPath : '';
        const currentUserId = (typeof loginUserEmpNo !== 'undefined') ? String(loginUserEmpNo) : '';

        // --- WebSocket 관련 변수 ---
        let stompClient = null;
        let currentRoomSubscription = null; // 현재 구독 정보를 저장할 변수
        let selectedRoomNo = null; // 현재 선택된 채팅방 번호 저장 변수

        // --- 초기 값 확인 (디버깅용) ---
        console.log('Context Path:', contextPath);
        console.log('Current User ID:', currentUserId);



        // --- WebSocket 연결 함수 정의 ---
        function connectWebSocket() {
            const socket = new SockJS(contextPath + '/ws-stomp');
            stompClient = Stomp.over(socket);

            stompClient.connect({}, function (frame) {
                console.log('Connected: ' + frame);
                // 연결 성공 후 초기 작업 (필요시)
            }, function(error) {
                console.error('STOMP error:', error);
                alert("WebSocket 연결에 실패했습니다. 페이지를 새로고침 해주세요.");
            });
        }
            



        // --- 채팅방 정보 로드 함수 정의 ---
        function loadChatRoomDetails(roomNo) {
            const path = (typeof contextPath !== 'undefined') ? contextPath : '';
            console.log("Request URL:", path + "/chatMessage.ch/" + roomNo);

            // 이전 방 구독 해지
            if (currentRoomSubscription) {
                currentRoomSubscription.unsubscribe();
                console.log('Unsubscribed from previous room.');
                currentRoomSubscription = null; // 초기화
            }

            $.ajax({
                url: path + "/chatMessage.ch/" + roomNo,
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    console.log('Received chat history:', data);
                    const roomInfo = data.room;
                    const messages = data.messages;
                    // 1. 채팅방 헤더 업데이트
                    updateChatHeader(roomInfo);
                    // console.log(roomInfo);
                    // 2. 기존 메시지 목록 지우기
                    $messageList.empty();
                    // 3. 받은 메시지 목록으로 화면 다시 그리기
                    if (messages && messages.length > 0) {
                        $.each(messages, function(index, message) {
                            displayChatMessage(message);
                        });
                        $messageList.scrollTop($messageList[0].scrollHeight);
                    } else {
                        $messageList.append('<div class="no-messages">대화 내용이 없습니다.</div>');
                    }

                    // 4. 새 채팅방 토픽 구독
                    if (stompClient && stompClient.connected) {
                        const topic = '/topic/chat/room/' + roomNo;
                        console.log('Subscribing to:', topic);
                        currentRoomSubscription = stompClient.subscribe(topic, function (chatMessage) {
                            console.log('Message received:', chatMessage);
                            try {
                                const messageObject = JSON.parse(chatMessage.body);
                                displayChatMessage(messageObject);
                                $messageList.scrollTop($messageList[0].scrollHeight);
                            } catch (e) {
                                console.error("Error parsing received message:", e, chatMessage.body);
                            }
                        });
                    } else {
                        console.error("STOMP client not connected. Cannot subscribe.");
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('Error fetching chat history:', textStatus, errorThrown);
                    console.log('Status code:', jqXHR.status);
                    console.log('Response text:', jqXHR.responseText);
                    $messageList.empty().append('<div class="error-messages">대화 내용을 불러오는 중 오류가 발생했습니다. ('+ jqXHR.status +')</div>');
                }
            });
        }
        


			
				
        // --- 채팅방 헤더 업데이트 함수 정의 ---
        function updateChatHeader(roomInfo) {
            if (!roomInfo) return;
            const path = (typeof contextPath !== 'undefined') ? contextPath : '';
            $chatHeaderTitle.text(roomInfo.roomName);
            let subtitleHTML = '';
            if (roomInfo.roomType === 'P') {
                const isOnline = roomInfo.opponentOnline == 1;
                subtitleHTML = '<span class="status-dot ' + (isOnline ? 'online' : '') + '"></span> ' + (isOnline ? '온라인' : '오프라인');
                // Optional: Update avatar if path exists
                if($chatHeaderAvatar.length > 0 && roomInfo.chatUserImgPath) {
                    $chatHeaderAvatar.html('<img src="' + path + '/' + roomInfo.chatUserImgPath + '" alt="'+ roomInfo.roomName +'">');
                } else if ($chatHeaderAvatar.length > 0) {
                     $chatHeaderAvatar.html(''); // Clear avatar if no image
                }
            } else if (roomInfo.roomType === 'G') {
                subtitleHTML = '<i class="fas fa-users"></i> ' + (roomInfo.memberCount || 0);
                 // Optional: Set default group avatar
                if ($chatHeaderAvatar.length > 0) {
                     $chatHeaderAvatar.html(''); // Clear avatar or set default group icon
                }
            }
            $chatHeaderSubtitle.html(subtitleHTML);
        }
				
				
        // --- 개별 메시지 표시 함수 정의 ---
        function displayChatMessage(message) {
            const path = (typeof contextPath !== 'undefined') ? contextPath : '';
            const currentUserIdString = (typeof currentUserId !== 'undefined') ? String(currentUserId) : '';
            if (!message || currentUserIdString === '') { // 메시지 없거나 사용자 ID 없으면 처리 중단
                console.error("Cannot display message, data missing:", message, currentUserIdString);
                return;
            }

            const isUserMessage = String(message.senderEmpNo) === currentUserIdString;
            const formattedTime = formatMessageTime(message.sendDate);
            const profileImgSrc = path + '/' + (message.senderProfileImgPath || 'resources/images/default_profile.PNG');

            let avatarHtml = '';
            let timeHtmlPart1 = '';
            let timeHtmlPart2 = '';
            const avatarImgHtml = '<img src="' + profileImgSrc + '" alt="' + (message.senderName || '') + '">';
            const avatarDivHtml = '<div class="avatar">' + avatarImgHtml + '</div>';

            if (isUserMessage) { // 내 메시지
                avatarHtml = avatarDivHtml;
                timeHtmlPart1 = '<span class="message-time">' + formattedTime + '</span>';
            } else { // 상대방 메시지
                avatarHtml = avatarDivHtml;
                timeHtmlPart2 = '<span class="message-time">' + formattedTime + '</span>';
            }

            // XSS 방지를 위해 간단한 escape 처리 (textContent 사용)
            const messageBubbleDiv = $('<div>').addClass('message-bubble')
                                            .addClass(isUserMessage ? 'user-bubble' : '')
                                             .text(message.chatContent || ''); // .text() 사용하여 HTML 태그 자동 escape

            const messageHtml =
                '<div class="message ' + (isUserMessage ? 'user-message' : '') + '">' +
                    (!isUserMessage ? avatarHtml : '') +
                    '<div class="message-content">' +
                        '<div class="message-header">' +
                            timeHtmlPart1 +
                            '<span class="message-name">' + (message.senderName || '알 수 없음') + '</span>' +
                            timeHtmlPart2 +
                        '</div>' +
                        $('<div>').append(messageBubbleDiv).html() + // messageBubbleDiv를 HTML 문자열로 변환
                    '</div>' +
                    (isUserMessage ? avatarHtml : '') +
                '</div>';

            $messageList.append(messageHtml);
        }
		


        // --- 메시지 시간 포맷 함수 정의 ---
        function formatMessageTime(sendDate) {
            if (!sendDate) return '';
            try {
                const date = new Date(sendDate);
                if (isNaN(date.getTime())) { // 유효하지 않은 날짜 처리
                     return sendDate; // 원본 문자열 반환
                }
                const hours = String(date.getHours()).padStart(2, '0');
                const minutes = String(date.getMinutes()).padStart(2, '0');
                return hours + ':' + minutes;
            } catch (e) {
                console.error("Error formatting date:", e);
                return sendDate; // 오류 발생 시 원본 반환
            }
        }


            
        // --- 메시지 전송 함수 정의 ---
        function sendMessage() {
            const messageContent = $messageInput.val().trim();

            if (!messageContent) {
                console.warn('Message content is empty. Cannot send.');
                return;
            }
            if (!stompClient || !stompClient.connected) {
                console.error('STOMP client not connected. Cannot send message.');
                alert("서버와 연결되지 않았습니다. 페이지를 새로고침하거나 다시 로그인해주세요.");
                return;
            }
            if (selectedRoomNo == null) {
                console.error('No room selected. Cannot send message.');
                alert("메시지를 보낼 채팅방을 선택해주세요.");
                return;
            }
            if (!currentUserId) {
                console.error('Current user ID is missing. Cannot send message.');
                alert("사용자 정보가 없습니다. 다시 로그인해주세요.");
                return;
            }

            const chatMessage = {
                roomNo: selectedRoomNo,
                senderEmpNo: parseInt(currentUserId), // 서버에서 int로 기대하면 숫자로
                chatContent: messageContent,
                messageType: 'TEXT'
            };

            const destination = "/app/chat/message";

            try {
                stompClient.send(destination, {}, JSON.stringify(chatMessage));
                console.log("Message sent to " + destination, chatMessage);
                $messageInput.val('');
                $messageInput.focus();
            } catch (error) {
                console.error("Error sending message via STOMP:", error);
                alert("메시지 전송 중 오류가 발생했습니다.");
            }
        }
        




            
        // ====================================================
        //          이벤트 핸들러 설정
        // ====================================================

        // 채팅방 목록 클릭 시
        $chatList.on('click', '.chat-item', function() {
            const $clickedItem = $(this);
            const roomNo = $clickedItem.data('roomno');
            console.log('Clicked roomNo:', roomNo);

            if (roomNo != null) { // roomNo가 0일 수도 있으므로 null/undefined 체크
            	
                // Placeholder 영역을 숨깁니다.
                $('#chat-placeholder').hide();
            	
                // 숨겨져 있던 .chat-main 영역을 보여줍니다.
                $('.chat-main').removeClass('hidden'); // 'hidden' 클래스를 제거하여 보이게 함
                
                selectedRoomNo = roomNo; // <--- 현재 선택된 방 번호 업데이트!
                $clickedItem.addClass('active').siblings().removeClass('active');
                loadChatRoomDetails(roomNo);
            } else {
                console.warn("Clicked item does not have a valid roomNo.");
            }
        });




            $sendButton.on('click', function() {
            sendMessage();
        });

        $messageInput.on('keypress', function(e) {
            if (e.key === 'Enter' || e.keyCode === 13) {
                sendMessage();
            }
        });

                    
        // ====================================================
        //          WebSocket 연결 시작 (추천 위치)
        // ====================================================
        connectWebSocket();
        // ====================================================
        

    });
    </script>

</body>
</html>