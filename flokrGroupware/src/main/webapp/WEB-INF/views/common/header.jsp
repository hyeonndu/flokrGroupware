<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">

<c:if test="${ not empty alertMsg }">
    <script>
        alertify.alert("${ alertMsg }");
    </script>
    <c:remove var="alertMsg" scope="session"/> </c:if>

<header class="header-top">
    <div class="header-logo">
        <c:choose>
            <c:when test="${not empty loginUser and loginUser.isAdmin eq 'Y'}">
                <a href="${pageContext.request.contextPath}/adminMain" style="display: flex; align-items: center; text-decoration: none; color: inherit;">
            </c:when>
            <c:when test="${not empty loginUser and loginUser.isAdmin eq 'N'}">
                <a href="${pageContext.request.contextPath}/userMain" style="display: flex; align-items: center; text-decoration: none; color: inherit;">
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/" style="display: flex; align-items: center; text-decoration: none; color: inherit;">
            </c:otherwise>
        </c:choose>
            <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Flokr" class="header-logo-img">
            Flokr
        </a>
    </div>

    <div class="header-right-section">
        <a href="chat.ch">
            <div class="header-icon-badge">
                <svg class="header-icon" viewBox="0 0 24 24" fill="none" stroke="#555" stroke-width="2">
                    <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                </svg>
                <span class="header-badge">1</span>
            </div>
        </a>

        <!-- 알림 드롭다운 -->
        <div class="header-icon-badge header-notification-wrapper">
            <button id="header-notification-btn" class="header-notification-btn">
                <svg class="header-icon" viewBox="0 0 24 24" fill="none" stroke="#555" stroke-width="2">
                    <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                    <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                </svg>
                <span id="header-notification-badge" class="header-notification-badge" style="display: none;">0</span>
            </button>
            <div id="header-notification-dropdown" class="header-notification-dropdown">
                <div class="header-notification-header">
                    <h3>알림</h3>
                    <a href="${pageContext.request.contextPath}/notificationAll" class="header-all-notifications">모두 보기</a>
                </div>
                <ul id="header-notification-list" class="header-notification-list">
                    <li class="header-empty-notification">새로운 알림이 없습니다.</li>
                </ul>
            </div>
        </div>

        <c:if test="${not empty loginUser}">
            <div class="header-profile">
                <c:choose>
                    <c:when test="${not empty loginUser.profileImgPath}"> <%-- loginUser 변수 사용 --%>
                        <img src="${loginUser.profileImgPath}" alt="프로필" class="header-profile-img"> <%-- loginUser 변수 사용 --%>
                    </c:when>
                    <c:otherwise>
                        <svg class="header-profile-img" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <circle cx="12" cy="7" r="5" fill="#E2E8F0"/>
                            <path d="M3 19c0-3.314 4.03-6 9-6s9 2.686 9 6v1H3v-1z" fill="#E2E8F0"/>
                        </svg>
                    </c:otherwise>
                </c:choose>
                <div class="header-profile-info">
                    <span class="header-profile-name">${loginUser.empName}님</span>
                </div>
                <a href="logout.me" class="header-btn-sm header-logout-btn">로그아웃</a>
            </div>
        </c:if>
    </div>
</header>

<nav class="header-nav-bar">
    <div class="header-nav-container">
        <c:choose>
            <c:when test="${loginUser.isAdmin eq 'Y'}">
                <a href="${pageContext.request.contextPath}/adminMain" class="header-nav-item ${currentMenu eq 'home' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                    </svg>
                    Home
                </a>
                <a href="${pageContext.request.contextPath}/organization" class="header-nav-item ${currentMenu eq 'organization' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                        <polyline points="14 2 14 8 20 8"></polyline>
                        <line x1="16" y1="13" x2="8" y2="13"></line>
                        <line x1="16" y1="17" x2="8" y2="17"></line>
                        <polyline points="10 9 9 9 8 9"></polyline>
                    </svg>
                    조직 관리
                </a>
                <a href="${pageContext.request.contextPath}/employeeList" class="header-nav-item ${currentMenu eq 'empRegister' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="16" y1="2" x2="16" y2="6"></line>
                        <line x1="8" y1="2" x2="8" y2="6"></line>
                        <line x1="3" y1="10" x2="21" y2="10"></line>
                    </svg>
                    사원 관리
                </a>
                <a href="${pageContext.request.contextPath}/noticeList" class="header-nav-item ${currentMenu eq 'notice' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                        <line x1="8" y1="21" x2="16" y2="21"></line>
                        <line x1="12" y1="17" x2="12" y2="21"></line>
                    </svg>
                    사내 공지 관리
                </a>
                <a href="${pageContext.request.contextPath}/online-users" class="header-nav-item ${currentMenu eq 'onlineUsers' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                        <circle cx="9" cy="7" r="4"></circle>
                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                        <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                    </svg>
                    접속 사용자 관리
                </a>
                <a href="${pageContext.request.contextPath}/users" class="header-nav-item ${currentMenu eq 'users' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                    사용자 정보 관리
                </a>
                <a href="${pageContext.request.contextPath}/facility" class="header-nav-item ${currentMenu eq 'facility' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="3" y1="9" x2="21" y2="9"></line>
                        <line x1="9" y1="21" x2="9" y2="9"></line>
                    </svg>
                    시설 관리
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/userMain" class="header-nav-item ${currentMenu eq 'home' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                    </svg>
                    Home
                </a>
                <a href="${pageContext.request.contextPath}/task/list" class="header-nav-item ${currentMenu eq 'task' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                        <polyline points="14 2 14 8 20 8"></polyline>
                        <line x1="16" y1="13" x2="8" y2="13"></line>
                        <line x1="16" y1="17" x2="8" y2="17"></line>
                        <polyline points="10 9 9 9 8 9"></polyline>
                    </svg>
                    업무 관리
                </a>
                <a href="${pageContext.request.contextPath}/schedule" class="header-nav-item ${currentMenu eq 'schedule' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="16" y1="2" x2="16" y2="6"></line>
                        <line x1="8" y1="2" x2="8" y2="6"></line>
                        <line x1="3" y1="10" x2="21" y2="10"></line>
                    </svg>
                    일정
                </a>
                <a href="${pageContext.request.contextPath}/attendance" class="header-nav-item ${currentMenu eq 'attendance' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
                        <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                        <line x1="17.5" y1="6.5" x2="17.5" y2="6.5"></line>
                    </svg>
                    근태 관리
                </a>
                <a href="${pageContext.request.contextPath}/address" class="header-nav-item ${currentMenu eq 'address' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                    </svg>
                    주소록
                </a>
                <a href="${pageContext.request.contextPath}/approval" class="header-nav-item ${currentMenu eq 'approval' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polyline points="9 11 12 14 22 4"></polyline>
                        <path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path>
                    </svg>
                    전자 결재
                </a>
                <a href="${pageContext.request.contextPath}/facility-reservation" class="header-nav-item ${currentMenu eq 'facility' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="3" y1="9" x2="21" y2="9"></line>
                        <line x1="9" y1="21" x2="9" y2="9"></line>
                    </svg>
                    시설 예약
                </a>
                <a href="${pageContext.request.contextPath}/noticeList" class="header-nav-item ${currentMenu eq 'notice' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                        <line x1="8" y1="21" x2="16" y2="21"></line>
                        <line x1="12" y1="17" x2="12" y2="21"></line>
                    </svg>
                    공지사항
                </a>
                <a href="${pageContext.request.contextPath}/help" class="header-nav-item ${currentMenu eq 'help' ? 'header-active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="12" cy="12" r="10"></circle>
                        <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
                        <line x1="12" y1="17" x2="12.01" y2="17"></line>
                    </svg>
                    Help
                </a>
            </c:otherwise>
        </c:choose>

        <div class="header-search-container">
            <input type="text" class="header-search-bar" placeholder="Search...">
            <svg class="header-search-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="11" cy="11" r="8"></circle>
                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
            </svg>
        </div>
    </div>
</nav>

<!-- 알림 관련 WebSocket 스크립트 -->
<script>
    // WebSocket 연결
    var notificationSocket;
    var reconnectCount = 0;
    var maxReconnectAttempts = 5;
    
    function connectWebSocket() {
        // WebSocket 연결
        const protocol = window.location.protocol === 'https:' ? 'wss://' : 'ws://';
        const host = window.location.host;
        notificationSocket = new WebSocket(protocol + host + '${pageContext.request.contextPath}/notification');
        
        // 연결 성공 시
        notificationSocket.onopen = function(event) {
            console.log("WebSocket 연결 성공");
            reconnectCount = 0; // 연결 성공 시 재연결 카운트 초기화
        };
        
        // 메시지 수신 시
        notificationSocket.onmessage = function(event) {
            const data = JSON.parse(event.data);
            
            if(data.type === "unread") {
                // 읽지 않은 알림 목록 표시
                updateNotificationBadge(data.notifications.length);
                updateNotificationList(data.notifications);
            } else if(data.type === "new") {
                // 새 알림 추가
                addNewNotification(data);
                showNotificationToast(data.title);
            }
        };
        
        // 연결 종료 시
        notificationSocket.onclose = function(event) {
            console.log("WebSocket 연결 종료");
            
            // 재연결 시도 (최대 시도 횟수 제한)
            if(reconnectCount < maxReconnectAttempts) {
                reconnectCount++;
                const timeout = Math.min(1000 * Math.pow(2, reconnectCount), 30000); // 지수 백오프, 최대 30초
                console.log(`재연결 시도 ${reconnectCount}/${maxReconnectAttempts} (${timeout}ms 후)`);
                
                setTimeout(function() {
                    connectWebSocket();
                }, timeout);
            } else {
                console.error("최대 재연결 시도 횟수를 초과했습니다.");
            }
        };
        
        // 에러 발생 시
        notificationSocket.onerror = function(event) {
            console.error("WebSocket 에러 발생:", event);
        };
    }
    
    // 알림 배지 업데이트
    function updateNotificationBadge(count) {
        const badge = document.getElementById('header-notification-badge');
        
        if(count > 0) {
            // 99개 초과 시 "99+"로 표시
            badge.textContent = count > 99 ? "99+" : count;
            badge.style.display = 'block';
        } else {
            badge.style.display = 'none';
        }
    }
    
    // 알림 목록 업데이트
    function updateNotificationList(notifications) {
        const list = document.getElementById('header-notification-list');
        list.innerHTML = '';
        
        if(notifications.length === 0) {
            list.innerHTML = '<li class="header-empty-notification">새로운 알림이 없습니다.</li>';
            return;
        }
        
        notifications.forEach(function(notification) {
            const item = document.createElement('li');
            item.className = 'header-notification-item';
            
            const link = document.createElement('a');
            if(notification.refType && notification.refNo) {
                // 경로 연결 수정: 중복 슬래시 방지
                link.href = getNotificationUrl(notification.refType, notification.refNo);
            } else {
                // 링크가 없는 경우 javascript:void(0) 사용
                link.href = "javascript:void(0)";
            }
            link.className = 'header-notification-link';
            link.dataset.id = notification.notificationNo;
            link.onclick = function(e) {
                // 기본 이벤트를 항상 방지하고 읽음 처리만 수행
                e.preventDefault();
                markAsRead(notification.notificationNo);
                
                // refType과 refNo가 있으면 해당 페이지로 이동
                if(notification.refType && notification.refNo) {
                    setTimeout(function() {
                        window.location.href = getNotificationUrl(notification.refType, notification.refNo);
                    }, 300); // 읽음 처리 후 약간의 지연 후 이동
                }
            };
            
            const title = document.createElement('div');
            title.className = 'header-notification-title';
            title.textContent = notification.title;
            
            const content = document.createElement('div');
            content.className = 'header-notification-content';
            content.textContent = notification.notificationContent || '';
            
            const time = document.createElement('div');
            time.className = 'header-notification-time';
            time.textContent = formatDate(notification.createDate);
            
            link.appendChild(title);
            if(notification.notificationContent) {
                link.appendChild(content);
            }
            link.appendChild(time);
            item.appendChild(link);
            list.appendChild(item);
        });
    }
    
    // 알림 타입에 따른 URL 생성 함수
    function getNotificationUrl(refType, refNo) {
        const contextPath = '${pageContext.request.contextPath}';
        
        // 슬래시 중복 방지
        if (refType && refType.startsWith('/')) {
            refType = refType.substring(1);
        }
        
        switch(refType) {
            case 'notice':
                return contextPath + '/noticeDetail/' + refNo;  // 이 부분이 수정됨
            case 'approval':
                return contextPath + '/approval/detail/' + refNo;
            case 'task':
                return contextPath + '/task/detail/' + refNo;
            case 'schedule':
                return contextPath + '/schedule/detail/' + refNo;
            default:
                return contextPath + '/notificationAll';
        }
    }
    
    // 새 알림 추가
    function addNewNotification(notification) {
        const badge = document.getElementById('header-notification-badge');
        const count = parseInt(badge.textContent || '0') + 1;
        updateNotificationBadge(count);
        
        const list = document.getElementById('header-notification-list');
        
        // 빈 알림 메시지 제거
        const emptyNotification = list.querySelector('.header-empty-notification');
        if(emptyNotification) {
            list.removeChild(emptyNotification);
        }
        
        const item = document.createElement('li');
        item.className = 'header-notification-item header-new';
        
        const link = document.createElement('a');
        if(notification.refType && notification.refNo) {
            link.href = getNotificationUrl(notification.refType, notification.refNo);
        } else {
            link.href = "javascript:void(0)";
        }
        link.className = 'header-notification-link';
        link.dataset.id = notification.notificationNo;
        link.onclick = function(e) {
            // 기본 이벤트를 항상 방지하고 읽음 처리만 수행
            e.preventDefault();
            markAsRead(notification.notificationNo);
            
            // refType과 refNo가 있으면 해당 페이지로 이동
            if(notification.refType && notification.refNo) {
                setTimeout(function() {
                    window.location.href = getNotificationUrl(notification.refType, notification.refNo);
                }, 300); // 읽음 처리 후 약간의 지연 후 이동
            }
        };
        
        const title = document.createElement('div');
        title.className = 'header-notification-title';
        title.textContent = notification.title;
        
        const content = document.createElement('div');
        content.className = 'header-notification-content';
        content.textContent = notification.content || '';
        
        const time = document.createElement('div');
        time.className = 'header-notification-time';
        time.textContent = '방금 전';
        
        link.appendChild(title);
        if(notification.content) {
            link.appendChild(content);
        }
        link.appendChild(time);
        item.appendChild(link);
        
        // 목록 맨 위에 추가
        list.insertBefore(item, list.firstChild);
    }
    
    // 처리 중인 알림 추적
    window.processingNotifications = {};
    
    // 알림 읽음 처리 (중복 요청 방지)
    function markAsRead(notificationNo) {
        if(notificationNo === undefined || !notificationNo) return;
        
        // 이미 처리 중인 알림은 건너뛰기
        if(window.processingNotifications[notificationNo]) {
            return;
        }
        
        // 처리 중 표시
        window.processingNotifications[notificationNo] = true;
        
        // 서버에 읽음 상태 업데이트 요청
        fetch(`${pageContext.request.contextPath}/notificationRead/${notificationNo}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                // 성공적으로 처리됨
            } else {
                console.error('알림 읽음 처리 실패:', data.message);
            }
        })
        .catch(err => {
            console.error('알림 읽음 처리 중 오류:', err);
        })
        .finally(() => {
            // 처리 완료 표시
            delete window.processingNotifications[notificationNo];
        });
    }
    
    // 알림 토스트 표시
    function showNotificationToast(message) {
        // 이미 표시된 토스트가 있으면 제거
        const existingToasts = document.querySelectorAll('.header-notification-toast');
        existingToasts.forEach(toast => {
            toast.classList.remove('header-show');
            setTimeout(() => {
                if(toast.parentNode) {
                    toast.parentNode.removeChild(toast);
                }
            }, 300);
        });
        
        const toast = document.createElement('div');
        toast.className = 'header-notification-toast';
        toast.textContent = message;
        
        document.body.appendChild(toast);
        
        // 애니메이션 적용
        setTimeout(function() {
            toast.classList.add('header-show');
        }, 10);
        
        // 5초 후 제거
        setTimeout(function() {
            toast.classList.remove('header-show');
            setTimeout(function() {
                if(toast.parentNode) {
                    document.body.removeChild(toast);
                }
            }, 300);
        }, 5000);
    }
    
    // 날짜 포맷팅
    function formatDate(dateStr) {
        if(!dateStr) return '알 수 없음';
        
        const date = new Date(dateStr);
        const now = new Date();
        
        if(isNaN(date.getTime())) return dateStr; // 날짜 파싱 오류 시
        
        const diff = Math.floor((now - date) / 1000 / 60); // 분 단위 차이
        
        if(diff < 1) return '방금 전';
        if(diff < 60) return diff + '분 전';
        
        const hours = Math.floor(diff / 60);
        if(hours < 24) return hours + '시간 전';
        
        const days = Math.floor(hours / 24);
        if(days < 7) return days + '일 전';
        
        // 일주일 이상이면 날짜 형식으로 표시
        return date.getFullYear() + '.' + 
               (date.getMonth() + 1).toString().padStart(2, '0') + '.' + 
               date.getDate().toString().padStart(2, '0');
    }
    
    // 페이지 로드 시 WebSocket 연결
    document.addEventListener('DOMContentLoaded', function() {
        connectWebSocket();
        
        // 알림 드롭다운 토글
        const notificationBtn = document.getElementById('header-notification-btn');
        const notificationDropdown = document.getElementById('header-notification-dropdown');
        
        if(notificationBtn && notificationDropdown) {
            notificationBtn.addEventListener('click', function(event) {
                event.stopPropagation();
                notificationDropdown.classList.toggle('header-show');
            });
            
            // 문서 클릭 시 드롭다운 닫기
            document.addEventListener('click', function() {
                if(notificationDropdown.classList.contains('header-show')) {
                    notificationDropdown.classList.remove('header-show');
                }
            });
            
            // 드롭다운 내부 클릭 시 이벤트 전파 방지
            notificationDropdown.addEventListener('click', function(event) {
                event.stopPropagation();
            });
        }
    });
</script>