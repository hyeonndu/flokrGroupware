<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- JSP 변수를 JavaScript에서 사용하기 위해 설정 (스크립트보다 먼저 정의) --%>
<c:set var="contextPathJsp" value="${pageContext.request.contextPath}"/>
<c:set var="loginUserEmpNoJsp" value="${loginUser.empNo}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flokr</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chatList.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<style>
    /* 모달 내 참여자 목록 스타일 */
    .participant-item {
      display: flex;
      align-items: center; /* 세로 중앙 정렬 */
      padding: 8px 10px;
      border-radius: 4px;
      transition: background-color 0.2s;
    }

    .participant-item:hover {
      background-color: rgba(0,123,255,0.05);
    }

    .participant-checkbox {
      margin-right: 10px;
    }

    /* 프로필 이미지와 아이콘을 담는 컨테이너 */
    .participant-avatar {
      width: 32px; /* 원하는 크기로 조절 */
      height: 32px; /* 원하는 크기로 조절 */
      border-radius: 50%; /* 원형으로 표시 */
      overflow: hidden; /* 원형 밖으로 나가는 이미지/아이콘 숨김 */
      background-color: #e9ecef; /* 기본 배경색 */
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 10px;
      flex-shrink: 0; /* 공간이 부족해도 줄어들지 않도록 */
    }

    /* 프로필 이미지 자체 스타일 */
    .participant-avatar img {
        display: block; /* 이미지를 블록 요소로 만들어 부모 컨테이너에 맞춤 */
        width: 100%;
        height: 100%;
        object-fit: cover; /* 이미지 비율 유지하며 컨테이너에 꽉 채움 */
    }

    /* 기본 사용자 아이콘 스타일 */
    .participant-avatar i {
      font-size: 1.5em; /* 아이콘 크기 조절 */
      color: #888; /* 아이콘 색상 */
    }

    /* 부서 배지 */
    .department-badge {
      font-size: 11px;
      padding: 2px 6px;
      border-radius: 10px;
      background-color: #e9ecef;
      color: #495057;
      margin-left: 8px;
      flex-shrink: 0; /* 공간 부족 시 줄어들지 않도록 */
    }

    /* 부서 아코디언 헤더 내에서 배지가 이름과 너무 붙지 않도록 */
    .department-accordion .accordion-button {
        display: flex; /* 플렉스 박스로 만듦 */
        align-items: center; /* 세로 중앙 정렬 */
        justify-content: space-between; /* 부서 이름과 배지를 양 끝으로 정렬 */
        width: 100%; /* 버튼 너비 100% */
        text-align: left; /* 텍스트 왼쪽 정렬 */
    }

    .department-accordion .accordion-button .department-name {
        flex-grow: 1; /* 부서 이름이 남은 공간 차지 */
        margin-right: 10px; /* 부서 이름과 배지 사이 간격 */
    }


    /* ... (나머지 스타일 유지) ... */
</style>

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
										<img src="${pageContext.request.contextPath}/resources/images/default_profile.PNG" alt="default_profile">
									</c:otherwise>
								</c:choose>
							</c:when>
                            <c:when test="${ room.roomType == 'G' }">
                                <span class="material-icons" id="roomList-icon">groups</span>
                            </c:when>
                            <c:otherwise>
                                <%-- 기타 유형 기본 아이콘 --%>
                                <i class="fas fa-comment"></i>
                            </c:otherwise>
                        </c:choose>

                        </div>
                        <div class="chat-message">
                            <div class="chat-name">${ room.roomName }</div>
                            <div class="chat-text">${ room.lastMessageContent }</div>
                        </div>
                        <c:if test="${room.unreadCount > 0}"> <%-- 안 읽은 메시지 수가 0보다 클 경우에만 표시 --%>
                            <span class="unread-count">${room.unreadCount}</span> <%-- 안 읽은 메시지 수를 표시할 새로운 span --%>
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
                            <div class="header-avatar">
                                <%-- 아바타 이미지가 로드될 곳 --%>
                            </div>
                            <div class="chat-header-info">
                                <%-- 채팅방 이름 또는 상대방 이름 표시될 곳 --%>
                                <span class="chat-header-title"></span>
                                <%-- 상태(온라인/오프라인) 또는 인원수 표시될 곳 --%>
                                <span class="chat-header-subtitle">
                                    <%-- 1:1 채팅 시 온라인 상태 표시 (초록색 점) --%>
                                    <%-- <span class="status-dot online"></span> 온라인 --%>
                                    <%-- 단체 채팅 시 인원수 표시 (예: 아이콘 + 숫자) --%>
                                    <%-- <i class="fas fa-users"></i> 3 --%>
                                </span>
                            </div>
                        </div>
                        <div class="chat-header-right">
                            <%-- 오른쪽 아이콘 버튼들 --%>
                            <button type="button" class="material-icons">call</button>
                            <button type="button" class="material-icons">search</button>
                            <button type="button" class="material-icons">more_vert</button>
                        </div>
                    </div>
                    <%-- ========= 채팅방 메인 헤더 추가 끝 =========== --%>

                    <div class="message-list">
                        </div>

                    <%-- 메시지 입력창 등 추가 ... --%>
                    <div class="message-input-area">
                        <input type="text" placeholder="메시지를 입력하세요...">
                        <button>전송</button>
                    </div>

                </div>

        </div>


    </div>

        <div class="modal fade" id="createChatModal" tabindex="-1" aria-labelledby="createChatModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createChatModalLabel">채팅 만들기</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="createChatForm">
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

                            <div class="mb-3 group-name-input" id="groupNameContainer" style="display: none;">
                                <label for="groupName" class="form-label">채팅방 이름</label>
                                <input type="text" class="form-control" id="groupName" placeholder="채팅방 이름을 입력하세요">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">대화 상대 선택</label>
                                <%-- 검색 입력 필드 추가 --%>
                                <div class="search-input mb-3">
                                    <span class="material-icons">search</span>
                                    <input type="text" id="participantSearch" placeholder="이름, 사번, 부서 검색">
                                </div>
                                <div class="accordion department-accordion" id="departmentAccordion">
                                    <%-- 부서별 직원 목록이 여기에 동적으로 로드됩니다. --%>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>


    <script>
        // JSP 변수를 JavaScript 변수로 가져오기 (스크립트 상단에 위치)
        const contextPath = "${contextPathJsp}"; // JSP 변수 값을 JavaScript 변수에 할당
        const currentUserId = "${loginUserEmpNoJsp}"; // JSP 변수 값을 JavaScript 변수에 할당

        // 안전하게 값 가져오기 (JSP 변수가 없을 경우 또는 빈 값일 경우 대비)
        // const contextPath = (typeof contextPathJsp !== 'undefined' && contextPathJsp != null && contextPathJsp.trim() !== '') ? contextPathJsp : '';
        // const currentUserId = (typeof loginUserEmpNoJsp !== 'undefined' && loginUserEmpNoJsp != null && String(loginUserEmpNoJsp).trim() !== '') ? String(loginUserEmpNoJsp) : '';


        // $(document).ready() 블록 안으로 모든 전역 변수 및 함수 정의 이동
        $(document).ready(function(){

            // --- jQuery 객체 및 전역 변수 선언 ---
            // HTML 요소와 연결되는 jQuery 객체들을 미리 선언하여 재사용성을 높입니다.
            const $chatList = $('.chat-list'); // 왼쪽 채팅 목록 div
            const $messageList = $('.message-list'); // 오른쪽 메시지 표시 div
            const $chatMainArea = $('.chat-main'); // 메시지, 입력창 등을 포함하는 메인 영역
            const $placeholderArea = $('#chat-placeholder'); // 초기 상태에서 표시되는 placeholder 영역

            const $chatHeaderTitle = $('.chat-header-title'); // 헤더 제목 span
            const $chatHeaderSubtitle = $('.chat-header-subtitle'); // 헤더 부제목/상태 span
            const $chatHeaderAvatarArea = $('.header-avatar'); // 헤더 아바타 이미지를 담는 div

            const $messageInput = $('.message-input-area input[type="text"]'); // 메시지 입력 필드
            const $sendButton = $('.message-input-area button'); // 메시지 전송 버튼

            // --- WebSocket 관련 변수 ---
            let stompClient = null; // STOMP 클라이언트 인스턴스
            let currentRoomSubscription = null; // 현재 구독 중인 채팅방 토픽 구독 객체
            let selectedRoomNo = null; // 현재 사용자가 선택/보고 있는 채팅방 번호

            // --- 초기 값 확인 (디버깅용) ---
            console.log('Context Path:', contextPath);
            console.log('Current User ID:', currentUserId);


            // --- WebSocket 연결 함수 정의 ---
            // 페이지 로드 시 WebSocket 서버와 연결을 시작합니다.
            function connectWebSocket() {
                // SockJS 연결 URL 설정 (contextPath 포함)
                const socketUrl = contextPath + '/ws-stomp';
                console.log("Connecting to WebSocket:", socketUrl);
                const socket = new SockJS(socketUrl);
                stompClient = Stomp.over(socket);

                // STOMP 연결 시도
                stompClient.connect({}, function (frame) {
                    console.log('WebSocket Connected: ' + frame);
                    // 연결 성공 후 초기 작업 (필요시)
                    // 예: 사용자 상태를 온라인으로 업데이트 등
                    // TODO: 연결 성공 시 필요한 초기 구독 (예: 개인 알림 채널 구독)

                    // --- 사용자별 안 읽은 메시지 알림 토픽 구독 ---
                    // 백엔드에서 이 토픽으로 해당 사용자에게 안 읽은 메시지 수를 보낸다고 가정
                    // 토픽 경로는 백엔드 구현에 따라 달라질 수 있습니다.
                    const unreadTopic = '/topic/user/unreadNotification/' + currentUserId; // 예시 토픽
                    console.log('Subscribing to unread notification topic:', unreadTopic);

                    stompClient.subscribe(unreadTopic, function (notificationMessage) {
                        console.log('Unread notification received:', notificationMessage.body);
                        try {
                            // 백엔드에서 보낸 메시지 (JSON 형태)를 파싱
                            // 예시: { "roomNo": 123, "unreadCount": 5 }
                            const notification = JSON.parse(notificationMessage.body);

                            // 파싱된 알림 데이터 처리 함수 호출
                            handleUnreadNotification(notification);

                        } catch (e) {
                            console.error("Error processing unread notification message:", e, notificationMessage.body);
                        }
                    });
                    // --- 안 읽은 메시지 알림 구독 끝 ---

                    // TODO: 연결 성공 시 필요한 다른 초기 구독 (예: 개인 알림 채널 구독 - 필요시)
                    // 예: stompClient.subscribe('/topic/user/' + currentUserId + '/generalNotifications', function(msg){...});

                }, function(error) {
                    console.error('STOMP connection error:', error);
                    // 연결 실패 시 사용자에게 알림
                    // alert("WebSocket 연결에 실패했습니다. 페이지를 새로고침 해주세요.");
                    // 연결 재시도 로직 등을 추가할 수 있습니다.
                });
            }

            // --- 새로운 함수: 안 읽은 메시지 알림 처리 ---
            // 백엔드로부터 받은 안 읽은 메시지 수 업데이트 알림을 처리하고 UI에 반영합니다.
            function handleUnreadNotification(notification) {
                // notification 객체는 백엔드에서 보낸 데이터 (예: { roomNo: 123, unreadCount: 5 })
                const roomNo = notification.roomNo;
                const unreadCount = notification.unreadCount;

                // 데이터 유효성 검사
                if (roomNo == null || unreadCount == null || isNaN(roomNo) || isNaN(unreadCount)) {
                    console.warn("Received invalid unread notification data:", notification);
                    return;
                }

                // ** 현재 사용자가 알림이 온 방을 보고 있는지 확인 (중요!) **
                // 현재 보고 있는 방이라면 이미 메시지가 추가되고 뱃지가 제거되었을 것이므로 업데이트하지 않습니다.
                if (String(roomNo) === String(selectedRoomNo)) {
                    console.log("Received unread notification for the currently viewed room. Ignoring UI update.");
                    // 하지만 백엔드 로직에 따라, 현재 방을 보고 있더라도 새 메시지 도착 시 알림을 보낼 수 있습니다.
                    // 이 경우, 이 분기 안에서 메시지 목록에 새 메시지를 추가하는 등의 로직이 필요할 수 있습니다.
                    // 현재 displayChatMessage 함수는 selectedRoomNo와 비교하여 현재 방 메시지만 표시하므로 이 부분은 이미 처리됩니다.
                    return; // 현재 방이면 목록 뱃지 업데이트는 스킵
                }


                // 알림이 온 채팅방의 목록 아이템을 찾습니다.
                const $targetChatItem = $chatList.find('.chat-item[data-roomno="' + roomNo + '"]');

                if ($targetChatItem.length > 0) {
                    // 해당 아이템을 찾았습니다. 안 읽은 메시지 수 뱃지를 업데이트합니다.

                    // 안 읽은 메시지 수 뱃지 span (.unread-count)을 찾습니다.
                    let $unreadCountSpan = $targetChatItem.find('.unread-count');

                    if (unreadCount > 0) {
                        // 안 읽은 메시지 수가 0보다 크면 뱃지를 표시하거나 업데이트합니다.
                        if ($unreadCountSpan.length === 0) {
                            // 뱃지 span이 없으면 새로 생성합니다.
                            $unreadCountSpan = $('<span>').addClass('unread-count');
                            // 어디에 추가할지 결정해야 합니다. 보통 chat-item의 오른쪽 끝에 위치합니다.
                            // 예시: .chat-message div 뒤에 추가 (CSS로 위치 조정 필요)
                            $targetChatItem.append($unreadCountSpan);
                            console.log('Created unread-count span for room', roomNo);

                            // Optional: 새 메시지가 오면 해당 아이템을 목록 최상단으로 이동 (자주 사용되는 UI 패턴)
                            // $targetChatItem.prependTo($chatList); // $chatList의 첫 번째 자식으로 이동
                        }
                        // 뱃지 텍스트를 업데이트합니다.
                        $unreadCountSpan.text(unreadCount);
                        console.log('Updated unread count for room', roomNo, 'to', unreadCount);

                    } else {
                        // 안 읽은 메시지 수가 0이면 뱃지를 숨기거나 제거합니다.
                        if ($unreadCountSpan.length > 0) {
                            $unreadCountSpan.remove(); // 또는 $unreadCountSpan.hide(); 로 숨기기
                            console.log('Removed unread count span for room', roomNo);
                        }
                        // Optional: 안 읽은 메시지 수가 0이 되면 목록 순서 변경을 안 하거나 특정 규칙에 따를 수 있습니다.
                    }

                    // TODO: 백엔드 알림 메시지에 마지막 메시지 내용과 시간 정보가 포함되어 있다면,
                    // 목록 아이템의 마지막 메시지 내용과 시간도 업데이트하는 로직 추가 (선택 사항)
                    // if (notification.lastMessageContent) { $targetChatItem.find('.chat-text').text(notification.lastMessageContent); }
                    // if (notification.lastMessageTime) { /* 시간 업데이트 로직 */ }

                    console.log('Unread notification processed for room', roomNo, 'New count:', unreadCount);

                } else {
                    // 알림이 온 방이 현재 화면의 채팅 목록에 없는 경우 처리 (드문 경우)
                    // 예: 새로 생성된 방이거나, 필터링 등으로 숨겨진 방일 수 있습니다.
                    // 필요에 따라 해당 방 정보를 백엔드에서 가져와 목록에 추가하는 로직이 필요할 수 있습니다.
                    console.warn("Received unread notification for room not currently in the list:", roomNo);
                }
            }




            // --- 특정 채팅방 상세 정보 및 메시지 로드 함수 정의 ---
            // 채팅 목록 항목 클릭 시 또는 새 채팅방 생성 후 호출됩니다.
            function loadChatRoomDetails(roomNo, listItemMemberCount = null) {
                console.log("Loading chat room details for roomNo:", roomNo, "List item count (from list):", listItemMemberCount);
                const path = contextPath;

                // 현재 보고 있는 방 번호 업데이트
                selectedRoomNo = roomNo;

                // 이전 방 구독 해제 (새로운 방을 로드하기 전에)
                if (stompClient && stompClient.connected && currentRoomSubscription) {
                    currentRoomSubscription.unsubscribe();
                    console.log('Unsubscribed from previous room.');
                    currentRoomSubscription = null; // 구독 객체 초기화
                }

                // AJAX를 통해 해당 채팅방의 정보와 메시지 목록을 가져옵니다.
                $.ajax({
                    url: path + "/chatMessage.ch/" + roomNo, // ChatController의 해당 매핑
                    type: 'GET',
                    dataType: 'json', // 서버 응답을 JSON으로 기대
                    success: function(data) {
                        console.log('Received chat room details and history:', data);
                        const roomInfo = data.room;
                        const messages = data.messages;

                        // 1. 채팅방 헤더 (이름, 아바타, 상태/인원수) 업데이트
                        updateChatHeader(roomInfo, listItemMemberCount);

                        // 2. 기존 메시지 목록 지우기
                        $messageList.empty();

                        // 3. 받은 메시지 목록으로 화면 다시 그리기
                        if (messages && Array.isArray(messages) && messages.length > 0) {
                            $.each(messages, function(index, message) {
                                displayChatMessage(message);
                            });
                            // 메시지 로드 후 스크롤 최하단으로 이동
                            $messageList.scrollTop($messageList[0].scrollHeight);
                        } else {
                            $messageList.append('<div class="no-messages" style="text-align: center; color: #aaa; padding: 20px;">대화 내용이 없습니다.</div>');
                        }

                        // 4. 현재 채팅방 토픽 구독
                        if (stompClient && stompClient.connected) {
                            const topic = '/topic/chat/room/' + roomNo;
                            console.log('Subscribing to:', topic);
                            currentRoomSubscription = stompClient.subscribe(topic, function (chatMessage) {
                                console.log('Message received from WebSocket:', chatMessage.body);
                                try {
                                    const messageObject = JSON.parse(chatMessage.body);
                                    // 현재 보고 있는 방의 메시지만 표시
                                    // 수신된 메시지의 roomNo와 현재 선택된 roomNo가 같은지 확인 (숫자 또는 문자열 비교)
                                    if (String(messageObject.roomNo) === String(selectedRoomNo)) {
                                         displayChatMessage(messageObject); // 새 메시지를 화면에 추가
                                         // 새 메시지 수신 시 스크롤 최하단으로 이동
                                        $messageList.scrollTop($messageList[0].scrollHeight);
                                    } else {
                                        console.log("Received message for a different room:", messageObject.roomNo);
                                        // TODO: 다른 방 메시지 수신 시 채팅 목록 업데이트 (예: 해당 채팅방 아이템에 새 메시지 알림 표시)
                                        // 해당 chat-item을 찾아 업데이트하는 로직 필요
                                        const $targetChatItem = $chatList.find('.chat-item[data-roomno="' + messageObject.roomNo + '"]');
                                        if ($targetChatItem.length > 0) {
                                            // 예: 마지막 메시지 업데이트 및 스타일 변경
                                            $targetChatItem.find('.chat-text').text(messageObject.chatContent || '');
                                            // TODO: 새 메시지 알림 (점 표시 등) 기능 추가
                                        }
                                    }

                                } catch (e) {
                                    console.error("Error processing received message:", e, chatMessage.body);
                                }
                            });
                            console.log('Subscribed to room ' + roomNo + ' messages.');
                        } else {
                            console.error("STOMP client not connected. Cannot subscribe to room messages.");
                            // WebSocket 연결이 끊어졌을 경우 재연결 로직 또는 알림 필요
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error('Error fetching chat room details:', textStatus, errorThrown);
                        console.log('Status code:', jqXHR.status);
                        console.log('Response text:', jqXHR.responseText);
                        // 오류 메시지 표시 및 화면 초기화
                        $messageList.empty().append('<div class="error-messages" style="text-align: center; color: red; padding: 20px;">대화 내용을 불러오는 중 오류가 발생했습니다. ('+ jqXHR.status +')</div>');
                        updateChatHeader(null); // 헤더 초기화
                    }
                });
            }

            // --- 채팅방 헤더 업데이트 함수 정의 ---
            // 채팅방 정보 (이름, 아바타, 상태/인원수 등)를 화면에 표시합니다.
            function updateChatHeader(roomInfo, listItemMemberCount = null) {
                const path = contextPath;

                let headerTitle = '채팅방'; // 기본값 (혹시 모를 다른 타입 대비)

                if (roomInfo) { // roomInfo 객체가 유효한 경우에만 처리
                    if (roomInfo.roomType === 'G') {
                        // 단체 채팅인 경우: roomName을 사용하고, 없으면 '단체 채팅방' 등으로 표시
                        headerTitle = roomInfo.roomName || '단체 채팅방'; // 기본값 '단체 채팅방' 등 원하는 문자열로 변경 가능
                    } else if (roomInfo.roomType === 'P') {
                        // 1:1 채팅인 경우:
                        if (roomInfo.roomName) {
                            // 만약 1:1 채팅인데 roomName이 명시적으로 설정되어 있다면 그 이름을 사용
                            headerTitle = roomInfo.roomName;
                        } else {
                            // roomName이 설정되지 않은 1:1 채팅이라면, 상대방의 이름을 사용
                            // roomInfo.chatUserName는 백엔드에서 1:1 상대방 이름 정보를 담아준다고 가정한 필드명입니다.
                            // 실제 필드명이 다르다면 해당 필드명으로 수정해주세요.
                            headerTitle = roomInfo.chatUserName || '1:1 채팅방'; // 상대방 이름이 없을 경우 '1:1 채팅방' 기본값
                        }
                    }
                    // 다른 roomType이 있다면 초기값 '채팅방'이 사용됩니다.
                }

                // 최종 결정된 헤더 타이틀을 화면에 표시
                $chatHeaderTitle.text(headerTitle);


                // --- 부제목 (상태 또는 인원수) 및 아바타 업데이트 ---
                let subtitleHTML = '';
                $chatHeaderAvatarArea.empty(); // 기존 아바타 비우기

                if (roomInfo && roomInfo.roomType === 'P') { // 1:1 채팅
                    // TODO: 1:1 채팅 상대방의 온라인 상태 정보를 받아와서 표시해야 함 (WebSocket 또는 별도 API 필요)
                    const isOnline = false; // 임시로 false 설정 (실제 상태 로직 필요)
                    subtitleHTML = '<span class="status-dot ' + (isOnline ? 'online' : '') + '"></span> ' + (isOnline ? '온라인' : '오프라인');

                    // 1:1 채팅 상대방 프로필 이미지 표시
                    // roomInfo.chatUserImgPath는 ChatRoom VO에 추가된 필드 (Mapper에서 조회)
                    const profileImgSrc = (roomInfo.chatUserImgPath && roomInfo.chatUserImgPath !== 'null') ? path + '/' + roomInfo.chatUserImgPath : path + '/resources/images/default_profile.PNG';
                    $chatHeaderAvatarArea.html('<img src="' + profileImgSrc + '" alt="'+ (roomInfo.roomName || '상대방') +'" onerror="this.onerror=null; this.src=\''+ path + '/resources/images/default_profile.PNG\'">');

                } else if (roomInfo && roomInfo.roomType === 'G') { // 단체 채팅
                    // ** 인원수 표시 로직 수정 **
                    // 1. 서버에서 받은 roomInfo.memberCount 값이 있다면 그 값을 사용
                    // 2. 서버 값이 없다면 (또는 AJAX 성공 전에 임시로 표시하고 싶다면),
                    //    클릭 이벤트에서 넘어온 listItemMemberCount 값을 사용
                    // 3. 둘 다 없다면 기본값 0을 사용

                    const memberCountToDisplay = (listItemMemberCount !== null && !isNaN(listItemMemberCount))
                                 ? listItemMemberCount // 1. 클릭 이벤트에서 가져온 목록 인원수(숫자이고 유효한 경우)를 최우선 사용
                                : ((roomInfo && roomInfo.memberCount !== undefined && roomInfo.memberCount !== null)
                                ? roomInfo.memberCount // 2. 목록 값이 없으면 서버에서 받은 roomInfo.memberCount 값이 있는지 확인하고 사용
                                : 0); // 3. 둘 다 없으면 기본값 0 사용

                    console.log("Update header - Using member count:", memberCountToDisplay, "(Server:", roomInfo?.memberCount, "List:", listItemMemberCount, ")");


                    // roomInfo.memberCount는 ChatRoom VO에 추가된 필드 (Mapper에서 조회)
                    subtitleHTML = '<span class="material-icons" id="roomList-icon" style="font-size: 17px;">person</span> ' + memberCountToDisplay; // 가져온 값을 사용

                    // ... (그룹 아바타 로직) ...
                    // 단체 채팅 기본 아이콘
                    $chatHeaderAvatarArea.html('<span class="material-icons" id="roomList-icon">groups</span>'); // HTML 구조에 맞춰 icon 변경
                    // 아이콘 스타일 조정 (CSS 파일에 추가하는 것이 더 좋지만, 여기서도 가능)
                    // $chatHeaderAvatarArea.find('i').css({ 'font-size': '1.5em', 'color': '#ccc' }); // 기존 Font Awesome i 태그 스타일
                    $chatHeaderAvatarArea.find('.material-icons').css({ 'font-size': '1.5em', 'color': '#ccc' }); // Material Icons 스타일


                } else { // 기타 유형 (필요시)
                    subtitleHTML = '';
                    // ... (기타 아바타 로직) ...
                    $chatHeaderAvatarArea.html('<span class="material-icons">comment</span>'); // HTML 구조에 맞춰 icon 변경
                    $chatHeaderAvatarArea.find('.material-icons').css({ 'font-size': '1.5em', 'color': '#ccc' });

                }
                // 최종 결정된 부제목 HTML을 화면에 표시
                $chatHeaderSubtitle.html(subtitleHTML); // <-- 여기 수정

                // Placeholder 숨기고 채팅 메인 영역 표시
                // roomInfo가 유효한 경우에만 채팅 메인 영역 표시
                if (roomInfo) {
                    $placeholderArea.hide();
                    $chatMainArea.removeClass('hidden');
                } else {
                    // roomInfo가 null인 경우 (예: 오류 발생 시), placeholder 유지
                    $placeholderArea.show();
                    $chatMainArea.addClass('hidden');
                }
            }


            // --- 개별 메시지를 화면에 표시하는 함수 정의 ---
            function displayChatMessage(message) {
                const path = contextPath;
                const currentUserIdString = currentUserId; // JSP 변수에서 가져온 사용자 ID

                // 메시지 데이터 및 사용자 정보 유효성 검사
                if (!message || message.senderEmpNo == null || !currentUserIdString) {
                    console.error("Cannot display message, data missing or invalid:", message);
                    return;
                }

                // 현재 로그인한 사용자의 메시지인지 확인
                const isUserMessage = String(message.senderEmpNo) === currentUserIdString;

                // 메시지 시간 포맷팅
                const formattedTime = formatMessageTime(message.sendDate);

                // 기본 메시지 요소 및 내용 컨테이너 생성
                const $messageElement = $('<div>').addClass('message').addClass(isUserMessage ? 'user-message' : '');
                const $messageContent = $('<div>').addClass('message-content');

                // 메시지 내용 버블 생성 (내 메시지일 경우 user-bubble 클래스 추가)
                const $messageBubbleDiv = $('<div>').addClass('message-bubble')
                                                    .addClass(isUserMessage ? 'user-bubble' : '')
                                                    .text(message.chatContent || ''); // XSS 방지를 위해 .text() 사용

                // --- 메시지 발신자에 따라 다른 구조 생성 ---
                if (!isUserMessage) { // 상대방 메시지일 경우: 아바타, 헤더(이름+시간), 버블
                    // 아바타 생성
                    const profileImgSrc = (message.senderProfileImgPath && message.senderProfileImgPath !== 'null') ? path + '/' + message.senderProfileImgPath : path + '/resources/images/default_profile.PNG';
                    const $avatarDiv = $('<div>').addClass('avatar').html('<img src="' + profileImgSrc + '" alt="' + (message.senderName || '사용자') + '" onerror="this.onerror=null; this.src=\''+ path + '/resources/images/default_profile.PNG\'">');

                    // 헤더 생성 (이름 + 시간)
                    const $messageHeader = $('<div>').addClass('message-header');
                    $messageHeader.append($('<span>').addClass('message-name').text(message.senderName || '알 수 없음')); // 발신자 이름
                    $messageHeader.append($('<span>').addClass('message-time').text(formattedTime)); // 메시지 시간

                    // message-content에 헤더와 버블 추가
                    $messageContent.append($messageHeader);
                    $messageContent.append($messageBubbleDiv);

                    // message 요소에 아바타와 message-content 추가
                    $messageElement.append($avatarDiv);
                    $messageElement.append($messageContent);

                } else { // 현재 사용자의 메시지일 경우: 버블, 시간 (헤더, 아바타 없음)
                    // 시간만 별도로 추가 (버블 옆 또는 아래에 표시하기 위함)
                    const $timeSpan = $('<span>').addClass('message-time user-message-time').text(formattedTime);
                        // message-content에 시간 추가. CSS로 위치 조절
                        $messageContent.append($timeSpan);
                        
                        // message-content에 버블 추가
                        $messageContent.append($messageBubbleDiv);

                    // message 요소에 message-content만 추가 (아바타 없음)
                    $messageElement.append($messageContent);

                    // 내 메시지일 경우 오른쪽 정렬을 위해 message 요소에 아바타 공간을 CSS로 확보하거나
                    // flexbox justify-content를 사용해야 함. 구조 자체에는 아바타를 추가하지 않음.
                    // (기존 코드에서 message 요소에 user-message 클래스를 추가하고 있으므로,
                    //  해당 클래스에 justify-content: flex-end; 등을 적용하면 됩니다.)

                }
                // --- 구조 생성 끝 ---

                // 완성된 메시지 요소를 메시지 목록에 추가
                $messageList.append($messageElement);

                // 메시지 추가 후 스크롤 최하단으로 이동
                $messageList.scrollTop($messageList[0].scrollHeight);
            }

            // --- 메시지 시간 포맷 함수 정의 ---
            // 서버에서 받은 시간을 "시:분" 형식으로 포맷합니다.
            function formatMessageTime(sendDate) {
                if (!sendDate) return ''; // 날짜가 없으면 빈 문자열 반환
                try {
                    // ISO 8601 형식 문자열 (예: "YYYY-MM-DDTHH:mm:ss.sssZ") 또는 기타 파싱 가능한 형식 처리
                    const date = new Date(sendDate);
                    // Date 객체가 유효한지 확인
                    if (isNaN(date.getTime())) {
                        console.warn("Invalid date format received:", sendDate);
                        return String(sendDate); // 유효하지 않으면 원본 문자열 반환 시도
                    }
                    // 시와 분을 가져와 2자리 숫자로 포맷팅
                    const hours = String(date.getHours()).padStart(2, '0');
                    const minutes = String(date.getMinutes()).padStart(2, '0');
                    return hours + ':' + minutes;
                } catch (e) {
                    console.error("Error formatting date:", e, "Original:", sendDate);
                    return String(sendDate); // 오류 발생 시 원본 반환 시도
                }
            }


            // --- 메시지 전송 함수 정의 ---
            // 입력 필드의 메시지를 가져와 WebSocket으로 전송합니다.
            function sendMessage() {
                const messageContent = $messageInput.val().trim(); // 입력 필드 값 가져오기

                // 메시지 내용 또는 전송 가능 상태 유효성 검사
                if (!messageContent) {
                    console.warn('Message content is empty. Cannot send.');
                    // 입력 필드가 비어있다면 알림 없이 함수 종료
                    return;
                }
                if (!stompClient || !stompClient.connected) {
                    console.error('STOMP client not connected. Cannot send message.');
                    alert("서버와 연결되지 않았습니다. 페이지를 새로고침 해주세요."); // 사용자에게 알림
                    return;
                }
                if (selectedRoomNo == null) {
                    console.error('No room selected. Cannot send message.');
                    alert("메시지를 보낼 채팅방을 선택해주세요."); // 사용자에게 알림
                    return;
                }
                if (!currentUserId || isNaN(parseInt(currentUserId))) { // 사용자 ID가 유효한 숫자인지 확인
                    console.error('Current user ID is missing or invalid. Cannot send message.');
                    alert("사용자 정보가 없습니다. 다시 로그인해주세요."); // 사용자에게 알림
                    return;
                }


                // 서버로 보낼 메시지 객체 생성 (ChatController의 handleChatMessage 메서드가 받을 형태)
                const chatMessage = {
                    roomNo: parseInt(selectedRoomNo), // 백엔드에서 int로 기대하면 숫자로 변환
                    senderEmpNo: parseInt(currentUserId), // 백엔드에서 int로 기대하면 숫자로 변환
                    chatContent: messageContent,
                    messageType: 'TEXT' // 메시지 타입 (TEXT, FILE 등 필요에 따라 확장)
                    // sendDate는 서버에서 설정 (클라이언트에서 보내도 서버 시간을 우선하는 것이 일반적)
                    // senderName, senderProfileImgPath 등은 서버에서 조회하여 메시지 객체에 추가 후 브로드캐스팅
                };

                // 메시지 전송 목적지 (ChatController의 @MessageMapping("/chat/message")와 일치)
                const destination = "/app/chat/message";

                try {
                    // WebSocket으로 메시지 전송 (객체는 자동으로 JSON으로 변환)
                    stompClient.send(destination, {}, JSON.stringify(chatMessage));
                    console.log("Message sent to " + destination, chatMessage);

                    // 전송 성공 후 입력 필드 초기화 및 포커스
                    $messageInput.val('');
                    $messageInput.focus();
                } catch (error) {
                    console.error("Error sending message via STOMP:", error);
                    alert("메시지 전송 중 오류가 발생했습니다."); // 사용자에게 알림
                }
            }


        // ====================================================
        //          채팅방 생성 모달 관련 JavaScript
        // ====================================================

            // "채팅방 만들기" 모달이 열릴 때 실행될 이벤트 핸들러
            $('#createChatModal').on('show.bs.modal', function (event) {
                console.log("채팅 만들기 모달 열림");
                // 모달이 열릴 때마다 직원 목록을 새로 불러와서 표시
                loadEmployeesForChat();

                // 모달 내 채팅 유형 선택 (1:1 vs 단체) 이벤트 핸들러 설정
                $('input[name="chatType"]').change(function() {
                    const selectedType = $(this).val();
                    if (selectedType === 'group') {
                        $('#groupNameContainer').show(); // 단체 채팅방 이름 입력 필드 표시
                        // 단체 채팅 모드에서는 모든 체크박스 활성화
                        $('.participant-checkbox').prop('disabled', false);
                        // 단체 채팅 선택 시 기존 1:1 선택 해제
                        $('.participant-checkbox:checked').prop('checked', false);
                    } else { // oneToOne
                        $('#groupNameContainer').hide(); // 단체 채팅방 이름 입력 필드 숨김
                        $('#groupName').val(''); // 1:1 선택 시 방 이름 입력 필드 초기화
                        // 1:1 채팅 모드에서는 한 명만 선택 가능하도록 제한 (아래 별도 이벤트 핸들러에서 처리)
                        $('.participant-checkbox').prop('disabled', false); // 일단 모든 체크박스 활성화
                        // 1:1 채팅 선택 시 기존 선택 해제
                        $('.participant-checkbox:checked').prop('checked', false);
                    }
                });

                // 모달 열릴 때 기본적으로 1:1 채팅이 선택되어 있도록 하고 이벤트 트리거
                $('#oneToOneChat').prop('checked', true).trigger('change');

            });


            // 1:1 채팅 선택 시 체크박스 선택 제한 (이벤트 위임 사용 - 동적으로 추가되는 체크박스에 대응)
            $(document).on('change', '.participant-checkbox', function() {
                if ($('#oneToOneChat').is(':checked')) {
                    // 1:1 채팅 모드일 경우
                    if ($(this).is(':checked')) {
                        // 현재 선택된 체크박스를 제외한 다른 체크박스 비활성화 및 선택 해제
                        $('.participant-checkbox').not(this).prop('checked', false).prop('disabled', true);
                    } else {
                        // 현재 체크박스가 해제되면 모든 체크박스 활성화
                        $('.participant-checkbox').prop('disabled', false);
                    }
                }
            });

            // 직원 목록을 불러와 모달에 표시하는 함수
            // ChatController의 /employeesByDepartment 엔드포인트를 호출합니다.
            function loadEmployeesForChat() {
                const path = contextPath; // contextPath 변수 사용

                console.log("loadEmployeesForChat: Requesting employee list from:", path + '/employeesByDepartment');
                $.ajax({
                    url: path + '/employeesByDepartment',
                    method: 'GET',
                    dataType: 'json', // 서버 응답을 JSON으로 기대
                    success: function(employeeList) {
                        console.log("loadEmployeesForChat: Received employee list:", employeeList);
                        // 받은 직원 목록 데이터를 가지고 모달에 표시하는 함수 호출
                        displayEmployeesByDepartment(employeeList);
                    },
                    error: function(xhr, status, error) {
                        console.error("loadEmployeesForChat: AJAX 실패:", status, error);
                        console.log('loadEmployeesForChat: Response text:', xhr.responseText);
                        // 사용자에게 오류 알림 및 모달 닫기
                        let errorMessage = "직원 목록을 불러오는데 실패했습니다.";
                        if (xhr.responseJSON && xhr.responseJSON.message) {
                            errorMessage += ": " + xhr.responseJSON.message;
                        } else {
                            errorMessage += " (" + xhr.status + ")";
                        }
                        alert(errorMessage);
                        $('#createChatModal').modal('hide');
                    }
                });
            }

            // 부서별로 직원을 그룹화하고 아코디언 형태로 모달에 표시하는 함수
            function displayEmployeesByDepartment(employeeList) {
                console.log("displayEmployeesByDepartment called");
                const accordionBody = $('#departmentAccordion');
                accordionBody.empty(); // 기존 목록 비우기

                // employeeList가 유효한 배열인지 확인
                if (!Array.isArray(employeeList) || employeeList.length === 0) {
                    console.log("No employees to display or invalid data format.");
                    accordionBody.append('<div class="alert alert-info">조회된 직원 정보가 없습니다.</div>');
                    return;
                }

                // 부서별로 직원 그룹화 및 데이터 유효성 검사
                const employeesByDept = employeeList.reduce((acc, employee) => {
                    // 필수 필드가 유효한지 확인
                    if (employee && employee.empNo != null && employee.empName != null) {
                        const deptName = employee.deptName || '부서 없음';
                        if (!acc[deptName]) {
                            acc[deptName] = [];
                        }
                        acc[deptName].push(employee);
                    } else {
                        console.warn("displayEmployeesByDepartment: Skipping invalid or incomplete employee data:", employee);
                    }
                    return acc;
                }, {});

                console.log("displayEmployeesByDepartment: Employees grouped by department:", employeesByDept);

                // 부서 이름으로 정렬 (선택 사항)
                const sortedDeptNames = Object.keys(employeesByDept).sort();
                console.log("displayEmployeesByDepartment: Sorted department names:", sortedDeptNames);


                // 부서별로 아코디언 아이템 생성
                sortedDeptNames.forEach((deptName, index) => {
                    const employees = employeesByDept[deptName];

                    // 해당 부서에 유효한 직원이 없는 경우 스킵
                    if (!employees || employees.length === 0) {
                        console.log(`displayEmployeesByDepartment: Skipping department "${deptName}" as it has no valid employees.`);
                        return;
                    }

                    const deptId = 'dept-' + index;

                    // 첫 번째 아코디언 아이템만 기본으로 펼치도록 설정
                    const isFirstItem = index === 0;
                    const collapseClass = isFirstItem ? 'show' : '';
                    const buttonClass = isFirstItem ? '' : 'collapsed';
                    const ariaExpanded = isFirstItem ? 'true' : 'false';

                    // 직원 목록 HTML 생성 (문자열 연결 사용)
                    let participantListHtml = '';
                    employees.forEach(emp => {
                        // 개별 직원 데이터 유효성 다시 확인 (forEach 루프 내에서)
                        if (emp && emp.empNo != null && emp.empName != null) {
                            // 프로필 이미지 경로 처리
                            const profileImgPath = (emp.profileImgPath && emp.profileImgPath !== 'null') ? contextPath + '/' + emp.profileImgPath : contextPath + '/resources/images/default_profile.PNG';
                            const positionName = emp.positionName || '직급 없음';
                            const empName = emp.empName || '이름 없음';
                            const empNo = emp.empNo;

                            // empNo가 유효한지 다시 한번 확인 (혹시 모를 데이터 문제 대비)
                            if (empNo == null || (typeof empNo !== 'number' && typeof empNo !== 'string') || (typeof empNo === 'string' && empNo.trim() === '') || isNaN(parseInt(empNo))) {
                                console.warn("displayEmployeesByDepartment: Skipping employee with invalid or missing empNo (string concat):", emp);
                                return; // 유효하지 않은 직원은 스킵
                            }

                            // 문자열 연결로 participant-item HTML 생성 및 추가
                            participantListHtml += '<div class="participant-item">' +
                                                    '<input type="checkbox" class="form-check-input participant-checkbox" id="emp-' + empNo + '" data-emp-no="' + empNo + '" data-department="' + deptName + '">' +
                                                    '<div class="participant-avatar">' +
                                                        '<img src="' + profileImgPath + '" alt="' + empName + ' 프로필" onerror="this.onerror=null; this.src=\''+ contextPath + '/resources/images/default_profile.PNG\'">' +
                                                    '</div>' +
                                                    '<label class="participant-name" for="emp-' + empNo + '">' + empName + ' (' + positionName + ')</label>' +
                                                '</div>';
                        } else {
                            console.warn("displayEmployeesByDepartment: Skipping invalid or incomplete employee data during HTML generation (forEach):", emp);
                        }
                    });

                    const accordionItemHtml =
                        '<div class="accordion-item">' +
                            '<h2 class="accordion-header" id="' + deptId + '-heading">' +
                                '<button class="accordion-button ' + buttonClass + '" type="button" data-bs-toggle="collapse" data-bs-target="#' + deptId + '-collapse" aria-expanded="' + ariaExpanded + '" aria-controls="' + deptId + '-collapse">' +
                                    '<span class="department-name">' + deptName + '</span> <span class="department-badge">' + employees.length + '</span>' +
                                '</button>' +
                            '</h2>' +
                            '<div id="' + deptId + '-collapse" class="accordion-collapse collapse ' + collapseClass + '" aria-labelledby="' + deptId + '-heading" data-bs-parent="#departmentAccordion">' +
                                '<div class="accordion-body">' +
                                    '<div class="participant-list">' +
                                        participantListHtml + // 여기서 문자열 변수 사용
                                    '</div>' +
                                '</div>' +
                            '</div>' +
                        '</div>';

                    accordionBody.append(accordionItemHtml); // DOM에 추가
                });

                // 모달 열릴 때 기본 상태 설정 (1:1 채팅 선택, 그룹 이름 숨김)
                $('#groupNameContainer').hide();
                $('#oneToOneChat').prop('checked', true).trigger('change'); // change 이벤트 트리거하여 1:1 선택 제한 적용
            }

            // 채팅방 생성 요청을 백엔드로 보내는 함수
            // 이 함수는 "#createChatBtn" 클릭 이벤트 핸들러에서 호출됩니다.
            function createChatRoomRequest(chatType, roomName, selectedEmployees) {
                const path = contextPath;

                // 참여자 목록 (empNo 배열)에 현재 사용자(로그인 사용자)의 empNo를 추가
                // 백엔드에서도 이 로직이 있지만, 클라이언트에서도 추가하여 일관성 유지 및 유효성 검사 용이
                const participantEmpNos = [...selectedEmployees]; // 배열 복사
                const currentEmpNo = parseInt(currentUserId);
                if (!participantEmpNos.includes(currentEmpNo)) {
                    participantEmpNos.push(currentEmpNo);
                }

                // 참여자 목록 (empNo)을 쉼표로 구분된 문자열로 변환하여 백엔드에 전송
                const participantsStr = participantEmpNos.join(',');

                // 요청 데이터 객체
                const requestData = {
                    chatType: chatType,
                    roomName: roomName, // 단체 채팅 시 이름, 1:1 시 null
                    participants: participantsStr // 쉼표로 구분된 문자열
                };

                console.log("createChatRoomRequest: Sending AJAX request:", requestData);

                $.ajax({
                    url: path + '/createChatRoom.ch', // 채팅 컨트롤러의 생성 엔드포인트
                    method: 'POST',
                    // contentType을 명시적으로 설정하지 않거나 'application/x-www-form-urlencoded'로 설정
                    // jQuery는 data가 객체이면 기본적으로 'application/x-www-form-urlencoded'로 전송합니다.
                    // contentType: 'application/x-www-form-urlencoded; charset=UTF-8', // 명시적으로 설정할 경우
                    data: requestData, // 객체 형태로 전송 (jQuery가 알아서 처리)
                    success: function(response) {
                        console.log("createChatRoomRequest: Received success response:", response);
                        if (response.success && response.room && response.room.roomNo) {
                            const roomNo = response.room.roomNo;

                            // 성공 메시지 표시
                            alert(response.message);

                            // 모달 닫기 (Bootstrap 5 방식)
                            const createChatModal = bootstrap.Modal.getInstance(document.getElementById('createChatModal'));
                            if (createChatModal) {
                                createChatModal.hide();
                            } else {
                                $('#createChatModal').modal('hide'); // Fallback
                            }

                            // **생성되거나 찾아낸 채팅방 번호로 해당 채팅 화면으로 이동**
                            // 이 함수는 이 페이지(chatList.jsp) 내에서 채팅 영역을 동적으로 업데이트하는 함수로 변경되었습니다.
                            loadChatRoomDetails(roomNo);

                            // TODO: 채팅 목록을 최신 상태로 갱신하는 로직 추가 (새로 생성된 방이 목록에 보이도록)
                            // 서버에서 findMyChatRooms 결과를 다시 받아와 chat-list 영역을 다시 그리는 함수 호출
                            // findAndDisplayMyChatRooms(); // 예시 함수 호출 (필요에 따라 구현)


                        } else {
                            console.error("createChatRoomRequest: Chat room creation reported as not successful:", response.message);
                            // 실패 메시지 표시
                            alert("채팅방 생성 실패: " + response.message);

                            // 이미 존재하는 1:1 채팅방인 경우 해당 방으로 이동 처리 (선택 사항)
                            if (response.room && response.room.roomNo) {
                                console.log("Existing room found, navigating to:", response.room.roomNo);
                                // loadChatRoomDetails 함수는 이 페이지 내에서 UI 업데이트를 하므로, 그대로 호출
                                loadChatRoomDetails(response.room.roomNo);
                            }
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error("createChatRoomRequest: AJAX 실패:", textStatus, errorThrown);
                        console.log('createChatRoomRequest: Status code:', jqXHR.status);
                        console.log('createChatRoomRequest: Response text:', jqXHR.responseText);

                        let errorMessage = "채팅방 생성 중 오류가 발생했습니다.";
                        if (jqXHR.responseJSON && jqXHR.responseJSON.message) {
                            errorMessage += ": " + jqXHR.responseJSON.message;
                        } else {
                            errorMessage += " (" + jqXHR.status + ")";
                        }
                        alert(errorMessage);

                        // 오류 발생 시에도 모달 닫기
                        const createChatModal = bootstrap.Modal.getInstance(document.getElementById('createChatModal'));
                        if (createChatModal) {
                            createChatModal.hide();
                        } else {
                            $('#createChatModal').modal('hide');
                        }
                    }
                });
            }


            // "채팅방 만들기" 버튼 클릭 이벤트 핸들러
            $('#createChatBtn').click(function() {
                console.log("'채팅방 만들기' 버튼 클릭됨");
                const chatType = $('input[name="chatType"]:checked').val(); // 채팅 유형 가져오기
                const selectedEmployees = []; // 선택된 직원 empNo를 담을 배열

                // 체크된 참여자 체크박스에서 empNo 수집
                $('.participant-checkbox:checked').each(function() {
                    // data-emp-no 속성에서 empNo 가져오기 (숫자로 변환)
                    selectedEmployees.push(parseInt($(this).data('emp-no')));
                });

                console.log("Selected chat type:", chatType);
                console.log("Selected employee empNos:", selectedEmployees);

                // 선택된 대화 상대가 없는 경우 알림
                if (selectedEmployees.length === 0) {
                    alert("대화 상대를 선택해주세요.");
                    return; // 함수 실행 중단
                }

                // 단체 채팅방 이름 처리
                let roomName = null;
                if (chatType === 'group') {
                    roomName = $('#groupName').val().trim(); // 단체 채팅방 이름 입력 필드에서 값 가져오기
                    if (roomName === "") {
                        alert("채팅방 이름을 입력해주세요.");
                        return; // 함수 실행 중단
                    }
                    // 단체 채팅은 자신 포함 최소 2명 이상이어야 하므로, 선택된 상대방(자신 제외)이 1명 이상이어야 함
                    if (selectedEmployees.length < 1) { // selectedEmployees는 자신 제외 선택된 상대방 목록
                        alert("단체 채팅방은 두 명 이상의 대화 상대가 필요합니다.");
                        return; // 함수 실행 중단
                    }
                } else { // 1:1 채팅
                    // 1:1 채팅은 선택된 상대방이 정확히 1명이어야 함
                    if (selectedEmployees.length !== 1) {
                        alert("1:1 채팅은 한 명의 대화 상대만 선택해야 합니다.");
                        return; // 함수 실행 중단
                    }
                    // 1:1 채팅방 이름은 백엔드에서 상대방 이름으로 자동 생성하는 것이 일반적입니다.
                    // 따라서 여기서는 roomName을 null로 설정하여 백엔드로 보냅니다.
                    roomName = null;
                }

                // **AJAX 요청을 보내고 응답을 처리하는 함수 호출**
                // 이 함수 내에서 서버 통신, 응답 처리, 화면 이동 로직이 실행됩니다.
                createChatRoomRequest(chatType, roomName, selectedEmployees);

                // 요청 시작 후 모달은 닫도록 처리 (AJAX 성공/실패와 별개로)
                // 성공 시에만 닫고 싶다면 createChatRoomRequest 함수 내부로 이동
                // const createChatModal = bootstrap.Modal.getInstance(document.getElementById('createChatModal'));
                // if (createChatModal) { createChatModal.hide(); }

            });


            // 대화 상대 검색 기능 - 모달 내 직원 목록 필터링
            document.getElementById('participantSearch').addEventListener('input', function() {
                const searchText = this.value.toLowerCase();
                const accordionItems = document.querySelectorAll('#departmentAccordion .accordion-item'); // 모달 내 아코디언만 선택

                accordionItems.forEach(function(accordionItem) {
                    const participantItems = accordionItem.querySelectorAll('.participant-item');
                    let hasVisibleParticipants = false;

                    participantItems.forEach(function(item) {
                        // 이름, 사번 또는 부서 이름에 검색어가 포함되는지 확인
                        const nameLabel = item.querySelector('.participant-name');
                        const nameAndPosition = nameLabel ? nameLabel.textContent.toLowerCase() : '';

                        // TODO: 사번 검색 기능 추가하려면 participant-item 또는 체크박스에 data-emp-id 속성 추가 필요
                        // const empId = item.querySelector('.participant-checkbox').dataset.empId.toLowerCase() || '';
                        // TODO: 부서명 검색 기능 추가하려면 participant-item 또는 체크박스에 data-department 속성 추가 필요
                        // const departmentName = item.querySelector('.participant-checkbox').dataset.department.toLowerCase() || '';

                        // 검색 조건: 이름 (및 사번, 부서명)에 검색어 포함
                        if (nameAndPosition.includes(searchText)) { // || empId.includes(searchText) || departmentName.includes(searchText)
                            item.style.display = 'flex'; // 검색어에 맞으면 표시
                            hasVisibleParticipants = true;
                        } else {
                            item.style.display = 'none'; // 검색어에 안 맞으면 숨김
                        }
                    });

                    // 해당 부서에 표시할 참가자가 있는 경우 아코디언 표시, 아니면 숨김
                    const collapseElement = accordionItem.querySelector('.accordion-collapse');
                    // Bootstrap Collapse 인스턴스를 가져오거나 새로 생성
                    const bsCollapse = bootstrap.Collapse.getOrCreateInstance(collapseElement, { toggle: false });


                    if (hasVisibleParticipants || searchText === '') {
                        accordionItem.style.display = ''; // 아코디언 아이템 표시

                        // 검색어가 있을 때는 해당 부서 아코디언 펼침
                        if (searchText !== '') {
                            bsCollapse.show();
                        } else {
                            // 검색어가 없으면 모두 접음 (초기 상태는 첫 번째만 펼침)
                            // 초기 상태 로직과 충돌 방지 필요. 여기서는 단순히 접도록 처리
                            bsCollapse.hide();
                        }
                    } else {
                        accordionItem.style.display = 'none'; // 아코디언 아이템 숨김
                    }
                });
            });

            // ** 메시지를 읽음 상태로 표시하도록 백엔드에 요청 **
            function markMessagesAsRead(roomNo) {
                const path = contextPath;
                const userId = currentUserId; // 현재 로그인한 사용자 ID (백엔드에 전달 필요)

                // 백엔드의 메시지 읽음 처리 엔드포인트로 AJAX 요청
                // 엔드포인트 URL과 HTTP 메소드 (POST/PUT 등), 보내는 데이터 형식은 백엔드 구현에 따라 달라집니다.
                $.ajax({
                    url: path + '/chat/markAsRead', // 예시 URL: 실제 백엔드 엔드포인트로 변경하세요.
                    method: 'POST', // 예시 메소드
                    data: { roomNo: roomNo, userId: userId }, // 채팅방 번호와 사용자 ID 전달
                    success: function(response) {
                        console.log('Room', roomNo, 'messages marked as read. Response:', response);
                        // 백엔드에서 성공 응답을 보냈을 때 추가적인 처리 (필요시)
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error('Error marking room', roomNo, 'messages as read:', textStatus, errorThrown);
                        // 오류 처리 (사용자에게 알림 등)
                    }
                });
                // 참고: UI 업데이트 (뱃지 제거)는 사용성 향상을 위해 요청 결과와 상관없이 클릭 즉시 처리합니다.
                // 만약 백엔드 처리 실패 시 UI를 되돌려야 한다면 더 복잡한 로직이 필요합니다.
            }



            // ====================================================
            //          이벤트 핸들러 설정
            // ====================================================

            // 채팅방 목록 항목 클릭 시 이벤트 핸들러 (이벤트 위임 사용)
            $chatList.on('click', '.chat-item', function() {
                const $clickedItem = $(this);
                // data-roomno 속성에서 채팅방 번호 가져오기 (숫자로 변환)
                const roomNo = parseInt($clickedItem.data('roomno'));
                console.log('Clicked roomNo:', roomNo);

                // --- 클릭된 chat-item에서 member-count 가져오기 ---
                const $memberCountSpan = $clickedItem.find('.member-count'); // 클릭된 요소 내에서 .member-count span 찾기
                let memberCountFromList = null; // 가져온 인원수를 저장할 변수

                // roomType이 'G' (단체 채팅방)인지 확인 (member-count span이 단체 채팅방에만 있으므로 span 존재 여부로 확인 가능)
                // 또는 $clickedItem.find('.chat-message .chat-name').text() 등으로 방 이름을 가져와서 단체 채팅방 이름 형식인지 확인하는 방법도 있습니다.
                // 여기서는 .member-count span 존재 여부로 간단히 판단합니다.
                if ($memberCountSpan.length > 0) { // .member-count span이 존재하는 경우 (단체 채팅방일 때)
                    const memberCountText = $memberCountSpan.text().trim(); // 텍스트 가져오기 (예: "5" - 괄호가 사라졌네요!)
                    // HTML 구조를 다시 보니 <span class="member-count">${room.memberCount}</span> 로 괄호가 없네요.
                    // 괄호가 없는 경우 숫자로 바로 변환합니다.
                    memberCountFromList = parseInt(memberCountText);

                    if (!isNaN(memberCountFromList)) { // 숫자로 제대로 변환되었는지 확인
                        console.log('클릭된 목록에서 가져온 인원수:', memberCountFromList);

                        // *** 이제 memberCountFromList 변수에 단체 채팅방의 인원수 숫자가 담겨 있습니다. ***

                        // TODO: 이 memberCountFromList 변수 값을 필요한 곳에 사용하세요.
                        // 예시:
                        // 1. 콘솔에 출력: console.log('가져온 인원수:', memberCountFromList); (이미 위에 포함됨)
                        // 2. 특정 UI 요소에 표시 (AJAX 로딩 중 임시 표시 등): $('#someElementId').text('인원: ' + memberCountFromList);
                        // 3. 이 값을 사용하여 어떤 로직 수행: if (memberCountFromList > 10) { alert('많은 인원이 참여 중입니다.'); }
                    } else {
                        console.warn('.member-count의 값이 숫자가 아닙니다:', memberCountText);
                    }

                } else {
                    // .member-count span이 없으면 단체 채팅방이 아닙니다.
                    console.log('클릭된 목록은 단체 채팅방이 아닙니다.'); // 필요시 주석 해제
                }
                // --- member-count 가져오기 끝 ---


                if (!isNaN(roomNo)) { // 유효한 roomNo인지 확인
                    // 채팅방 영역 로드 및 표시
                    loadChatRoomDetails(roomNo); // 이 함수는 서버에서 roomInfo를 받아와 헤더 업데이트 및 메시지 로드

                    // ** 클릭된 아이템의 안 읽은 메시지 수 표시 제거 **
                    $clickedItem.find('.unread-count').remove(); // 해당 아이템의 unread-count span을 DOM에서 완전히 제거
                    // 또는: $clickedItem.find('.unread-count').hide(); // CSS display: none으로 숨기기 (다시 표시할 수도 있을 때 유용)

                    // ** 백엔드에 메시지를 읽었음을 알리는 요청 보내기 **
                    markMessagesAsRead(roomNo); // 새로운 함수 호출

                    // 선택된 채팅방 항목에 'active' 클래스 추가하여 시각적으로 표시
                    $clickedItem.addClass('active').siblings().removeClass('active'); // 다른 항목의 active 클래스 제거

                } else {
                    console.warn("Clicked item does not have a valid roomNo:", $clickedItem.data('roomno'));
                    // 유효하지 않은 방 클릭 시 헤더 초기화 (선택 사항)
                    updateChatHeader(null);
                }
            });


            // 메시지 전송 버튼 클릭 이벤트
            $sendButton.on('click', function() {
                sendMessage(); // 메시지 전송 함수 호출
            });

            // 메시지 입력 필드에서 Enter 키 누름 이벤트
            $messageInput.on('keypress', function(e) {
                if (e.key === 'Enter' || e.keyCode === 13) { // Enter 키 코드 확인
                    e.preventDefault(); // 기본 Enter 동작 (줄바꿈) 방지
                    sendMessage(); // 메시지 전송 함수 호출
                }
            });

            // "+" 버튼 클릭 시 채팅 만들기 모달 열기
            $('#addChatBtn').on('click', function() {
                console.log("+ 버튼 클릭됨");
                // Bootstrap 5 Modal 객체 생성 및 표시
                const createChatModal = new bootstrap.Modal(document.getElementById('createChatModal'));
                createChatModal.show();
            });


            // ====================================================
            //          페이지 로드 시 초기화
            // ====================================================

            // WebSocket 연결 시작
            connectWebSocket();

            // 페이지 로드 시 첫 번째 채팅방 자동 선택 및 로드 (선택 사항)
            // 사용자의 편의를 위해 페이지 로드 시 가장 최근 대화방을 자동으로 열어줄 수 있습니다.
            const $firstChatItem = $chatList.find('.chat-item:first');
            if ($firstChatItem.length > 0) {
                console.log("Auto-selecting the first chat item.");
                $firstChatItem.trigger('click'); // 첫 번째 항목 클릭 이벤트 발생
            } else {
                // 채팅방이 하나도 없을 경우 Placeholder 영역을 표시합니다.
                console.log("No chat items found. Showing placeholder.");
                $placeholderArea.show();
                $chatMainArea.addClass('hidden'); // 채팅 메인 영역 숨김
            }


            // 페이지를 떠날 때 WebSocket 연결 해제 (리소스 정리)
            $(window).on('beforeunload', function() {
                if (stompClient !== null) {
                    stompClient.disconnect();
                    console.log("STOMP Connection Disconnected.");
                }
            });


        }); // $(document).ready 끝


    </script>

</body>
</html>
