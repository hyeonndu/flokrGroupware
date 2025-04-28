<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- JavaScript (Alertify) -->
<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
<!-- CSS (Alertify) -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
<!-- Default theme (Alertify) -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
<!-- 헤더 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">

<!-- 세션에 메시지가 있다면 alertify로 표시하고 세션에서 제거 -->
<c:if test="${ not empty alertMsg }">
    <script>
        alertify.alert("${ alertMsg }");
    </script>
    <c:remove var="alertMsg" scope="session"/> <!-- session scope에 있는 alertMsg를 지워줌 -->
</c:if>

<!-- 로고와 사용자 정보 헤더 -->
<header class="header-top">
    <div class="header-logo">
        <!-- 로고 이미지 사용 -->
        <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Flokr" class="header-logo-img">
        Flokr
    </div>

    <div class="header-right-section">
        <!-- 채팅 아이콘 -->
        <a href="chat.ch">
	        <div class="header-icon-badge">
	            <svg class="header-icon" viewBox="0 0 24 24" fill="none" stroke="#555" stroke-width="2">
	                <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
	            </svg>
	            <span class="header-badge">1</span>
	        </div>
        </a>
        
        <!-- 알림 아이콘 -->
        <div class="header-icon-badge">
            <svg class="header-icon" viewBox="0 0 24 24" fill="none" stroke="#555" stroke-width="2">
                <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
            </svg>
            <c:if test="${not empty unreadNotificationCount && unreadNotificationCount > 0}">
                <span class="header-badge">${unreadNotificationCount}</span>
            </c:if>
        </div>

        <!-- 로그인 상태 표시 영역 -->
        <c:if test="${not empty loginUser}">
            <div class="header-profile">
                <c:choose>
                    <c:when test="${not empty loginUser.profileImgPath}">
                        <img src="${loginUser.profileImgPath}" alt="프로필" class="header-profile-img">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/resources/images/default-profile.png" alt="프로필" class="header-profile-img">
                    </c:otherwise>
                </c:choose>
                <div class="header-profile-info">
                    <span class="header-profile-name">${loginUser.empName}님</span>
                </div>
                <!-- 로그아웃 버튼 -->
                <a href="logout.me" class="header-btn-sm header-logout-btn">로그아웃</a>
            </div>
        </c:if>
    </div>
</header>

<!-- 네비게이션 바 - 권한에 따라 다른 메뉴 표시 -->
<nav class="header-nav-bar">
    <div class="header-nav-container">
        <c:choose>
            <c:when test="${loginUser.isAdmin eq 'Y'}">
                <!-- 관리자용 메뉴 -->
                <a href="${pageContext.request.contextPath}/" class="header-nav-item ${currentPage eq 'home' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                    </svg>
                    Home
                </a>
                <a href="${pageContext.request.contextPath}/organization" class="header-nav-item ${currentPage eq 'organization' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                        <polyline points="14 2 14 8 20 8"></polyline>
                        <line x1="16" y1="13" x2="8" y2="13"></line>
                        <line x1="16" y1="17" x2="8" y2="17"></line>
                        <polyline points="10 9 9 9 8 9"></polyline>
                    </svg>
                    조직 관리
                </a>
                <a href="${pageContext.request.contextPath}/employee/register" class="header-nav-item ${currentPage eq 'empRegister' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="16" y1="2" x2="16" y2="6"></line>
                        <line x1="8" y1="2" x2="8" y2="6"></line>
                        <line x1="3" y1="10" x2="21" y2="10"></line>
                    </svg>
                    사원 등록
                </a>
                <a href="${pageContext.request.contextPath}/notice" class="header-nav-item ${currentPage eq 'notice' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                        <line x1="8" y1="21" x2="16" y2="21"></line>
                        <line x1="12" y1="17" x2="12" y2="21"></line>
                    </svg>
                    사내 공지 관리
                </a>
                <a href="${pageContext.request.contextPath}/online-users" class="header-nav-item ${currentPage eq 'onlineUsers' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                        <circle cx="9" cy="7" r="4"></circle>
                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                        <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                    </svg>
                    접속 사용자 관리
                </a>
                <a href="${pageContext.request.contextPath}/users" class="header-nav-item ${currentPage eq 'users' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                    사용자 정보 관리
                </a>
                <a href="${pageContext.request.contextPath}/facility" class="header-nav-item ${currentPage eq 'facility' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="3" y1="9" x2="21" y2="9"></line>
                        <line x1="9" y1="21" x2="9" y2="9"></line>
                    </svg>
                    시설 관리
                </a>
            </c:when>
            <c:otherwise>
                <!-- 일반 사용자용 메뉴 (이미지에 보이는 메뉴) -->
                <a href="${pageContext.request.contextPath}/" class="header-nav-item ${currentPage eq 'home' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                    </svg>
                    Home
                </a>
                <a href="${pageContext.request.contextPath}/task" class="header-nav-item ${currentPage eq 'task' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                        <polyline points="14 2 14 8 20 8"></polyline>
                        <line x1="16" y1="13" x2="8" y2="13"></line>
                        <line x1="16" y1="17" x2="8" y2="17"></line>
                        <polyline points="10 9 9 9 8 9"></polyline>
                    </svg>
                    업무 관리
                </a>
                <a href="${pageContext.request.contextPath}/schedule" class="header-nav-item ${currentPage eq 'schedule' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="16" y1="2" x2="16" y2="6"></line>
                        <line x1="8" y1="2" x2="8" y2="6"></line>
                        <line x1="3" y1="10" x2="21" y2="10"></line>
                    </svg>
                    일정
                </a>
                <a href="${pageContext.request.contextPath}/attendance" class="header-nav-item ${currentPage eq 'attendance' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
                        <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                        <line x1="17.5" y1="6.5" x2="17.5" y2="6.5"></line>
                    </svg>
                    근태 관리
                </a>
                <a href="${pageContext.request.contextPath}/address" class="header-nav-item ${currentPage eq 'address' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                    </svg>
                    주소록
                </a>
                <a href="${pageContext.request.contextPath}/approval" class="header-nav-item ${currentPage eq 'approval' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polyline points="9 11 12 14 22 4"></polyline>
                        <path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path>
                    </svg>
                    전자 결재
                </a>
                <a href="${pageContext.request.contextPath}/facility-reservation" class="header-nav-item ${currentPage eq 'facility' ? 'active' : ''}">
                    <svg class="header-nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="3" y1="9" x2="21" y2="9"></line>
                        <line x1="9" y1="21" x2="9" y2="9"></line>
                    </svg>
                    시설 예약
                </a>
                <a href="${pageContext.request.contextPath}/help" class="header-nav-item ${currentPage eq 'help' ? 'active' : ''}">
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