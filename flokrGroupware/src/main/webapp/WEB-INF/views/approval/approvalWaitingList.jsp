<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수신 문서함 | Flokr</title>
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
        
        .apwaiting-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .apwaiting-header {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .apwaiting-title {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .apwaiting-title-badge {
            background: #ff9800;
            color: white;
            font-size: 12px;
            font-weight: 500;
            padding: 4px 8px;
            border-radius: 12px;
        }
        
        .apwaiting-subtitle {
            font-size: 14px;
            color: #777;
        }
        
        .apwaiting-count {
            color: #ff9800;
            font-weight: 600;
        }
        
        .apwaiting-urgent-notice {
            background: #fff3e0;
            border: 1px solid #ffcc80;
            border-radius: 8px;
            padding: 10px 15px;
            margin-top: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
            color: #ff9800;
            font-size: 13px;
        }
        
        .apwaiting-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }
        
        .apwaiting-search-form {
            display: flex;
            gap: 10px;
            flex: 1;
            max-width: 500px;
        }
        
        .apwaiting-search-select {
            width: 120px;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            background: white;
        }
        
        .apwaiting-search-input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }
        
        .apwaiting-search-btn {
            padding: 8px 16px;
            background: #003561;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }
        
        .apwaiting-table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        
        .apwaiting-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        
        .apwaiting-table th,
        .apwaiting-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .apwaiting-table th {
            background: #f8f9fa;
            color: #555;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
        }
        
        .apwaiting-table tr:hover {
            background: #f8f9fa;
        }
        
        .apwaiting-table tr.urgent {
            background: #fff3e0;
        }
        
        .apwaiting-table tr.urgent:hover {
            background: #ffebcc;
        }
        
        .apwaiting-doc-title {
            color: #003561;
            text-decoration: none;
            font-weight: 500;
        }
        
        .apwaiting-doc-title:hover {
            text-decoration: underline;
        }
        
        .apwaiting-status-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
            background: #fff3e0;
            color: #ff9800;
        }
        
        .apwaiting-drafter {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }
        
        .apwaiting-drafter-name {
            font-weight: 500;
        }
        
        .apwaiting-drafter-dept {
            font-size: 12px;
            color: #777;
        }
        
        .apwaiting-deadline {
            font-size: 13px;
        }
        
        .apwaiting-deadline.overdue {
            color: #f44336;
            font-weight: 500;
        }
        
        .apwaiting-action-cell {
            text-align: center;
        }
        
        .apwaiting-action-btn {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
            border: none;
            margin: 0 3px;
            transition: all 0.2s;
        }
        
        .apwaiting-approve-btn {
            background: #28a745;
            color: white;
        }
        
        .apwaiting-approve-btn:hover {
            background: #218838;
        }
        
        .apwaiting-reject-btn {
            background: #dc3545;
            color: white;
        }
        
        .apwaiting-reject-btn:hover {
            background: #c82333;
        }
        
        .apwaiting-empty {
            text-align: center;
            padding: 50px 20px;
            color: #888;
        }
        
        .apwaiting-empty i {
            font-size: 48px;
            margin-bottom: 15px;
            color: #ddd;
        }
        
        .apwaiting-pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 30px;
            gap: 5px;
        }
        
        .apwaiting-page-link {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #666;
            background: white;
            transition: all 0.2s;
        }
        
        .apwaiting-page-link:hover {
            background: #f8f9fa;
            border-color: #999;
        }
        
        .apwaiting-page-link.active {
            background: #003561;
            color: white;
            border-color: #003561;
        }
        
        .apwaiting-page-link.disabled {
            color: #ccc;
            cursor: not-allowed;
        }
        
        .apwaiting-page-info {
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

    <div class="apwaiting-container">
        <div class="apwaiting-header">
            <h1 class="apwaiting-title">
                <i class="fas fa-inbox"></i>
                수신 문서함
                <span class="apwaiting-title-badge">${urgentCount}건 대기중</span>
            </h1>
            <p class="apwaiting-subtitle">
                내가 결재해야 할 문서 목록입니다. 
                <span class="apwaiting-count">총 ${pageInfo.listCount}건</span>
            </p>
            
            <c:if test="${urgentCount > 0}">
                <div class="apwaiting-urgent-notice">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span>긴급 결재가 ${urgentCount}건 있습니다. 빠른 처리 부탁드립니다.</span>
                </div>
            </c:if>
            
            <div class="apwaiting-actions">
                <form class="apwaiting-search-form" method="get" action="searchDocuments.ap">
				    <input type="hidden" name="boxType" value="waiting">
				    <select name="searchType" class="apwaiting-search-select">
				        <option value="">전체</option>
				        <option value="title" ${searchType eq 'title' ? 'selected' : ''}>제목</option>
				        <option value="drafter" ${searchType eq 'drafter' ? 'selected' : ''}>기안자</option>
				        <option value="form" ${searchType eq 'form' ? 'selected' : ''}>양식</option>
				    </select>
				    <input type="text" name="keyword" class="apwaiting-search-input" 
				           placeholder="검색어를 입력하세요" value="${keyword}">
				    <button type="submit" class="apwaiting-search-btn">
				        <i class="fas fa-search"></i> 검색
				    </button>
				</form>
            </div>
        </div>
        
        <div class="apwaiting-table-container">
            <table class="apwaiting-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>양식</th>
                        <th>제목</th>
                        <th>기안자</th>
                        <th>요청일</th>
                        <th>처리 기한</th>
                        <th>긴급도</th>
                        <th>결재</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="doc" items="${documentList}" varStatus="status">
                        <tr>
                            <td>${pageInfo.listCount - ((pageInfo.currentPage - 1) * pageInfo.boardLimit + status.index)}</td>
                            <td>${doc.formName}</td>
                            <td>
                                <a href="documentDetail.ap?docNo=${doc.docNo}" class="apwaiting-doc-title">
                                    ${doc.title}
                                </a>
                            </td>
                            <td>
                                <div class="apwaiting-drafter">
                                    <span class="apwaiting-drafter-name">${doc.drafterName}</span>
                                    <span class="apwaiting-drafter-dept">${doc.drafterDeptName}</span>
                                </div>
                            </td>
                            <td>
                                <fmt:formatDate value="${doc.requestedDate}" pattern="MM-dd HH:mm"/>
                            </td>
                            <td>
                                <c:set var="now" value="<%= new java.util.Date() %>"/>
							    <c:set var="isOverdue" value="${doc.requestedDate != null && ((now.time - doc.requestedDate.time) / (1000 * 60 * 60 * 24)) > 3}"/>
							    <span class="apwaiting-deadline ${isOverdue ? 'overdue' : ''}">
							        <c:choose>
							            <c:when test="${doc.requestedDate != null}">
							                <fmt:formatDate value="${doc.requestedDate}" pattern="MM-dd"/> 까지
							                <c:if test="${isOverdue}">(기한 초과)</c:if>
							            </c:when>
							            <c:otherwise>-</c:otherwise>
							        </c:choose>
							    </span>
                            </td>
                            <td class="apwaiting-action-cell">
                                <button class="apwaiting-action-btn apwaiting-approve-btn" 
                                        onclick="processApproval(${doc.docNo}, 'approve')">
                                    <i class="fas fa-check"></i> 승인
                                </button>
                                <button class="apwaiting-action-btn apwaiting-reject-btn" 
                                        onclick="processApproval(${doc.docNo}, 'reject')">
                                    <i class="fas fa-times"></i> 반려
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty documentList}">
                        <tr>
                            <td colspan="8">
                                <div class="apwaiting-empty">
                                    <i class="far fa-clock"></i>
                                    <p>결재 대기 중인 문서가 없습니다.</p>
                                    <p style="color: #999; font-size: 13px; margin-top: 5px;">모든 결재가 완료되었습니다.</p>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <c:if test="${pageInfo.listCount > 0}">
		    <div class="apwaiting-pagination">
		        <c:if test="${pageInfo.currentPage <= 1}">
		            <a href="#" class="apwaiting-page-link disabled">
		                <i class="fas fa-angle-double-left"></i>
		            </a>
		            <a href="#" class="apwaiting-page-link disabled">
		                <i class="fas fa-angle-left"></i>
		            </a>
		        </c:if>
		        <c:if test="${pageInfo.currentPage > 1}">
		            <a href="searchDocuments.ap?boxType=waiting&page=1&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" class="apwaiting-page-link">
		                <i class="fas fa-angle-double-left"></i>
		            </a>
		            <a href="searchDocuments.ap?boxType=waiting&page=${pageInfo.currentPage - 1}&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" class="apwaiting-page-link">
		                <i class="fas fa-angle-left"></i>
		            </a>
		        </c:if>
		        
		        <c:forEach var="p" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
		            <a href="searchDocuments.ap?boxType=waiting&page=${p}&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" 
		               class="apwaiting-page-link ${p == pageInfo.currentPage ? 'active' : ''}">${p}</a>
		        </c:forEach>
		        
		        <c:if test="${pageInfo.currentPage >= pageInfo.maxPage}">
		            <a href="#" class="apwaiting-page-link disabled">
		                <i class="fas fa-angle-right"></i>
		            </a>
		            <a href="#" class="apwaiting-page-link disabled">
		                <i class="fas fa-angle-double-right"></i>
		            </a>
		        </c:if>
		        <c:if test="${pageInfo.currentPage < pageInfo.maxPage}">
		            <a href="searchDocuments.ap?boxType=waiting&page=${pageInfo.currentPage + 1}&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" class="apwaiting-page-link">
		                <i class="fas fa-angle-right"></i>
		            </a>
		            <a href="searchDocuments.ap?boxType=waiting&page=${pageInfo.maxPage}&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" class="apwaiting-page-link">
		                <i class="fas fa-angle-double-right"></i>
		            </a>
		        </c:if>
		    </div>
		    <div class="apwaiting-page-info">
		        전체 ${pageInfo.listCount}건 중 ${pageInfo.currentPage}/${pageInfo.maxPage} 페이지
		    </div>
		</c:if>
   </div>
   
   <script>
       function processApproval(docNo, action) {
           // 결재 상세 페이지로 이동 (승인/반려 처리는 상세 페이지에서)
           window.location.href = 'documentDetail.ap?docNo=' + docNo;
       }
       
       // 검색폼 처리
       document.querySelector('.apwaiting-search-form').addEventListener('submit', function(e) {
           const keyword = this.querySelector('input[name="keyword"]').value.trim();
           if (!keyword) {
               e.preventDefault();
               alert('검색어를 입력해주세요.');
           }
       });
   </script>
</body>
</html>      