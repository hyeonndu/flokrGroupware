<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>완료 문서함 | Flokr</title>
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
        
        .apcomplete-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .apcomplete-header {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .apcomplete-title {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .apcomplete-subtitle {
            font-size: 14px;
            color: #777;
        }
        
        .apcomplete-count {
            color: #003561;
            font-weight: 600;
        }
        
        .apcomplete-stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
            margin-top: 20px;
        }
        
        .apcomplete-stat-card {
            background: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
        }
        
        .apcomplete-stat-label {
            font-size: 12px;
            color: #666;
            text-transform: uppercase;
        }
        
        .apcomplete-stat-value {
            font-size: 24px;
            font-weight: 700;
            margin-top: 5px;
        }
        
        .apcomplete-stat-approved {
            color: #28a745;
        }
        
        .apcomplete-stat-rejected {
            color: #dc3545;
        }
        
        .apcomplete-stat-avg {
            color: #17a2b8;
        }
        
        .apcomplete-stat-total {
            color: #003561;
        }
        
        .apcomplete-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }
        
        .apcomplete-search-form {
            display: flex;
            gap: 10px;
            flex: 1;
            max-width: 500px;
        }
        
        .apcomplete-date-range {
            display: flex;
            gap: 5px;
            align-items: center;
        }
        
        .apcomplete-date-input {
            padding: 6px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            width: 130px;
        }
        
        .apcomplete-search-select {
            width: 120px;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            background: white;
        }
        
        .apcomplete-search-input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }
        
        .apcomplete-search-btn {
            padding: 8px 16px;
            background: #003561;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }
        
        .apcomplete-filter-section {
            margin-top: 15px;
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .apcomplete-filter-label {
            font-size: 14px;
            color: #666;
        }
        
        .apcomplete-filter-select {
            padding: 6px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 13px;
        }
        
        .apcomplete-table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        
        .apcomplete-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        
        .apcomplete-table th,
        .apcomplete-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .apcomplete-table th {
            background: #f8f9fa;
            color: #555;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
        }
        
        .apcomplete-table tr:hover {
            background: #f8f9fa;
        }
        
        .apcomplete-doc-title {
            color: #003561;
            text-decoration: none;
            font-weight: 500;
        }
        
        .apcomplete-doc-title:hover {
            text-decoration: underline;
        }
        
        .apcomplete-status-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .apcomplete-status-approved {
            background: #e8f5e9;
            color: #4caf50;
        }
        
        .apcomplete-status-rejected {
            background: #ffeaea;
            color: #f44336;
        }
        
        .apcomplete-drafter {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }
        
        .apcomplete-drafter-name {
            font-weight: 500;
        }
        
        .apcomplete-drafter-dept {
            font-size: 12px;
            color: #777;
        }
        
        .apcomplete-duration {
            font-size: 13px;
            color: #666;
        }
        
        .apcomplete-fast {
            color: #28a745;
            font-weight: 500;
        }
        
        .apcomplete-slow {
            color: #dc3545;
            font-weight: 500;
        }
        
        .apcomplete-empty {
            text-align: center;
            padding: 50px 20px;
            color: #888;
        }
        
        .apcomplete-empty i {
            font-size: 48px;
            margin-bottom: 15px;
            color: #ddd;
        }
        
        .apcomplete-pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 30px;
            gap: 5px;
        }
        
        .apcomplete-page-link {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #666;
            background: white;
            transition: all 0.2s;
        }
        
        .apcomplete-page-link:hover {
            background: #f8f9fa;
            border-color: #999;
        }
        
        .apcomplete-page-link.active {
            background: #003561;
            color: white;
            border-color: #003561;
        }
        
        .apcomplete-page-link.disabled {
            color: #ccc;
            cursor: not-allowed;
        }
        
        .apcomplete-page-info {
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

    <div class="apcomplete-container">
        <div class="apcomplete-header">
            <h1 class="apcomplete-title">
                <i class="fas fa-check-circle"></i>
                완료 문서함
            </h1>
            <p class="apcomplete-subtitle">
                승인 또는 반려 완료된 문서 목록입니다. 
                <span class="apcomplete-count">총 ${pageInfo.listCount}건</span>
            </p>
            
            <div class="apcomplete-stats">
                <div class="apcomplete-stat-card">
                    <div class="apcomplete-stat-label">총 처리</div>
                    <div class="apcomplete-stat-value apcomplete-stat-total">${pageInfo.listCount}</div>
                </div>
                <div class="apcomplete-stat-card">
                    <div class="apcomplete-stat-label">승인 완료</div>
                    <div class="apcomplete-stat-value apcomplete-stat-approved">${empty stats ? 0 : (empty stats.approvedCount ? 0 : stats.approvedCount)}</div>
                </div>
                <div class="apcomplete-stat-card">
                    <div class="apcomplete-stat-label">반려</div>
                    <div class="apcomplete-stat-value apcomplete-stat-rejected">${empty stats ? 0 : (empty stats.rejectedCount ? 0 : stats.rejectedCount)}</div>
                </div>
                <div class="apcomplete-stat-card">
                    <div class="apcomplete-stat-label">평균 처리 시간</div>
                    <div class="apcomplete-stat-value apcomplete-stat-avg">${empty stats ? '-' : (empty stats.avgProcessTime ? '-' : stats.avgProcessTime)}</div>
                </div>
            </div>
            
            <div class="apcomplete-actions">
                <form class="apcomplete-search-form" method="get" action="searchDocuments.ap">
				    <input type="hidden" name="boxType" value="completed">
				    <div class="apcomplete-date-range">
				        <input type="date" name="dateFrom" class="apcomplete-date-input" value="${dateFrom}">
				        <span>~</span>
				        <input type="date" name="dateTo" class="apcomplete-date-input" value="${dateTo}">
				    </div>
				    <select name="searchType" class="apcomplete-search-select">
				        <option value="">전체</option>
				        <option value="title" ${searchType eq 'title' ? 'selected' : ''}>제목</option>
				        <option value="drafter" ${searchType eq 'drafter' ? 'selected' : ''}>기안자</option>
				        <option value="form" ${searchType eq 'form' ? 'selected' : ''}>양식</option>
				    </select>
				    <input type="text" name="keyword" class="apcomplete-search-input" 
				           placeholder="검색어를 입력하세요" value="${keyword}">
				    <button type="submit" class="apcomplete-search-btn">
				        <i class="fas fa-search"></i> 검색
				    </button>
				</form>
            </div>
            
            <div class="apcomplete-filter-section">
                <span class="apcomplete-filter-label">상태별 필터:</span>
                <select name="statusFilter" class="apcomplete-filter-select" onchange="filterByStatus(this.value)">
                    <option value="">전체</option>
			        <option value="REQUESTED" ${statusFilter eq 'REQUESTED' ? 'selected' : ''}>진행중</option>
			        <option value="APPROVED" ${statusFilter eq 'APPROVED' ? 'selected' : ''}>승인</option>
			        <option value="REJECTED" ${statusFilter eq 'REJECTED' ? 'selected' : ''}>반려</option>
                </select>
                <span class="apcomplete-filter-label">기간:</span>
                <select name="periodFilter" class="apcomplete-filter-select" onchange="filterByPeriod(this.value)">
                    <option value="">전체</option>
                    <option value="today">오늘</option>
                    <option value="week">1주일</option>
                    <option value="month">1개월</option>
                    <option value="3month">3개월</option>
                </select>
            </div>
        </div>
        
        <div class="apcomplete-table-container">
            <table class="apcomplete-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>양식</th>
                        <th>제목</th>
                        <th>기안자</th>
                        <th>상신일</th>
                        <th>완료일</th>
                        <th>처리 시간</th>
                        <th>결과</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="doc" items="${documentList}" varStatus="status">
                        <tr>
                            <td>${pageInfo.listCount - ((pageInfo.currentPage - 1) * pageInfo.boardLimit + status.index)}</td>
                            <td>${doc.formName}</td>
                            <td>
                                <a href="documentDetail.ap?docNo=${doc.docNo}" class="apcomplete-doc-title">
                                    ${doc.title}
                                </a>
                            </td>
                            <td>
                                <div class="apcomplete-drafter">
                                    <span class="apcomplete-drafter-name">${doc.drafterName}</span>
                                    <span class="apcomplete-drafter-dept">${doc.drafterDeptName}</span>
                                </div>
                            </td>
                            <td>
                                <fmt:formatDate value="${doc.requestedDate}" pattern="MM-dd HH:mm"/>
                            </td>
                            <td>
                                <fmt:formatDate value="${doc.completedDate}" pattern="MM-dd HH:mm"/>
                            </td>
                            <td>
                                <c:choose>
							        <c:when test="${doc.completedDate != null && doc.requestedDate != null}">
							            <c:set var="processMilli" value="${doc.completedDate.time - doc.requestedDate.time}" />
							            <c:set var="processHours" value="${processMilli / (1000 * 60 * 60)}" />
							            <span class="apcomplete-duration 
							                <c:choose>
							                    <c:when test="${processHours <= 2}">apcomplete-fast</c:when>
							                    <c:when test="${processHours >= 24}">apcomplete-slow</c:when>
							                </c:choose>">
							                <c:choose>
							                    <c:when test="${processHours < 1}">1시간 이내</c:when>
							                    <c:when test="${processHours < 24}">약 ${Math.round(processHours)}시간</c:when>
							                    <c:otherwise>약 ${Math.round(processHours/24)}일</c:otherwise>
							                </c:choose>
							            </span>
							        </c:when>
							        <c:otherwise>
							            <span class="apcomplete-duration">-</span>
							        </c:otherwise>
							    </c:choose>
                            </td>
                            <td>
                                <span class="apcomplete-status-badge 
                                    <c:choose>
                                        <c:when test="${doc.docStatus == 'APPROVED'}">apcomplete-status-approved</c:when>
                                        <c:when test="${doc.docStatus == 'REJECTED'}">apcomplete-status-rejected</c:when>
                                    </c:choose>">
                                    <c:choose>
                                        <c:when test="${doc.docStatus == 'APPROVED'}">승인</c:when>
                                        <c:when test="${doc.docStatus == 'REJECTED'}">반려</c:when>
                                    </c:choose>
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty documentList}">
                        <tr>
                            <td colspan="8">
                                <div class="apcomplete-empty">
                                    <i class="far fa-check-circle"></i>
                                    <p>완료된 문서가 없습니다.</p>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <c:if test="${pageInfo.listCount > 0}">
    <div class="apcomplete-pagination">
        <c:if test="${pageInfo.currentPage <= 1}">
            <a href="#" class="apcomplete-page-link disabled">
                <i class="fas fa-angle-double-left"></i>
            </a>
            <a href="#" class="apcomplete-page-link disabled">
                <i class="fas fa-angle-left"></i>
            </a>
        </c:if>
        <c:if test="${pageInfo.currentPage > 1}">
            <a href="searchDocuments.ap?boxType=completed&page=1&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" class="apcomplete-page-link">
                <i class="fas fa-angle-double-left"></i>
            </a>
            <a href="searchDocuments.ap?boxType=completed&page=${pageInfo.currentPage - 1}&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" class="apcomplete-page-link">
                <i class="fas fa-angle-left"></i>
            </a>
        </c:if>
        
        <c:forEach var="p" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
            <a href="searchDocuments.ap?boxType=completed&page=${p}&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" 
               class="apcomplete-page-link ${p == pageInfo.currentPage ? 'active' : ''}">${p}</a>
        </c:forEach>
        
        <c:if test="${pageInfo.currentPage >= pageInfo.maxPage}">
            <a href="#" class="apcomplete-page-link disabled">
                <i class="fas fa-angle-right"></i>
            </a>
            <a href="#" class="apcomplete-page-link disabled">
                <i class="fas fa-angle-double-right"></i>
            </a>
        </c:if>
        <c:if test="${pageInfo.currentPage < pageInfo.maxPage}">
            <a href="searchDocuments.ap?boxType=completed&page=${pageInfo.currentPage + 1}&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" class="apcomplete-page-link">
                <i class="fas fa-angle-right"></i>
            </a>
            <a href="searchDocuments.ap?boxType=completed&page=${pageInfo.maxPage}&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" class="apcomplete-page-link">
                <i class="fas fa-angle-double-right"></i>
            </a>
        </c:if>
    </div>
    <div class="apcomplete-page-info">
        전체 ${pageInfo.listCount}건 중 ${pageInfo.currentPage}/${pageInfo.maxPage} 페이지
    </div>
</c:if>
    </div>
    
    <script>
        function filterByStatus(status) {
            updateUrl({ statusFilter: status });
        }
        
        function filterByPeriod(period) {
            updateUrl({ periodFilter: period });
        }
        
        function updateUrl(params) {
            const urlParams = new URLSearchParams(window.location.search);
            
            Object.keys(params).forEach(key => {
                if (params[key]) {
                    urlParams.set(key, params[key]);
                } else {
                    urlParams.delete(key);
                }
            });
            
            window.location.href = 'completedList.ap?' + urlParams.toString();
        }
        
        // 검색폼 제출
        document.querySelector('.apcomplete-search-form').addEventListener('submit', function(e) {
            const dateFrom = this.querySelector('input[name="dateFrom"]').value;
            const dateTo = this.querySelector('input[name="dateTo"]').value;
            const keyword = this.querySelector('input[name="keyword"]').value.trim();
            
            if (!dateFrom && !dateTo && !keyword) {
                e.preventDefault();
                alert('검색 조건을 하나 이상 입력해주세요.');
            }
        });
    </script>
</body>
</html>