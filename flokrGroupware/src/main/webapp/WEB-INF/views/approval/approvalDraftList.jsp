<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>임시저장함 | Flokr</title>
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
        
        .apdraft-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .apdraft-header {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .apdraft-title {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .apdraft-subtitle {
            font-size: 14px;
            color: #777;
        }
        
        .apdraft-count {
            color: #003561;
            font-weight: 600;
        }
        
        .apdraft-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }
        
        .apdraft-search-form {
            display: flex;
            gap: 10px;
            flex: 1;
            max-width: 500px;
        }
        
        .apdraft-search-select {
            width: 120px;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            background: white;
        }
        
        .apdraft-search-input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }
        
        .apdraft-search-btn {
            padding: 8px 16px;
            background: #003561;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }

        
        .apdraft-table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        
        .apdraft-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        
        .apdraft-table th,
        .apdraft-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .apdraft-table th {
            background: #f8f9fa;
            color: #555;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
        }
        
        .apdraft-table tr:hover {
            background: #f8f9fa;
        }
        
        .apdraft-doc-title {
            color: #003561;
            text-decoration: none;
            font-weight: 500;
        }
        
        .apdraft-doc-title:hover {
            text-decoration: underline;
        }
        
        .apdraft-status-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
            background: #e9ecef;
            color: #495057;
        }
        
        .apdraft-status-draft {
            background: #f5f5f5;
            color: #666;
        }
        
        .apdraft-actions-cell {
            text-align: center;
        }
        
        .apdraft-action-btn {
            background: none;
            border: none;
            color: #666;
            cursor: pointer;
            padding: 5px 8px;
            border-radius: 4px;
            transition: all 0.2s;
            margin: 0 5px;
        }
        
        .apdraft-action-btn:hover {
            background: #f0f0f0;
            color: #333;
        }
        
        .apdraft-action-edit {
            color: #17a2b8;
        }
        
        .apdraft-action-delete {
            color: #dc3545;
        }
        
        .apdraft-action-edit:hover {
            background: #e8f7f9;
            color: #138496;
        }
        
        .apdraft-action-delete:hover {
            background: #f8d7da;
            color: #c82333;
        }
        
        /* 추가된 결재요청 버튼 스타일 */
        .apdraft-action-submit {
            color: #28a745;
        }
        
        .apdraft-action-submit:hover {
            background: #e8f5e9;
            color: #218838;
        }
        
        .apdraft-empty {
            text-align: center;
            padding: 50px 20px;
            color: #888;
        }
        
        .apdraft-empty i {
            font-size: 48px;
            margin-bottom: 15px;
            color: #ddd;
        }
        
        .apdraft-pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 30px;
            gap: 5px;
        }
        
        .apdraft-page-link {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #666;
            background: white;
            transition: all 0.2s;
        }
        
        .apdraft-page-link:hover {
            background: #f8f9fa;
            border-color: #999;
        }
        
        .apdraft-page-link.active {
            background: #003561;
            color: white;
            border-color: #003561;
        }
        
        .apdraft-page-link.disabled {
            color: #ccc;
            cursor: not-allowed;
        }
        
        .apdraft-page-info {
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

    <div class="apdraft-container">
        <div class="apdraft-header">
            <h1 class="apdraft-title">
                <i class="fas fa-folder-open"></i>
                임시저장함
            </h1>
            <p class="apdraft-subtitle">
                작성 중이거나 아직 상신하지 않은 문서 목록입니다. 
                <span class="apdraft-count">총 ${pageInfo.listCount}건</span>
            </p>
            
            <div class="apdraft-actions">
                <form class="apdraft-search-form" method="get" action="searchDocuments.ap">
                    <input type="hidden" name="boxType" value="draft">
                    <select name="searchType" class="apdraft-search-select">
                        <option value="">전체</option>
                        <option value="title" ${param.searchType eq 'title' ? 'selected' : ''}>제목</option>
                        <option value="form" ${param.searchType eq 'form' ? 'selected' : ''}>양식</option>
                    </select>
                    <input type="text" name="keyword" class="apdraft-search-input" 
                           placeholder="검색어를 입력하세요" value="${keyword}">
                    <button type="submit" class="apdraft-search-btn">
                        <i class="fas fa-search"></i> 검색
                    </button>
                </form>
            </div>
        </div>
        
        <div class="apdraft-table-container">
            <table class="apdraft-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>양식</th>
                        <th>제목</th>
                        <th>저장일시</th>
                        <th>상태</th>
                        <th>작업</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="doc" items="${documentList}" varStatus="status">
                        <tr>
                            <td>${pageInfo.listCount - ((pageInfo.currentPage - 1) * pageInfo.boardLimit + status.index)}</td>
                            <td>${doc.formName}</td>
                            <td>
                                <a href="updateDocument.ap?docNo=${doc.docNo}" class="apdraft-doc-title">
                                    ${doc.title}
                                </a>
                            </td>
                            <td>
                                <fmt:formatDate value="${doc.updateDate}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                            <td>
                                <span class="apdraft-status-badge apdraft-status-draft">
                                    <c:choose>
                                        <c:when test="${doc.docStatus == 'DRAFT'}">임시저장</c:when>
                                        <c:when test="${doc.docStatus == 'REJECTED'}">반려</c:when>
                                    </c:choose>
                                </span>
                            </td>
                            <td class="apdraft-actions-cell">
                                <button class="apdraft-action-btn apdraft-action-edit" 
                                        onclick="editDocument(${doc.docNo})" title="수정">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <!-- 결재요청 버튼 추가 - 임시저장함에서 바로 결재요청으로 전환할 수 있는 버튼 -->
                                <button class="apdraft-action-btn apdraft-action-submit" 
                                        onclick="submitDocument(${doc.docNo})" title="결재요청">
                                    <i class="fas fa-paper-plane"></i>
                                </button>
                                <button class="apdraft-action-btn apdraft-action-delete" 
                                        onclick="deleteDocument(${doc.docNo})" title="삭제">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty documentList}">
                        <tr>
                            <td colspan="6">
                                <div class="apdraft-empty">
                                    <i class="far fa-folder-open"></i>
                                    <p>저장된 문서가 없습니다.</p>

                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <c:if test="${pageInfo.listCount > 0}">
		    <div class="apdraft-pagination">
		        <c:if test="${pageInfo.currentPage <= 1}">
		            <a href="#" class="apdraft-page-link disabled">
		                <i class="fas fa-angle-double-left"></i>
		            </a>
		            <a href="#" class="apdraft-page-link disabled">
		                <i class="fas fa-angle-left"></i>
		            </a>
		        </c:if>
		        <c:if test="${pageInfo.currentPage > 1}">
		            <a href="searchDocuments.ap?boxType=draft&page=1&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" class="apdraft-page-link">
		                <i class="fas fa-angle-double-left"></i>
		            </a>
		            <a href="searchDocuments.ap?boxType=draft&page=${pageInfo.currentPage - 1}&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" class="apdraft-page-link">
		                <i class="fas fa-angle-left"></i>
		            </a>
		        </c:if>
		        
		        <c:forEach var="p" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
		            <a href="searchDocuments.ap?boxType=draft&page=${p}&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" 
		               class="apdraft-page-link ${p == pageInfo.currentPage ? 'active' : ''}">${p}</a>
		        </c:forEach>
		        
		        <c:if test="${pageInfo.currentPage >= pageInfo.maxPage}">
		            <a href="#" class="apdraft-page-link disabled">
		                <i class="fas fa-angle-right"></i>
		            </a>
		            <a href="#" class="apdraft-page-link disabled">
		                <i class="fas fa-angle-double-right"></i>
		            </a>
		        </c:if>
		        <c:if test="${pageInfo.currentPage < pageInfo.maxPage}">
		            <a href="searchDocuments.ap?boxType=draft&page=${pageInfo.currentPage + 1}&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" class="apdraft-page-link">
		                <i class="fas fa-angle-right"></i>
		            </a>
		            <a href="searchDocuments.ap?boxType=draft&page=${pageInfo.maxPage}&searchType=${searchType}&keyword=${keyword}&dateFrom=${dateFrom}&dateTo=${dateTo}&statusFilter=${statusFilter}" class="apdraft-page-link">
		                <i class="fas fa-angle-double-right"></i>
		            </a>
		        </c:if>
		    </div>
		    <div class="apdraft-page-info">
		        전체 ${pageInfo.listCount}건 중 ${pageInfo.currentPage}/${pageInfo.maxPage} 페이지
		    </div>
		</c:if>
    </div>
    
    <script>
        function editDocument(docNo) {
            window.location.href = 'updateDocument.ap?docNo=' + docNo;
        }
        
        function deleteDocument(docNo) {
            if (confirm('정말 삭제하시겠습니까?\n삭제된 문서는 복구할 수 없습니다.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'deleteDocument.ap';
                
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'docNo';
                input.value = docNo;
                
                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
     // 결재요청 기능 - 임시저장 상태에서 바로 결재요청으로 전환
        function submitDocument(docNo) {
            if (confirm('이 문서를 결재 요청하시겠습니까?\n결재선이 설정되지 않은 경우 문서 편집 화면으로 이동합니다.')) {
                // 먼저 결재선 설정 여부 확인을 위해 문서 정보를 가져옴
                fetch('checkApprovalLine.ap?docNo=' + docNo)
                    .then(response => response.json())
                    .then(data => {
                        if (data.hasApprovalLine) {
                            // 결재선이 있으면 바로 결재요청 처리
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = 'submitDraft.ap';
                            
                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = 'docNo';
                            input.value = docNo;
                            
                            form.appendChild(input);
                            document.body.appendChild(form);
                            form.submit();
                        } else {
                            // 결재선이 없으면 수정 화면으로 이동
                            alert('결재선이 설정되지 않았습니다. 문서 편집 화면으로 이동합니다.');
                            window.location.href = 'updateDocument.ap?docNo=' + docNo;
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('문서 정보를 확인하는 중 오류가 발생했습니다. 문서 편집 화면으로 이동합니다.');
                        window.location.href = 'updateDocument.ap?docNo=' + docNo;
                    });
            }
        }
        
        // 검색폼 처리
        document.querySelector('.apdraft-search-form').addEventListener('submit', function(e) {
            const keyword = this.querySelector('input[name="keyword"]').value.trim();
            if (!keyword) {
                e.preventDefault();
                alert('검색어를 입력해주세요.');
            }
        });
    </script>
</body>
</html>