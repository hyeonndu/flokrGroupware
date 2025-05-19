<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상신 문서함 | Flokr</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 전체 스타일 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background-color: #f5f7fa;
            color: #333;
        }
        
        .aprequest-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .aprequest-header {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .aprequest-title {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .aprequest-subtitle {
            font-size: 14px;
            color: #777;
        }
        
        .aprequest-count {
            color: #003561;
            font-weight: 600;
        }
        
        .aprequest-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }
        
        .aprequest-search-form {
            display: flex;
            gap: 10px;
            flex: 1;
            max-width: 500px;
        }
        
        .aprequest-search-select {
            width: 120px;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            background: white;
        }
        
        .aprequest-search-input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }
        
        .aprequest-search-btn {
            padding: 8px 16px;
            background: #003561;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
           font-size: 14px;
       }
       
       .aprequest-filter-section {
           margin-top: 15px;
           display: flex;
           gap: 10px;
           align-items: center;
       }
       
       .aprequest-filter-label {
           font-size: 14px;
           color: #666;
       }
       
       .aprequest-filter-select {
           padding: 6px 10px;
           border: 1px solid #ddd;
           border-radius: 4px;
           font-size: 13px;
       }
       
       .aprequest-table-container {
           background: white;
           border-radius: 12px;
           box-shadow: 0 2px 8px rgba(0,0,0,0.05);
           overflow: hidden;
       }
       
       .aprequest-table {
           width: 100%;
           border-collapse: collapse;
           font-size: 14px;
       }
       
       .aprequest-table th,
       .aprequest-table td {
           padding: 15px;
           text-align: left;
           border-bottom: 1px solid #f0f0f0;
       }
       
       .aprequest-table th {
           background: #f8f9fa;
           color: #555;
           font-weight: 600;
           font-size: 13px;
           text-transform: uppercase;
       }
       
       .aprequest-table tr:hover {
           background: #f8f9fa;
       }
       
       .aprequest-doc-title {
           color: #003561;
           text-decoration: none;
           font-weight: 500;
       }
       
       .aprequest-doc-title:hover {
           text-decoration: underline;
       }
       
       .aprequest-status-badge {
           padding: 4px 8px;
           border-radius: 12px;
           font-size: 12px;
           font-weight: 500;
           display: inline-block;
       }
       
       .aprequest-status-requested {
           background: #e8f4fd;
           color: #2196f3;
       }
       
       .aprequest-status-approved {
           background: #e8f5e9;
           color: #4caf50;
       }
       
       .aprequest-status-rejected {
           background: #ffeaea;
           color: #f44336;
       }
       
       .aprequest-progress {
           display: flex;
           align-items: center;
           gap: 8px;
           font-size: 13px;
           color: #666;
       }
       
       .aprequest-progress-bar {
           width: 80px;
           height: 6px;
           background: #e9ecef;
           border-radius: 3px;
           overflow: hidden;
       }
       
       .aprequest-progress-fill {
           height: 100%;
           background: #2196f3;
           border-radius: 3px;
           transition: width 0.3s ease;
       }
       
       .aprequest-empty {
           text-align: center;
           padding: 50px 20px;
           color: #888;
       }
       
       .aprequest-empty i {
           font-size: 48px;
           margin-bottom: 15px;
           color: #ddd;
       }
       
       .aprequest-pagination {
           display: flex;
           justify-content: center;
           align-items: center;
           margin-top: 30px;
           gap: 5px;
       }
       
       .aprequest-page-link {
           padding: 8px 12px;
           border: 1px solid #ddd;
           border-radius: 4px;
           text-decoration: none;
           color: #666;
           background: white;
           transition: all 0.2s;
       }
       
       .aprequest-page-link:hover {
           background: #f8f9fa;
           border-color: #999;
       }
       
       .aprequest-page-link.active {
           background: #003561;
           color: white;
           border-color: #003561;
       }
       
       .aprequest-page-link.disabled {
           color: #ccc;
           cursor: not-allowed;
       }
       
       .aprequest-page-info {
           color: #666;
           font-size: 14px;
           margin-top: 15px;
           text-align: center;
       }
   </style>
</head>
<body>
   <!-- header.jsp include -->
   <jsp:include page="../common/header.jsp" />

   <div class="aprequest-container">
       <div class="aprequest-header">
           <h1 class="aprequest-title">
               <i class="fas fa-paper-plane"></i>
               상신 문서함
           </h1>
           <p class="aprequest-subtitle">
               내가 결재 요청한 문서 목록입니다. 
               <span class="aprequest-count">총 ${pageInfo.listCount}건</span>
           </p>
           
           <div class="aprequest-actions">
               <form class="aprequest-search-form" method="get" action="searchDocuments.ap">
    <input type="hidden" name="boxType" value="requested">
    <select name="searchType" class="aprequest-search-select">
        <option value="">전체</option>
        <option value="title" ${searchType eq 'title' ? 'selected' : ''}>제목</option>
        <option value="form" ${searchType eq 'form' ? 'selected' : ''}>양식</option>
    </select>
    <input type="text" name="keyword" class="aprequest-search-input" 
           placeholder="검색어를 입력하세요" value="${keyword}">
    <button type="submit" class="aprequest-search-btn">
        <i class="fas fa-search"></i> 검색
    </button>
</form>
           </div>
           
           <div class="aprequest-filter-section">
			    <span class="aprequest-filter-label">상태별 필터:</span>
			    <select name="statusFilter" class="aprequest-filter-select" onchange="filterByStatus(this.value)">
			        <option value="" ${empty statusFilter ? 'selected' : ''}>전체</option>
			        <option value="REQUESTED" ${statusFilter eq 'REQUESTED' ? 'selected' : ''}>진행중</option>
			        <option value="APPROVED" ${statusFilter eq 'APPROVED' ? 'selected' : ''}>승인</option>
			        <option value="REJECTED" ${statusFilter eq 'REJECTED' ? 'selected' : ''}>반려</option>
			    </select>
			</div>
       </div>
       
       <div class="aprequest-table-container">
           <table class="aprequest-table">
               <thead>
                   <tr>
                       <th>번호</th>
                       <th>양식</th>
                       <th>제목</th>
                       <th>상신일시</th>
                       <th>결재 진행</th>
                       <th>상태</th>
                       <th>결과</th>
                   </tr>
               </thead>
               <tbody>
                   <c:forEach var="doc" items="${documentList}" varStatus="status">
                       <tr>
                           <td>${pageInfo.listCount - ((pageInfo.currentPage - 1) * pageInfo.boardLimit + status.index)}</td>
                           <td>${doc.formName}</td>
                           <td>
                               <a href="documentDetail.ap?docNo=${doc.docNo}" class="aprequest-doc-title">
                                   ${doc.title}
                               </a>
                           </td>
                           <td>
                               <fmt:formatDate value="${doc.requestedDate}" pattern="yyyy-MM-dd HH:mm"/>
                           </td>
                           <td>
                               <div class="aprequest-progress">
                                   <div class="aprequest-progress-bar">
                                       <div class="aprequest-progress-fill" 
                                            style="width: ${doc.docStatus == 'APPROVED' ? '100' : (doc.docStatus == 'REJECTED' ? '100' : '50')}%"></div>
                                   </div>
                                   <span>
                                   		<c:choose>
									        <c:when test="${doc.docStatus == 'APPROVED'}">완료</c:when>
									        <c:when test="${doc.docStatus == 'REJECTED'}">반려</c:when>
									        <c:otherwise>진행중</c:otherwise>
									    </c:choose>
                                   </span>
                               </div>
                           </td>
                           <td>
                               <span class="aprequest-status-badge 
                                   <c:choose>
                                       <c:when test="${doc.docStatus == 'REQUESTED'}">aprequest-status-requested</c:when>
                                       <c:when test="${doc.docStatus == 'APPROVED'}">aprequest-status-approved</c:when>
                                       <c:when test="${doc.docStatus == 'REJECTED'}">aprequest-status-rejected</c:when>
                                   </c:choose>">
                                   <c:choose>
                                       <c:when test="${doc.docStatus == 'REQUESTED'}">결재진행중</c:when>
                                       <c:when test="${doc.docStatus == 'APPROVED'}">결재완료</c:when>
                                       <c:when test="${doc.docStatus == 'REJECTED'}">결재반려</c:when>
                                   </c:choose>
                               </span>
                           </td>
                           <td>
                               <c:choose>
                                   <c:when test="${doc.docStatus == 'APPROVED'}">
                                       <fmt:formatDate value="${doc.completedDate}" pattern="MM-dd HH:mm"/>
                                   </c:when>
                                   <c:when test="${doc.docStatus == 'REJECTED'}">
                                       <span style="color: #f44336;">
                                           반려됨
                                       </span>
                                   </c:when>
                                   <c:otherwise>
                                       <span style="color: #666;">
                                           처리 대기중
                                       </span>
                                   </c:otherwise>
                               </c:choose>
                           </td>
                       </tr>
                   </c:forEach>
                   <c:if test="${empty documentList}">
                       <tr>
                           <td colspan="7">
                               <div class="aprequest-empty">
                                   <i class="far fa-paper-plane"></i>
                                   <p>상신한 문서가 없습니다.</p>
                               </div>
                           </td>
                       </tr>
                   </c:if>
               </tbody>
           </table>
       </div>
       
       <c:if test="${pageInfo.listCount > 0}">
           <div class="aprequest-pagination">
               <c:if test="${pageInfo.currentPage <= 1}">
                   <a href="#" class="aprequest-page-link disabled">
                       <i class="fas fa-angle-double-left"></i>
                   </a>
                   <a href="#" class="aprequest-page-link disabled">
                       <i class="fas fa-angle-left"></i>
                   </a>
               </c:if>
               <c:if test="${pageInfo.currentPage > 1}">
                   <a href="requestedList.ap?page=1" class="aprequest-page-link">
                       <i class="fas fa-angle-double-left"></i>
                   </a>
                   <a href="requestedList.ap?page=${pageInfo.currentPage - 1}" class="aprequest-page-link">
                       <i class="fas fa-angle-left"></i>
                   </a>
               </c:if>
               
               <c:forEach var="p" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
                   <a href="requestedList.ap?page=${p}" 
                      class="aprequest-page-link ${p == pageInfo.currentPage ? 'active' : ''}">${p}</a>
               </c:forEach>
               
               <c:if test="${pageInfo.currentPage >= pageInfo.maxPage}">
                   <a href="#" class="aprequest-page-link disabled">
                       <i class="fas fa-angle-right"></i>
                   </a>
                   <a href="#" class="aprequest-page-link disabled">
                       <i class="fas fa-angle-double-right"></i>
                   </a>
               </c:if>
               <c:if test="${pageInfo.currentPage < pageInfo.maxPage}">
                   <a href="requestedList.ap?page=${pageInfo.currentPage + 1}" class="aprequest-page-link">
                       <i class="fas fa-angle-right"></i>
                   </a>
                   <a href="requestedList.ap?page=${pageInfo.maxPage}" class="aprequest-page-link">
                       <i class="fas fa-angle-double-right"></i>
                   </a>
               </c:if>
           </div>
           <div class="aprequest-page-info">
               전체 ${pageInfo.listCount}건 중 ${pageInfo.currentPage}/${pageInfo.maxPage} 페이지
           </div>
       </c:if>
   </div>
   
   <script>
       function filterByStatus(status) {
    		// URL 파라미터 객체 생성
    	    let searchParams = new URLSearchParams(window.location.search);
    	    
    	    // 상태 필터 설정 (빈 값이면 파라미터 제거)
    	    if (status) {
    	        searchParams.set('statusFilter', status);
    	    } else {
    	        searchParams.delete('statusFilter');
    	    }
    	    
    	    // 현재 페이지 초기화
    	    searchParams.set('page', '1');
    	    
    	    // 리다이렉트
    	    window.location.href = 'requestedList.ap?' + searchParams.toString();
    	}
       
       // 검색폼 처리
       document.querySelector('.aprequest-search-form').addEventListener('submit', function(e) {
           const keyword = this.querySelector('input[name="keyword"]').value.trim();
           if (!keyword) {
               e.preventDefault();
               alert('검색어를 입력해주세요.');
           }
       });
   </script>
</body>
</html>