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

<!-- 헤더 스타일 시작 -->
<style>
    /* 헤더 스타일 */
    .top-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 20px;
        background-color: #fff;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        border-bottom: 1px solid #e0e0e0;
    }

    .logo {
        display: flex;
        align-items: center;
        font-size: 24px;
        font-weight: bold;
        color: #003561;
    }

    .logo-img {
        height: 36px;
        margin-right: 5px;
    }

    .right-section {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    /* 네비게이션 바 스타일 */
    .nav-bar {
        background-color: #fff;
        border-bottom: 1px solid #e0e0e0;
        padding: 0 20px;
    }

    .nav-container {
        display: flex;
        align-items: center;
        max-width: 1400px;
        margin: 0 auto;
    }

    .nav-item {
        display: flex;
        align-items: center;
        padding: 12px 15px;
        color: #444;
        text-decoration: none;
        font-size: 14px;
        border-bottom: 2px solid transparent;
    }

    .nav-item:hover {
        color: #003561;
    }

    .nav-item.active {
        border-bottom: 2px solid #003561;
        color: #003561;
        font-weight: 500;
    }

    .nav-icon {
        margin-right: 5px;
    }

    /* 검색 바 스타일 */
    .search-container {
        margin-left: auto;
        position: relative;
    }

    .search-bar {
        padding: 8px 12px;
        padding-right: 35px;
        border-radius: 20px;
        border: 1px solid #ddd;
        width: 200px;
        font-size: 14px;
    }

    .search-icon {
        position: absolute;
        right: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: #777;
    }

    /* 프로필 스타일 */
    .profile {
        display: flex;
        align-items: center;
        gap: 10px;
        position: relative;
    }

    .profile-img {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        object-fit: cover;
    }

    .profile-info {
        display: flex;
        flex-direction: column;
        font-size: 13px;
    }

    .profile-name {
        font-weight: 500;
        color: #444;
    }

    /* 아이콘 스타일 */
    .icon {
        width: 20px;
        height: 20px;
        cursor: pointer;
    }

    /* 배지 스타일 */
    .icon-badge {
        position: relative;
    }

    .badge {
        position: absolute;
        top: -5px;
        right: -5px;
        background-color: #ff3b30;
        color: white;
        font-size: 10px;
        min-width: 16px;
        height: 16px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
    }

    /* 헤더 로그인 폼 */
    .header-login-form {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .form-control-sm {
        padding: 6px 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 13px;
        width: 120px;
    }

    .btn-sm {
        background-color: #003561;
        color: white;
        border: none;
        border-radius: 4px;
        padding: 6px 12px;
        font-size: 13px;
        cursor: pointer;
        transition: background-color 0.2s;
        text-decoration: none;
    }
    
    .btn-sm:hover {
        background-color: #002b4e;
    }
    
    .logout-btn {
        margin-left: 10px;
    }
</style>
<!-- 헤더 스타일 끝 -->

<!-- 세션에 메시지가 있다면 alertify로 표시하고 세션에서 제거 -->
<c:if test="${ not empty alertMsg }">
    <script>
        alertify.alert("${ alertMsg }");
    </script>
    <c:remove var="alertMsg" scope="session"/> <!-- session scope에 있는 alertMsg를 지워줌 -->
</c:if>

<!-- 로고와 사용자 정보 헤더 -->
<header class="top-header">
    <div class="logo">
        <!-- 로고 이미지 사용 -->
        <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Flokr" class="logo-img">
        Flokr
    </div>

    <div class="right-section">
        <!-- 채팅 아이콘 -->
        <div class="icon-badge">
            <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="#555" stroke-width="2">
                <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
            </svg>
            <span class="badge">1</span>
        </div>
        
        <!-- 알림 아이콘 -->
        <div class="icon-badge">
            <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="#555" stroke-width="2">
                <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
            </svg>
            <c:if test="${not empty unreadNotificationCount && unreadNotificationCount > 0}">
                <span class="badge">${unreadNotificationCount}</span>
            </c:if>
        </div>

        <!-- 로그인 처리 영역 -->
        <c:choose>
            <c:when test="${empty loginUser}">
                <!-- 로그인 전 -->
                <form action="login.me" method="post" class="header-login-form">
                    <input type="text" name="empId" placeholder="아이디" class="form-control-sm" required>
                    <input type="password" name="passwordHash" placeholder="비밀번호" class="form-control-sm" required>
                    <button type="submit" class="btn-sm">로그인</button>
                </form>
            </c:when>
            <c:otherwise>
                <!-- 로그인 후 -->
                <div class="profile">
                    <c:choose>
                        <c:when test="${not empty loginUser.profileImgPath}">
                            <img src="${loginUser.profileImgPath}" alt="프로필" class="profile-img">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/resources/images/default-profile.png" alt="프로필" class="profile-img">
                        </c:otherwise>
                    </c:choose>
                    <div class="profile-info">
                        <span class="profile-name">${loginUser.empName}님</span>
                    </div>
                    <!-- 로그아웃 버튼 -->
                    <a href="logout.me" class="btn-sm logout-btn">로그아웃</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</header>

<!-- 네비게이션 바 - 권한에 따라 다른 메뉴 표시 -->
<nav class="nav-bar">
    <div class="nav-container">
        <c:choose>
            <c:when test="${loginUser.isAdmin eq 'Y'}">
                <!-- 관리자용 메뉴 -->
                <a href="${pageContext.request.contextPath}/" class="nav-item ${currentPage eq 'home' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                    </svg>
                    Home
                </a>
                <a href="${pageContext.request.contextPath}/organization" class="nav-item ${currentPage eq 'organization' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                        <polyline points="14 2 14 8 20 8"></polyline>
                        <line x1="16" y1="13" x2="8" y2="13"></line>
                        <line x1="16" y1="17" x2="8" y2="17"></line>
                        <polyline points="10 9 9 9 8 9"></polyline>
                    </svg>
                    조직 관리
                </a>
                <a href="${pageContext.request.contextPath}/employee/register" class="nav-item ${currentPage eq 'empRegister' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="16" y1="2" x2="16" y2="6"></line>
                        <line x1="8" y1="2" x2="8" y2="6"></line>
                        <line x1="3" y1="10" x2="21" y2="10"></line>
                    </svg>
                    사원 등록
                </a>
                <a href="${pageContext.request.contextPath}/employee/detail" class="nav-item ${currentPage eq 'empDetail' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                        <polyline points="22 4 12 14.01 9 11.01"></polyline>
                    </svg>
                    직원 상세 조회
                </a>
                <a href="${pageContext.request.contextPath}/notice" class="nav-item ${currentPage eq 'notice' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                        <line x1="8" y1="21" x2="16" y2="21"></line>
                        <line x1="12" y1="17" x2="12" y2="21"></line>
                    </svg>
                    사내 공지 관리
                </a>
                <a href="${pageContext.request.contextPath}/online-users" class="nav-item ${currentPage eq 'onlineUsers' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                        <circle cx="9" cy="7" r="4"></circle>
                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                        <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                    </svg>
                    접속 사용자 관리
                </a>
                <a href="${pageContext.request.contextPath}/users" class="nav-item ${currentPage eq 'users' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                    사용자 정보 관리
                </a>
                <a href="${pageContext.request.contextPath}/facility" class="nav-item ${currentPage eq 'facility' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="3" y1="9" x2="21" y2="9"></line>
                        <line x1="9" y1="21" x2="9" y2="9"></line>
                    </svg>
                    시설 관리
                </a>
            </c:when>
            <c:otherwise>
                <!-- 일반 사용자용 메뉴 (이미지에 보이는 메뉴) -->
                <a href="${pageContext.request.contextPath}/" class="nav-item ${currentPage eq 'home' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                    </svg>
                    Home
                </a>
                <a href="taskList.ta" class="nav-item ${currentPage eq 'task' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                        <polyline points="14 2 14 8 20 8"></polyline>
                        <line x1="16" y1="13" x2="8" y2="13"></line>
                        <line x1="16" y1="17" x2="8" y2="17"></line>
                        <polyline points="10 9 9 9 8 9"></polyline>
                    </svg>
                    업무 관리
                </a>
                <a href="${pageContext.request.contextPath}/schedule" class="nav-item ${currentPage eq 'schedule' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="16" y1="2" x2="16" y2="6"></line>
                        <line x1="8" y1="2" x2="8" y2="6"></line>
                        <line x1="3" y1="10" x2="21" y2="10"></line>
                    </svg>
                    일정
                </a>
                <a href="${pageContext.request.contextPath}/attendance" class="nav-item ${currentPage eq 'attendance' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
                        <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                        <line x1="17.5" y1="6.5" x2="17.5" y2="6.5"></line>
                    </svg>
                    근태 관리
                </a>
                <a href="${pageContext.request.contextPath}/address" class="nav-item ${currentPage eq 'address' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                    </svg>
                    주소록
                </a>
                <a href="${pageContext.request.contextPath}/approval" class="nav-item ${currentPage eq 'approval' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polyline points="9 11 12 14 22 4"></polyline>
                        <path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path>
                    </svg>
                    전자 결재
                </a>
                <a href="${pageContext.request.contextPath}/facility-reservation" class="nav-item ${currentPage eq 'facility' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="3" y1="9" x2="21" y2="9"></line>
                        <line x1="9" y1="21" x2="9" y2="9"></line>
                    </svg>
                    시설 예약
                </a>
                <a href="${pageContext.request.contextPath}/help" class="nav-item ${currentPage eq 'help' ? 'active' : ''}">
                    <svg class="nav-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="12" cy="12" r="10"></circle>
                        <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
                        <line x1="12" y1="17" x2="12.01" y2="17"></line>
                    </svg>
                    Help
                </a>
            </c:otherwise>
        </c:choose>
        
        <div class="search-container">
            <input type="text" class="search-bar" placeholder="Search...">
            <svg class="search-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="11" cy="11" r="8"></circle>
                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
            </svg>
        </div>
    </div>
</nav>