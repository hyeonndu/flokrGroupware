<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>모든 알림</title>
  <!-- jQuery 라이브러리 -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <!-- Font Awesome CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <!-- Alertify -->
  <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
  <style>
    .notificationAll-page {
      max-width: 1280px;
      margin: 0 auto;
      padding: 2rem 1.5rem;
      box-sizing: border-box;
    }
    
    .notificationAll-title {
      margin-bottom: 1.5rem;
    }
    
    .notificationAll-title h1 {
      font-size: 1.75rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
    }
    
    .notificationAll-title p {
      color: #64748b;
      font-size: 0.95rem;
    }
    
    .notificationAll-item {
      padding: 10px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
      /* transition: all 0.2s ease; */
      width: 100%;
      box-sizing: border-box;
      border: 1px solid #e9ecef;
      position: relative;
      margin-bottom: 0.5rem;
    }
    
    .notificationAll-list {
      margin-bottom: 1.5rem;
      width: 100%;
    }
    
    .notificationAll-item.unread {
      background-color: #f0f5ff;
    }
    
    .notificationAll-item.unread::before {
      content: "";
      position: absolute;
      top: 1rem;
      right: 1rem;
      width: 8px;
      height: 8px;
      background-color: #003561;
      border-radius: 50%;
    }
    
    .notificationAll-item:hover {
      background-color: #f8fafc;
      transform: translateY(-2px);
      box-shadow: 0 4px 6px rgba(0,0,0,0.05);
    }
    
    .notificationAll-item:active {
      transform: scale(0.99);
    }
    
    .notificationAll-content h3 {
      font-size: 1.1rem;
      font-weight: 500;
      margin-bottom: 0.5rem;
      color: #333;
    }
    
    .notificationAll-item.unread .notificationAll-content h3 {
      font-weight: 700;
      color: #002548;
    }
    
    .notificationAll-content p {
      color: #64748b;
      margin-bottom: 0.5rem;
    }
    
    .notificationAll-meta {
      display: flex;
      justify-content: space-between;
      font-size: 0.85rem;
      color: #94a3b8;
      margin-top: 0.75rem;
    }
    
    .notificationAll-type {
      display: inline-flex;
      align-items: center;
      padding: 0.3rem 0.6rem;
      border-radius: 4px;
      font-size: 0.8rem;
      font-weight: 600;
    }
    
    .notificationAll-type.NOTICE {
      background-color: #e3f2fd;
      color: #0277bd;
    }
    
    .notificationAll-type.APPROVAL {
      background-color: #e8f5e9;
      color: #2e7d32;
    }
    
    .notificationAll-type.TASK {
      background-color: #fff8e1;
      color: #ff8f00;
    }
    
    .notificationAll-type.CHAT {
      background-color: #f3e5f5;
      color: #7b1fa2;
    }
    
    .notificationAll-type.SCHEDULE {
      background-color: #e8eaf6;
      color: #3949ab;
    }
    
    .notificationAll-time {
      font-size: 0.8rem;
    }
    
    .notificationAll-empty {
      text-align: center;
      padding: 3rem 2rem;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
      color: #64748b;
    }
    
    .notificationAll-empty i {
      font-size: 3rem;
      color: #e2e8f0;
      margin-bottom: 1rem;
      display: block;
    }
    
    /* 페이지네이션 */
    .notificationAll-pagination {
      display: flex;
      justify-content: center;
      margin-top: 2rem;
      gap: 0.25rem;
    }
    
    .notificationAll-pagination a {
      padding: 0.5rem 0.75rem;
      border: 1px solid #e2e8f0;
      border-radius: 4px;
      color: #64748b;
      text-decoration: none;
      transition: all 0.2s;
    }
    
    .notificationAll-pagination a:hover {
      background-color: #f1f5f9;
      color: #003561;
    }
    
    .notificationAll-pagination a.active {
      background-color: #003561;
      color: white;
      border-color: #003561;
    }
  </style>
</head>
<body>
  <jsp:include page="../common/header.jsp"/>
  
  <main class="notificationAll-page">
    <div class="notificationAll-title">
      <h1>모든 알림</h1>
      <p>수신한 모든 알림을 확인할 수 있습니다.</p>
    </div>
    
    <!-- 알림 목록 -->
    <div class="notificationAll-list">
      <c:choose>
        <c:when test="${empty notifications}">
          <div class="notificationAll-empty">
            <i class="fas fa-bell-slash"></i>
            <p>알림이 없습니다.</p>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach items="${notifications}" var="notification">
            <div class="notificationAll-item ${empty notification.readDate ? 'unread' : ''}" 
                 data-no="${notification.notificationNo}" 
                 onclick="markAsRead(${notification.notificationNo})">
              <div class="notificationAll-content">
                <h3>${notification.title}</h3>
                <p>${notification.notificationContent}</p>
                <div class="notificationAll-meta">
                  <span class="notificationAll-type ${notification.type}">
                    <c:choose>
                      <c:when test="${notification.type eq 'NOTICE'}">
                        <i class="fas fa-bullhorn mr-1"></i> 공지사항
                      </c:when>
                      <c:when test="${notification.type eq 'APPROVAL'}">
                        <i class="fas fa-file-signature mr-1"></i> 결재
                      </c:when>
                      <c:when test="${notification.type eq 'TASK'}">
                        <i class="fas fa-tasks mr-1"></i> 업무
                      </c:when>
                      <c:when test="${notification.type eq 'CHAT'}">
                        <i class="fas fa-comment-dots mr-1"></i> 채팅
                      </c:when>
                      <c:when test="${notification.type eq 'SCHEDULE'}">
                        <i class="fas fa-calendar-alt mr-1"></i> 일정
                      </c:when>
                      <c:otherwise>${notification.type}</c:otherwise>
                    </c:choose>
                  </span>
                  <span class="notificationAll-time">
                    <fmt:formatDate value="${notification.createDate}" pattern="yyyy-MM-dd HH:mm" />
                  </span>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
    
    <!-- 페이지네이션 -->
    <c:if test="${not empty notifications}">
      <div class="notificationAll-pagination">
        <c:if test="${currentPage > 1}">
          <a href="${pageContext.request.contextPath}/notificationAll?page=1">
            <i class="fas fa-angle-double-left"></i>
          </a>
          <a href="${pageContext.request.contextPath}/notificationAll?page=${currentPage - 1}">
            <i class="fas fa-angle-left"></i>
          </a>
        </c:if>
        
        <c:forEach var="p" begin="${startPage}" end="${endPage}">
          <c:choose>
            <c:when test="${p eq currentPage}">
              <a href="#" class="active">${p}</a>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/notificationAll?page=${p}">${p}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>
        
        <c:if test="${currentPage < maxPage}">
          <a href="${pageContext.request.contextPath}/notificationAll?page=${currentPage + 1}">
            <i class="fas fa-angle-right"></i>
          </a>
          <a href="${pageContext.request.contextPath}/notificationAll?page=${maxPage}">
            <i class="fas fa-angle-double-right"></i>
          </a>
        </c:if>
      </div>
    </c:if>
  </main>
  
  <script>
    // 알림 읽음 처리 함수
    function markAsRead(notificationNo) {
      if(notificationNo) {
        // 읽음 처리 AJAX 요청
        $.ajax({
          url: '${pageContext.request.contextPath}/notificationRead/' + notificationNo,
          type: 'POST',
          success: function(response) {
            if(response.success) {
              // 알림의 링크 정보가 있으면 해당 페이지로 이동
              const item = $('[data-no="' + notificationNo + '"]');
              item.removeClass('unread');
              
              // 확인 표시를 애니메이션으로 보여주기
              alertify.success("알림을 확인했습니다.");
              
              // 추가적인 로직: 읽지 않은 알림 개수 업데이트 등
              updateUnreadCount();
              
              // 알림에 연결된 페이지가 있으면 해당 페이지로 이동
              if(response.refType && response.refNo) {
                setTimeout(function() {
                  location.href = getRedirectUrl(response.refType, response.refNo);
                }, 500);
              }
            }
          },
          error: function(xhr, status, error) {
            console.error("알림 읽음 처리 오류:", error);
            alertify.error("알림 처리 중 오류가 발생했습니다.");
          }
        });
      }
    }
    
    // 읽지 않은 알림 개수 업데이트 함수
    function updateUnreadCount() {
      $.ajax({
        url: '${pageContext.request.contextPath}/notificationCount',
        type: 'GET',
        success: function(count) {
          // 헤더의 알림 카운트 업데이트 (헤더에 따라 선택자 조정 필요)
          const badgeElement = $('#headerNotificationBadge');
          if(badgeElement.length) {
            if(count > 0) {
              badgeElement.text(count).show();
            } else {
              badgeElement.hide();
            }
          }
        }
      });
    }
    
    // 알림 타입에 따른 리다이렉트 URL 생성
    function getRedirectUrl(refType, refNo) {
      const contextPath = '${pageContext.request.contextPath}';
      
      switch(refType) {
        case 'notice':
          return contextPath + '/notice/detail/' + refNo;
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
    
    $(document).ready(function() {
      // 페이지 로드 시 추가 기능 구현 가능
    });
  </script>
</body>
</html>