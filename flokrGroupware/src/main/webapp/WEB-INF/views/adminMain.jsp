<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>관리자 대시보드</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Noto Sans KR', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    }
    
    body {
      background-color: #f5f7fb;
      color: #333;
      line-height: 1.5;
    }
    
    /* 대시보드 메인 콘텐츠 */
    .dashboard {
      max-width: 1280px;
      margin: 0 auto;
      padding: 2rem 1.5rem;
    }
    
    .dashboard-title {
      margin-bottom: 1.5rem;
    }
    
    .dashboard-title h1 {
      font-size: 1.75rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
    }
    
    .dashboard-title p {
      color: #64748b;
      font-size: 0.95rem;
    }
    
    .admin-stats {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 1.5rem;
      margin-bottom: 1.5rem;
    }
    
    .stat-card {
      background-color: #fff;
      border-radius: 8px;
      padding: 1.25rem;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
      text-align: -webkit-center;
    }
    
    .stat-icon {
      width: 40px;
      height: 40px;
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 1rem;
    }
    
    .icon-employees {
      background-color: #ebf5ff;
      color: #0078ff;
    }
    
    .icon-departments {
      background-color: #e6f8f1;
      color: #00b97c;
    }
    
    .icon-active {
      background-color: #e6f2fe;
      color: #4273e8;
    }
    
    .icon-notices {
      background-color: #fef2e6;
      color: #ff9500;
    }
    
    .stat-title {
      font-size: 0.85rem;
      color: #64748b;
      margin-bottom: 0.5rem;
    }
    
    .stat-value {
      font-size: 1.5rem;
      font-weight: 600;
    }
    
    /* 관리자 기능 카드 */
    .admin-features {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 1.5rem;
      margin-bottom: 2rem;
    }
    
    .feature-card {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
      padding: 1.5rem;
      display: flex;
      flex-direction: column;
    }
    
    .feature-header {
      display: flex;
      align-items: center;
      margin-bottom: 1rem;
    }
    
    .feature-icon {
      width: 40px;
      height: 40px;
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 1rem;
    }
    
    .feature-icon.organization {
      background-color: #ebf5ff;
      color: #0078ff;
    }
    
    .feature-icon.employee {
      background-color: #e6f8f1;
      color: #00b97c;
    }
    
    .feature-icon.notice {
      background-color: #fef2e6;
      color: #ff9500;
    }
    
    .feature-icon.user {
      background-color: #e6f2fe;
      color: #4273e8;
    }
    
    .feature-icon.facility {
      background-color: #f6e3fe;
      color: #9333ea;
    }
    
    .feature-title {
      font-size: 1.1rem;
      font-weight: 600;
    }
    
    .feature-description {
      color: #64748b;
      font-size: 0.875rem;
      margin-bottom: 1.5rem;
      flex-grow: 1;
    }
    
    .feature-actions {
      display: flex;
      gap: 0.75rem;
    }
    
    .feature-btn {
      padding: 0.5rem 1rem;
      background-color: #f1f5f9;
      color: #333;
      border: none;
      border-radius: 4px;
      font-size: 0.875rem;
      cursor: pointer;
      transition: all 0.2s;
      text-decoration: none;
    }
    
    .feature-btn:hover {
      background-color: #e2e8f0;
    }
    
    .feature-btn.primary {
      background-color: #003561;
      color: white;
    }
    
    .feature-btn.primary:hover {
      background-color: #002a4c;
    }
    
    /* 아이콘 추가 */
    .icon {
      font-size: 1.2rem;
    }
  </style>
  <!-- 아이콘 사용을 위한 Font Awesome CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
  <!-- 헤더 인클루드 -->
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
    
    <!-- 관리자 기능 카드 - 헤더 메뉴와 일치하게 수정 -->
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
          <a href="${pageContext.request.contextPath}/admin/organization" class="feature-btn primary">조직도 관리</a>
          <a href="${pageContext.request.contextPath}/admin/department" class="feature-btn">부서 관리</a>
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
          <a href="${pageContext.request.contextPath}/employee/register" class="feature-btn primary">신규 등록</a>
          <a href="${pageContext.request.contextPath}/admin/employee/list" class="feature-btn">사원 목록</a>
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
          <a href="${pageContext.request.contextPath}/admin/notice/create" class="feature-btn primary">공지 등록</a>
          <a href="${pageContext.request.contextPath}/admin/notice/list" class="feature-btn">공지 목록</a>
          <a href="${pageContext.request.contextPath}/notification/admin" class="feature-btn">알림 관리</a>
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
          <a href="${pageContext.request.contextPath}/admin/online-users" class="feature-btn primary">접속자 관리</a>
          <a href="${pageContext.request.contextPath}/admin/user-logs" class="feature-btn">로그 조회</a>
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
          <a href="${pageContext.request.contextPath}/admin/user-permissions" class="feature-btn primary">권한 설정</a>
          <a href="${pageContext.request.contextPath}/admin/password-reset" class="feature-btn">사용자 정보 관리</a>
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
          <a href="${pageContext.request.contextPath}/admin/facility" class="feature-btn primary">시설 현황</a>
          <a href="${pageContext.request.contextPath}/admin/facility/reservation" class="feature-btn">예약 관리</a>
        </div>
      </div>
    </div>
  </main>
</body>
</html>