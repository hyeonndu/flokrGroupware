<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flokr</title>
<!-- chatList CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chatList.css">
<!-- Material Icons 추가 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"rel="stylesheet">
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
                        <button type="button" id="add-chat-btn" class="material-icons">add</button>
                    </div>
                    <div class="search-input">
                        <span class="material-icons">search</span>
                        <input type="text" placeholder="검색...">
                    </div>
                </div>
                <div class="chat-list">
                    <div class="chat-item">
                        <div class="avatar">
                            <img src="/api/placeholder/32/32" alt="파벨 쿠나">
                        </div>
                        <div class="chat-message">
                            <div class="chat-name">파벨 쿠나</div>
                            <div class="chat-text">네 파벨, 최신 버전을 가져올게요 ...</div>
                        </div>
                    </div>
                    <div class="chat-item">
                        <div class="avatar">
                            <img src="/api/placeholder/32/32" alt="제피 루제이">
                        </div>
                        <div class="chat-message">
                            <div class="chat-name">제피 루제이</div>
                            <div class="chat-text">저도 작업 중이에요 😂</div>
                        </div>
                    </div>
                    <div class="chat-item">
                        <div class="avatar">
                            <img src="/api/placeholder/32/32" alt="맬로리 흄">
                        </div>
                        <div class="chat-message">
                            <div class="chat-name">맬로리 흄</div>
                            <div class="chat-text"><span class="highlight">계산</span> 함수를 리팩토링한 것 같네요</div>
                        </div>
                    </div>
                    <div class="chat-item">
                        <div class="avatar">
                            <img src="/api/placeholder/32/32" alt="던 슬레인">
                        </div>
                        <div class="chat-message">
                            <div class="chat-name">던 슬레인</div>
                            <div class="chat-text">네, 좀 복잡해지고 있다고 생각했어요...</div>
                        </div>
                    </div>
                    <div class="chat-item">
                        <div class="avatar">
                            <img src="/api/placeholder/32/32" alt="에미 레벳">
                        </div>
                        <div class="chat-message">
                            <div class="chat-name">에미 레벳</div>
                            <div class="chat-text">커밋 메시지가 설명적이네요, 좋...</div>
                        </div>
                    </div>
                    <div class="chat-item">
                        <div class="avatar">
                            <img src="/api/placeholder/32/32" alt="마리조 르바레">
                        </div>
                        <div class="chat-message">
                            <div class="chat-name">마리조 르바레</div>
                            <div class="chat-text">새로운 의존성을 추가한 것 같아요...</div>
                        </div>
                    </div>
                    <div class="chat-item">
                        <div class="avatar">
                            <img src="/api/placeholder/32/32" alt="이건 포에츠">
                        </div>
                        <div class="chat-message">
                            <div class="chat-name">이건 포에츠</div>
                            <div class="chat-text">앗, 잊었네요. 바로 추가할게요...</div>
                        </div>
                    </div>
                    <div class="chat-item">
                        <div class="avatar">
                            <img src="/api/placeholder/32/32" alt="켈리 스킹글리">
                        </div>
                        <div class="chat-message">
                            <div class="chat-name">켈리 스킹글리</div>
                            <div class="chat-text">우리가 놓친 몇 가지 예외 케이스가...</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="chat-main">

                <%-- ========= 채팅방 메인 헤더 추가 시작 ========= --%>
                <div class="chat-main-header">
                    <div class="chat-header-left">
                        <%-- 1:1 채팅 시 상대방 프로필 이미지 (옵션) --%>
                        <div class="chat-header-info">
                            <%-- 채팅방 이름 또는 상대방 이름 표시될 곳 --%>
                            <span class="chat-header-title">채팅방 제목 또는 상대방 이름</span>
                            <%-- 상태(온라인/오프라인) 또는 인원수 표시될 곳 --%>
                            <span class="chat-header-subtitle">
                                <%-- 1:1 채팅 시 온라인 상태 표시 (초록색 점) --%>
                                    <span class="status-dot online"></span> 온라인
                                <%-- 단체 채팅 시 인원수 표시 (예: 아이콘 + 숫자) --%>
                                </span>
                        </div>
                    </div>
                    <div class="chat-header-right">
                        <%-- 오른쪽 아이콘 버튼들 (예: Font Awesome 사용) --%>
                        <button type="button" class="material-icons">call</button>
                        <button type="button" class="material-icons">search</i></button>
                        <button type="button" class="material-icons">more_vert</button>
                    </div>
                </div>
                <%-- ========= 채팅방 메인 헤더 추가 끝 =========== --%>

                <div class="message-list">
                    <!-- 사용자(파벨 쿠나) 메시지 - 오른쪽 정렬 -->
                    <div class="message user-message">
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
                    </div>
                    
                    <!-- 다른 사람 메시지 - 왼쪽 정렬 -->
                    <div class="message">
                        <div class="avatar">
                            <img src="/api/placeholder/32/32" alt="맬로리 흄">
                        </div>
                        <div class="message-content">
                            <div class="message-header">
                                <span class="message-name">맬로리 흄</span>
                                <span class="message-time">09:34</span>
                            </div>
                            <div class="message-bubble">
                                알겠습니다 파벨, 최신 업데이트를 가져올게요.
                            </div>
                        </div>
                    </div>
                    
                    <div class="message">
                        <div class="avatar">
                            <img src="/api/placeholder/32/32" alt="던 슬레인">
                        </div>
                        <div class="message-content">
                            <div class="message-header">
                                <span class="message-name">던 슬레인</span>
                                <span class="message-time">09:34</span>
                            </div>
                            <div class="message-bubble">
                                저도 확인 중이에요 <span class="emoji">😂</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="message">
                        <div class="avatar">
                            <img src="/api/placeholder/32/32" alt="맬로리 흄">
                        </div>
                        <div class="message-content">
                            <div class="message-header">
                                <span class="message-name">맬로리 흄</span>
                                <span class="message-time">09:40</span>
                            </div>
                            <div class="message-bubble">
                                <span class="highlight">통계계산</span> 함수를 리팩토링했네요. 코드가 훨씬 깔끔해졌어요.
                            </div>
                        </div>
                    </div>
                    
                    <!-- 사용자(파벨 쿠나) 메시지 - 오른쪽 정렬 -->
                    <div class="message user-message">
                        <div class="message-content">
                            <div class="message-header">
                                <span class="message-time">09:42</span>
                                <span class="message-name">파벨 쿠나</span>
                            </div>
                            <div class="message-bubble user-bubble">
                                네, 코드가 좀 복잡해지고 있다고 생각했어요.
                            </div>
                        </div>
                        <div class="avatar">
                            <img src="/api/placeholder/32/32" alt="파벨 쿠나">
                        </div>
                    </div>
                    
                    <div class="message">
                        <div class="avatar">
                            <img src="/api/placeholder/32/32" alt="에미 레벳">
                        </div>
                        <div class="message-content">
                            <div class="message-header">
                                <span class="message-name">에미 레벳</span>
                                <span class="message-time">09:43</span>
                            </div>
                            <div class="message-bubble">
                                커밋 메시지도 설명이 잘 되어 있네요. 수정된 이슈 번호도 언급해주셔서 좋습니다.
                            </div>
                        </div>
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

</body>
</html>