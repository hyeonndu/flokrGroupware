<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
    .chat-outer {
        background-color: #F8F9FAFF;
        margin: 0;
        display: flex;
        flex-direction: column;
        height: 100vh;
    }
    .chat-content {
        display: flex;
        height: calc(100vh - 112px);
        background-color: #fff;
        padding: 20px;
        background-color: #fff;   
        border-radius: 12px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      overflow: hidden; /* 내부 요소 넘침 방지 */
    }
    .chat-sidebar {
        width: 280px;
        border-right: 1px solid #e0e0e0;
    }
    .search-box {
        padding: 12px;
        border-bottom: 1px solid #f0f0f0;
    }
    .search-input {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #e0e0e0;
        border-radius: 4px;
        display: flex;
        align-items: center;
    }
    .search-input input {
        border: none;
        outline: none;
        width: 100%;
        font-size: 14px;
    }
    .chat-list {
        overflow-y: auto;
        height: calc(100% - 60px);
    }
    .chat-item {
        padding: 10px 12px;
        display: flex;
        gap: 12px;
        border-bottom: 1px solid #f5f5f5;
    }
    .chat-message {
        flex: 1;
        font-size: 14px;
    }
    .chat-name {
        font-weight: 500;
        margin-bottom: 2px;
    }
    .chat-text {
        color: #666;
    }
    .chat-main {
        flex: 1;
        display: flex;
        flex-direction: column;
    }
    .message-list {
        flex: 1;
        padding: 16px;
        overflow-y: auto;
    }
    .message {
        margin-bottom: 16px;
        display: flex;
        gap: 12px;
    }
    /* 사용자 메시지 스타일 */
    .user-message {
        flex-direction: row-reverse;
        text-align: right;
    }
    .message-content {
        flex: 1;
    }
    .message-header {
        display: flex;
        align-items: center;
        margin-bottom: 4px;
    }
    /* 사용자 메시지 헤더 스타일 */
    .user-message .message-header {
        justify-content: flex-end;
    }
    .message-name {
        font-weight: 500;
        margin-right: 8px;
    }
    /* 사용자 메시지 이름 스타일 */
    .user-message .message-name {
        margin-right: 0;
        margin-left: 8px;
    }
    .message-time {
        color: #999;
        font-size: 12px;
    }
    .message-bubble {
        background-color: #f0f8ff;
        padding: 10px 14px;
        border-radius: 8px;
        max-width: 80%;
        display: inline-block;
    }
    /* 사용자 메시지 버블 스타일 */
    .user-bubble {
        background-color: #003561;
        color: #fff;
    }
    .badge {
        background-color: #e6f0ff;
        color: #0d6efd;
        padding: 2px 6px;
        border-radius: 4px;
        font-size: 12px;
    }
    .emoji {
        font-size: 16px;
    }
    .highlight {
        background-color: #e6f0ff;
        color: #0d6efd;
        padding: 0 2px;
        border-radius: 2px;
    }
    .avatar {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        overflow: hidden;
        background-color: #f0f0f0;
    }
    .avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
  </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="chat-outer">

        <div class="chat-content">
            <div class="chat-sidebar">
                <div class="search-box">
                    <div class="search-input">
                        <span>🔍</span>
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
            </div>
        </div>
    

    </div>

</body>
</html>