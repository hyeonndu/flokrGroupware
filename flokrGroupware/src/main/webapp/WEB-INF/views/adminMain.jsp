<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>관리자 대시보드</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminMain.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminMain.css">
  <!-- 아이콘 사용을 위한 Font Awesome CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
  <jsp:include page="common/header.jsp"/>
  
  <!-- 관리자 대시보드 메인 콘텐츠 -->
  <main class="dashboard">
    <div class="dashboard-title">
      <h1>관리자 대시보드</h1>
      <p>조직 관리와 시스템 설정을 할 수 있습니다.</p>
    </div>
    
    <!-- 주요 통계 수치 -->
    <div class="admin-stats">
      <div class="stat-card">
        <div class="stat-icon icon-employees">
          <i class="fas fa-users"></i>
        </div>
        <div class="stat-title">총 직원 수</div>
        <div class="stat-value">${totalEmployeeCount}</div>
      </div>
      
      <div class="stat-card">
        <div class="stat-icon icon-departments">
          <i class="fas fa-sitemap"></i>
        </div>
        <div class="stat-title">부서 수</div>
        <div class="stat-value">${departmentCount}</div>
      </div>
      
      <div class="stat-card">
        <div class="stat-icon icon-active">
          <i class="fas fa-user-check"></i>
        </div>
        <div class="stat-title">현재 접속자</div>
        <div class="stat-value">${activeUserCount}</div>
      </div>
      
      <div class="stat-card">
        <div class="stat-icon icon-notices">
          <i class="fas fa-bullhorn"></i>
        </div>
        <div class="stat-title">공지사항</div>
        <div class="stat-value">${noticeCount}</div>
      </div>
    </div>
    
    <!-- 관리자 기능 카드 -->
    <div class="admin-features">
      <!-- 조직 관리 카드 -->
      <div class="feature-card">
        <div class="feature-header">
          <div class="feature-icon organization">
            <i class="fas fa-sitemap"></i>
          </div>
          <h2 class="feature-title">조직 관리</h2>
        </div>
        <p class="feature-description">
          부서와 직급 정보를 관리하고 조직도를 설정합니다.
        </p>
        <div class="feature-actions">
          <a href="${pageContext.request.contextPath}/adminOrganization" class="feature-btn primary">조직도 관리</a>
          <a href="${pageContext.request.contextPath}/adminDepartment" class="feature-btn">부서 관리</a>
        </div>
      </div>
      
      <!-- 사원 등록 카드 -->
      <div class="feature-card">
        <div class="feature-header">
          <div class="feature-icon employee">
            <i class="fas fa-user-plus"></i>
          </div>
          <h2 class="feature-title">사원 등록</h2>
        </div>
        <p class="feature-description">
          신규 직원 정보를 등록하고 관리합니다.
        </p>
        <div class="feature-actions">
          <a href="${pageContext.request.contextPath}/employeeRegister" class="feature-btn primary">신규 등록</a>
          <a href="${pageContext.request.contextPath}/employeeList" class="feature-btn">사원 목록</a>
        </div>
      </div>
      
      <!-- 사내 공지 관리 카드 -->
      <div class="feature-card">
        <div class="feature-header">
          <div class="feature-icon notice">
            <i class="fas fa-bullhorn"></i>
          </div>
          <h2 class="feature-title">사내 공지 관리</h2>
        </div>
        <p class="feature-description">
          공지사항을 등록하고 관리합니다.
        </p>
        <div class="feature-actions">
          <a href="${pageContext.request.contextPath}/noticeCreate" class="feature-btn primary">공지 등록</a>
          <a href="${pageContext.request.contextPath}/noticeList" class="feature-btn">공지 목록</a>
          <a href="${pageContext.request.contextPath}/notificationAdmin" class="feature-btn">알림 관리</a>
        </div>
      </div>
      
      <!-- 접속 사용자 관리 카드 -->
      <div class="feature-card">
        <div class="feature-header">
          <div class="feature-icon organization">
            <i class="fas fa-users"></i>
          </div>
          <h2 class="feature-title">접속 사용자 관리</h2>
        </div>
        <p class="feature-description">
          현재 시스템에 접속 중인 사용자를 관리합니다.
        </p>
        <div class="feature-actions">
          <a href="${pageContext.request.contextPath}/onlineUsers" class="feature-btn primary">접속자 관리</a>
          <a href="${pageContext.request.contextPath}/userLogs" class="feature-btn">로그 조회</a>
        </div>
      </div>
      
      <!-- 계정 및 권한 관리 카드 -->
      <div class="feature-card">
        <div class="feature-header">
          <div class="feature-icon user">
            <i class="fas fa-user-shield"></i>
          </div>
          <h2 class="feature-title">사용자 정보 관리</h2>
        </div>
        <p class="feature-description">
          사용자 권한 설정 및 계정 정보를 관리합니다.
        </p>
        <div class="feature-actions">
          <a href="${pageContext.request.contextPath}/userPermissions" class="feature-btn primary">권한 설정</a>
          <a href="${pageContext.request.contextPath}/userInformation" class="feature-btn">사용자 정보 관리</a>
        </div>
      </div>
      
      <!-- 시설 관리 카드 -->
      <div class="feature-card">
        <div class="feature-header">
          <div class="feature-icon facility">
            <i class="fas fa-building"></i>
          </div>
          <h2 class="feature-title">시설 관리</h2>
        </div>
        <p class="feature-description">
          회의실, 공용 장비 등 사내 시설을 관리합니다.
        </p>
        <div class="feature-actions">
          <a href="${pageContext.request.contextPath}/adminFacility" class="feature-btn primary">시설 현황</a>
          <a href="${pageContext.request.contextPath}/facilityReservation" class="feature-btn">예약 관리</a>
        </div>
      </div>
    </div>
  </main>
</body>
</html>