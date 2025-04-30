<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>공지사항 목록</title>
  <!-- jQuery 라이브러리 -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <!-- Font Awesome CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <!-- Alertify -->
  <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
  <style>  
    .notice-container {
      max-width: 1280px;
      margin: 0 auto;
      padding: 2rem 1.5rem;
    }
    
    .notice-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1.5rem;
    }
    
    .notice-title h1 {
      font-size: 1.75rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
    }
    
    .notice-title p {
      color: #64748b;
      font-size: 0.95rem;
    }
    
    .notice-actions {
      display: flex;
      gap: 0.5rem;
    }
    
    .btn {
      padding: 0.5rem 1rem;
      border-radius: 4px;
      font-size: 0.95rem;
      cursor: pointer;
      transition: all 0.2s;
      border: none;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      justify-content: center;
    }
    
    .btn-primary {
      background-color: #003561;
      color: white;
    }
    
    .btn-primary:hover {
      background-color: #002a4c;
    }
    
    .btn-secondary {
      background-color: #e2e8f0;
      color: #333;
    }
    
    .btn-secondary:hover {
      background-color: #cbd5e1;
    }
    
    .btn i {
      margin-right: 0.25rem;
    }
    
    /* 검색 및 필터 */
    .notice-filters {
      display: flex;
      margin-bottom: 1rem;
      gap: 0.5rem;
      align-items: center;
    }
    
    .notice-search {
      display: flex;
      flex-grow: 1;
      max-width: 400px;
    }
    
    .notice-search input {
      flex-grow: 1;
      padding: 0.5rem 1rem;
      border: 1px solid #e2e8f0;
      border-radius: 4px 0 0 4px;
      outline: none;
    }
    
    .notice-search button {
      background-color: #003561;
      color: white;
      border: none;
      padding: 0.5rem 1rem;
      border-radius: 0 4px 4px 0;
      cursor: pointer;
    }
    
    .notice-select {
      padding: 0.5rem 1rem;
      border: 1px solid #e2e8f0;
      border-radius: 4px;
      outline: none;
    }
    
    /* 공지사항 테이블 */
    .notice-table-container {
      overflow-x: auto;
    }
    
    .notice-table {
      width: 100%;
      border-collapse: collapse;
      font-size: 0.9rem;
    }
    
    .notice-table th,
    .notice-table td {
      padding: 0.75rem 1rem;
      text-align: left;
      border-bottom: 1px solid #e2e8f0;
    }
    
    .notice-table th {
      background-color: #f5f7fb;
      font-weight: 600;
    }
    
    .notice-table tr:hover {
      background-color: #f1f5f9;
    }
    
    .notice-mandatory {
      background-color: #fee2e2;
      color: #b91c1c;
      padding: 0.2rem 0.5rem;
      border-radius: 4px;
      font-size: 0.8rem;
      font-weight: 600;
    }
    
    .notice-title-link {
      color: #333;
      text-decoration: none;
      font-weight: 500;
    }
    
    .notice-title-link:hover {
      color: #003561;
      text-decoration: none;
    }
    
    /* 페이지네이션 */
    .notice-pagination {
      display: flex;
      justify-content: center;
      margin-top: 1.5rem;
      gap: 0.25rem;
    }
    
    .notice-pagination a {
      padding: 0.5rem 0.75rem;
      border: 1px solid #e2e8f0;
      border-radius: 4px;
      color: #64748b;
      text-decoration: none;
      transition: all 0.2s;
    }
    
    .notice-pagination a:hover {
      background-color: #f1f5f9;
    }
    
    .notice-pagination a.active {
      background-color: #003561;
      color: white;
      border-color: #003561;
    }
    
    /* 빈 공지사항 메시지 */
    .empty-notice {
      text-align: center;
      padding: 3rem 2rem;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
      color: #64748b;
    }
    
    .empty-notice i {
      font-size: 3rem;
      color: #e2e8f0;
      margin-bottom: 1rem;
      display: block;
    }
  </style>
</head>
<body>
  <jsp:include page="../common/header.jsp"/>
  
  <main class="notice-container">
    <div class="notice-header">
      <div class="notice-title">
        <h1>공지사항</h1>
        <p>중요한 소식과 안내사항을 확인하세요.</p>
      </div>
      
      <c:if test="${loginUser.isAdmin eq 'Y'}">
        <div class="notice-actions">
          <a href="${pageContext.request.contextPath}/noticeCreate" class="btn btn-primary">
            <i class="fas fa-plus"></i> 공지사항 등록
          </a>
        </div>
      </c:if>
    </div>
    
    <!-- 검색 및 필터 -->
    <div class="notice-filters">
      <select class="notice-select" id="categoryFilter">
        <option value="">전체 분류</option>
        <option value="GENERAL" ${category eq 'GENERAL' ? 'selected' : ''}>일반</option>
        <option value="EVENT" ${category eq 'EVENT' ? 'selected' : ''}>행사</option>
        <option value="SYSTEM" ${category eq 'SYSTEM' ? 'selected' : ''}>시스템</option>
        <option value="HR" ${category eq 'HR' ? 'selected' : ''}>인사</option>
      </select>
      
      <div class="notice-search">
        <input type="text" id="searchKeyword" placeholder="검색어 입력" value="${keyword}">
        <button id="searchBtn"><i class="fas fa-search"></i></button>
      </div>
    </div>
    
    <!-- 공지사항 테이블 -->
    <div class="notice-table-container">
      <table class="notice-table">
        <thead>
          <tr>
            <th width="7%">번호</th>
            <th width="15%">분류</th>
            <th width="45%">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">작성일</th>
            <th width="8%">조회수</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty noticeList}">
              <tr>
                <td colspan="6">
                  <div class="empty-notice">
                    <i class="fas fa-clipboard"></i>
                    <p>등록된 공지사항이 없습니다.</p>
                  </div>
                </td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach items="${noticeList}" var="notice">
                <tr>
                  <td>${notice.noticeNo}</td>
                  <td>
                    <c:choose>
                      <c:when test="${notice.category eq 'GENERAL'}">일반</c:when>
                      <c:when test="${notice.category eq 'EVENT'}">행사</c:when>
                      <c:when test="${notice.category eq 'SYSTEM'}">시스템</c:when>
                      <c:when test="${notice.category eq 'HR'}">인사</c:when>
                      <c:otherwise>${notice.category}</c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <a href="${pageContext.request.contextPath}/noticeDetail/${notice.noticeNo}" class="notice-title-link">
                      <c:if test="${notice.isMandatory eq 1}">
                        <span class="notice-mandatory">필독</span>
                      </c:if>
                      ${notice.noticeTitle}
                    </a>
                  </td>
                  <td>${notice.noticeWriter}</td>
                  <td>
                    <fmt:formatDate value="${notice.createDate}" pattern="yyyy-MM-dd" />
                  </td>
                  <td>${notice.viewCount}</td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
    
    <!-- 페이지네이션 -->
    <c:if test="${not empty noticeList}">
      <div class="notice-pagination">
        <c:if test="${pi.currentPage > 1}">
          <a href="${pageContext.request.contextPath}/noticeList?page=1&category=${category}&keyword=${keyword}">
            <i class="fas fa-angle-double-left"></i>
          </a>
          <a href="${pageContext.request.contextPath}/noticeList?page=${pi.currentPage - 1}&category=${category}&keyword=${keyword}">
            <i class="fas fa-angle-left"></i>
          </a>
        </c:if>
        
        <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
          <c:choose>
            <c:when test="${p eq pi.currentPage}">
              <a href="#" class="active">${p}</a>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/noticeList?page=${p}&category=${category}&keyword=${keyword}">${p}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>
        
        <c:if test="${pi.currentPage < pi.maxPage}">
          <a href="${pageContext.request.contextPath}/noticeList?page=${pi.currentPage + 1}&category=${category}&keyword=${keyword}">
            <i class="fas fa-angle-right"></i>
          </a>
          <a href="${pageContext.request.contextPath}/noticeList?page=${pi.maxPage}&category=${category}&keyword=${keyword}">
            <i class="fas fa-angle-double-right"></i>
          </a>
        </c:if>
      </div>
    </c:if>
  </main>
  
  <script>
    $(document).ready(function() {
      // 검색 기능
      $('#searchBtn').click(function() {
        const category = $('#categoryFilter').val();
        const keyword = $('#searchKeyword').val();
        
        location.href = "${pageContext.request.contextPath}/noticeList?category=" + category + "&keyword=" + keyword;
      });
      
      // 카테고리 필터 변경 시 즉시 검색
      $('#categoryFilter').change(function() {
        const category = $(this).val();
        const keyword = $('#searchKeyword').val();
        
        location.href = "${pageContext.request.contextPath}/noticeList?category=" + category + "&keyword=" + keyword;
      });
      
      // 검색어 입력 후 엔터키 처리
      $('#searchKeyword').keypress(function(e) {
        if (e.which == 13) {
          $('#searchBtn').click();
        }
      });
    });
  </script>
</body>
</html>