<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>출장신청서 | Flokr</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        /* 전체 스타일 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', sans-serif;
        }
        
        body {
            background-color: #f9fbfd;
            color: #333;
            line-height: 1.6;
        }
        
        .bt-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 40px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 53, 97, 0.08);
        }
        
        /* 문서 헤더 */
        .bt-header {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }
        
        .bt-title {
            font-size: 26px;
            font-weight: 700;
            color: #003561;
            margin-bottom: 20px;
            letter-spacing: -0.5px;
        }
        
        /* 로고 */
        .bt-logo {
            text-align: center;
            margin-bottom: 5px;
        }
        
        /* 그룹 스타일 */
        .bt-group {
            margin-bottom: 25px;
        }
        
        .bt-label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
            color: #1e293b;
            font-size: 15px;
        }
        
        .bt-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            background-color: #f8fafc;
        }
        
        .bt-textarea {
            min-height: 120px;
            resize: vertical;
            background-color: #f8fafc;
            line-height: 1.8;
        }
        
        /* 기본 정보 */
        .bt-info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            background-color: #f8fafc;
            padding: 15px;
            border-radius: 8px;
            font-size: 14px;
            border: 1px solid #e2e8f0;
        }
        
        /* 체크 항목 */
        .bt-check-group {
            display: flex;
            gap: 25px;
            flex-wrap: wrap;
            padding: 15px;
            background-color: #f8fafc;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }
        
        .bt-check-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .bt-check {
            width: 18px;
            height: 18px;
        }
        
        /* 날짜 선택 */
        .bt-date-group {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px;
            background-color: #f8fafc;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }
        
        .bt-date-group input[type="date"] {
            padding: 8px;
            border: 1px solid #e2e8f0;
            border-radius: 5px;
            width: 200px;
        }
        
        /* 결재선 */
        .bt-approval-section {
            margin-top: 20px;
            margin-bottom: 20px;
        }
        
        .bt-approval-line {
            margin-top: 12px;
            margin-bottom: 16px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 16px;
            background-color: #fff;
            min-height: 100px;
        }
        
        .bt-empty-approval {
            color: #94a3b8;
            text-align: center;
            padding: 20px;
            font-size: 14px;
        }
        
        .bt-approval-item {
            display: flex;
            align-items: center;
            background-color: #f8fafc;
            padding: 12px;
            margin-bottom: 8px;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }
        
        .bt-approval-number {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 24px;
            height: 24px;
            background-color: #003561;
            color: white;
            border-radius: 50%;
            font-size: 12px;
            margin-right: 12px;
        }
        
        .bt-approval-name {
            flex: 1;
            font-weight: 500;
        }
        
        .bt-approval-dept {
            color: #64748b;
            font-size: 13px;
            margin-left: 12px;
            padding-left: 12px;
            border-left: 1px solid #e2e8f0;
        }
        
        .bt-approval-btn {
            background: none;
            border: none;
            color: #dc3545;
            cursor: pointer;
            width: 28px;
            height: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
        }
        
        /* 멤버 입력 폼 */
        .bt-member-form {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
        }
        
        .bt-member-form input {
            flex: 1;
            padding: 10px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 14px;
        }
        
        .bt-member-form button {
            background-color: #003561;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 10px 15px;
            font-size: 14px;
            cursor: pointer;
        }
        
        /* 멤버 뱃지 */
        .bt-member-list {
            padding: 15px;
            background-color: #f8fafc;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            margin-top: 10px;
        }
        
        .bt-member-badge {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 14px;
            margin-right: 8px;
            margin-bottom: 8px;
            background-color: #f1f5f9;
            color: #334155;
            border: 1px solid #e2e8f0;
        }
        
        .bt-member-badge button {
            background: none;
            border: none;
            color: #dc3545;
            cursor: pointer;
            margin-left: 8px;
            font-size: 14px;
        }
        
        /* 테이블 스타일 */
        .bt-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.04);
        }
        
        .bt-table th, 
        .bt-table td {
            padding: 12px;
            border: 1px solid #e2e8f0;
        }
        
        .bt-table th {
            background-color: #f1f5f9;
            font-weight: 500;
            color: #1e293b;
            font-size: 14px;
            text-align: center;
        }
        
        .bt-table td {
            background-color: #f8fafc;
        }
        
        .bt-table input, 
        .bt-table textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .bt-table textarea {
            resize: vertical;
            min-height: 80px;
        }
        
        /* 구분선 */
        .bt-divider {
            height: 1px;
            background-color: #e2e8f0;
            margin: 30px 0;
        }
        
        /* 버튼 스타일 */
        .bt-actions {
            margin-top: 40px;
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        
        .bt-btn {
            padding: 10px 24px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .bt-btn-outline {
            background: none;
            border: 1px solid #ddd;
            color: #666;
        }
        
        .bt-btn-outline:hover {
            background-color: #f5f5f5;
        }
        
        .bt-btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
        }
        
        .bt-btn-secondary:hover {
            background-color: #5a6268;
        }
        
        .bt-btn-primary {
            background-color: #003561;
            color: white;
            border: none;
        }
        
        .bt-btn-primary:hover {
            background-color: #002d52;
        }
        
        .bt-add-btn {
            background-color: #f0f9ff;
            color: #0284c7;
            border: 1px solid #bae6fd;
            border-radius: 4px;
            padding: 8px 16px;
            font-size: 14px;
            cursor: pointer;
            margin-top: 10px;
            margin-bottom: 20px;
            display: inline-block;
        }
        
        .bt-add-btn:hover {
            background-color: #e0f2fe;
        }
        
        .bt-delete-btn {
            background: none;
            border: none;
            color: #f43f5e;
            cursor: pointer;
            font-size: 14px;
            padding: 4px 8px;
        }
        
        /* 첨부파일 영역 */
        .bt-attach-section {
            margin-top: 20px;
            margin-bottom: 30px;
        }
        
        .bt-attach-title {
            font-size: 16px;
            margin-bottom: 10px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <!-- header.jsp include -->
    <jsp:include page="../common/header.jsp" />
    
    <div class="bt-container">
        <!-- 로고 -->
        <div class="bt-logo">
            <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Flokr" 
                 width="80" height="50"
                 onerror="this.src='https://via.placeholder.com/120x30?text=FLOKR'">
        </div>
        
        <!-- 문서 헤더 -->
        <div class="bt-header">
            <h1 class="bt-title">출장 신청서</h1>
        </div>
        
        <form id="businessTripForm" method="post" action="insertDocument.ap" enctype="multipart/form-data">
            <input type="hidden" name="formNo" value="${form.formNo}">
            <input type="hidden" name="title" value="출장신청서">
            <input type="hidden" name="lines" id="approval-lines-data">
            <input type="hidden" name="action" id="form-action">
            <input type="hidden" name="docContent" id="doc-content-data">
            
            <!-- 기본 정보 -->
            <div class="bt-group">
                <div class="bt-info-row">
                    <div><strong>기안자:</strong> ${loginUser.empName}</div>
                    <div><strong>부서:</strong> ${loginUser.deptName}</div>
                    <div><strong>직위:</strong> ${loginUser.positionName}</div>
                    <div><strong>기안일:</strong> ${today}</div>
                </div>
            </div>
            
            <!-- 출장 목적 -->
            <div class="bt-group">
                <label class="bt-label">출장 목적</label>
                <input type="text" id="trip-purpose" class="bt-control" placeholder="출장 목적을 입력하세요">
            </div>
            
            <!-- 출장 구분 -->
            <div class="bt-group">
                <label class="bt-label">출장 구분</label>
                <div class="bt-check-group">
                    <div class="bt-check-item">
                        <input type="radio" name="tripType" value="국내 출장(당일)" id="trip-type-1" class="bt-check">
                        <label for="trip-type-1">국내 출장(당일)</label>
                    </div>
                    <div class="bt-check-item">
                        <input type="radio" name="tripType" value="국내 출장(숙박)" id="trip-type-2" class="bt-check">
                        <label for="trip-type-2">국내 출장(숙박)</label>
                    </div>
                    <div class="bt-check-item">
                        <input type="radio" name="tripType" value="해외 출장" id="trip-type-3" class="bt-check">
                        <label for="trip-type-3">해외 출장</label>
                    </div>
                </div>
            </div>
            
            <!-- 출장지 -->
            <div class="bt-group">
                <label class="bt-label">출장지</label>
                <div style="display: flex; align-items: center;">
                    <i class="fas fa-map-marker-alt" style="color: #dc3545; margin-right: 10px;"></i>
                    <input type="text" id="trip-location" class="bt-control" placeholder="출장지를 입력하세요">
                </div>
            </div>
            
            <!-- 출장 기간 -->
            <div class="bt-group">
                <label class="bt-label">출장 기간</label>
                <div class="bt-date-group">
                    <input type="date" id="trip-start-date" required>
                    ~
                    <input type="date" id="trip-end-date" required>
                    <span id="trip-days" style="margin-left:10px; color: #64748b;">(총 0일)</span>
                </div>
            </div>
            
            <!-- 출장자 -->
            <div class="bt-group">
                <label class="bt-label">출장자</label>
                <div class="bt-member-form">
                    <input type="text" id="member-name" placeholder="이름">
                    <input type="text" id="member-dept" placeholder="부서">
                    <button type="button" onclick="addMember()">추가</button>
                </div>
                <div id="member-list" class="bt-member-list">
                    <div class="bt-member-badge">
                        ${loginUser.empName} (${loginUser.deptName})
                        <input type="hidden" class="trip-member-input" value="${loginUser.empName},${loginUser.deptName}">
                    </div>
                </div>
            </div>
            
            <!-- 결재선 -->
            <div class="bt-approval-section">
                <label class="bt-label">결재선</label>
                <div id="approval-line-container" class="bt-approval-line">
                    <div class="bt-empty-approval">결재자를 추가해주세요</div>
                </div>
                <button type="button" class="bt-btn bt-btn-outline" onclick="openApprovalLineModal()">
                    <i class="fas fa-plus"></i> 결재자 추가
                </button>
            </div>
            
            <!-- 비고 및 긴급 연락처 -->
            <div class="bt-group">
                <label class="bt-label">긴급 연락처</label>
                <input type="text" id="emergency-contact" class="bt-control" placeholder="긴급 연락처를 입력하세요">
            </div>
            
            <!-- 첨부파일 -->
            <div class="bt-attach-section">
                <h3 class="bt-attach-title">첨부파일</h3>
                <input type="file" name="attachFile" id="attachFile" class="bt-control" style="padding: 10px;">
            </div>
            
            <!-- 액션 버튼 -->
            <div class="bt-actions">
                <button type="button" class="bt-btn bt-btn-outline" onclick="goBack()">취소</button>
                <button type="button" class="bt-btn bt-btn-secondary" onclick="saveAsDraft()">임시저장</button>
                <button type="button" class="bt-btn bt-btn-primary" onclick="submitDocument()">결재요청</button>
            </div>
        </form>
    </div>
    
    <script>
    // JSP EL 태그를 사용하는 초기화 코드 (JSP에 유지)
    const loginUser = {
        empName: '${loginUser.empName}',
        deptName: '${loginUser.deptName}',
        positionName: '${loginUser.positionName}'
    };

    // 결재선 관련 변수
    let approvalLines = [];

    // 첨부파일 처리
    document.getElementById('attachFile').addEventListener('change', function(e) {
        const fileInput = e.target;
        if (fileInput.files.length > 0) {
            // 파일 선택됨
        }
    });

    // 출장일수 계산 함수
    function calculateDays() {
        // 날짜 값 직접 가져오기
        var startDate = document.getElementById('trip-start-date').value;
        var endDate = document.getElementById('trip-end-date').value;
        
        // 둘 다 선택되었는지 확인
        if (!startDate || !endDate) {
            document.getElementById('trip-days').innerHTML = '(총 0일)';
            return;
        }
        
        // 날짜 객체 생성
        var date1 = new Date(startDate);
        var date2 = new Date(endDate);
        
        // 유효한 날짜인지 확인
        if (isNaN(date1.getTime()) || isNaN(date2.getTime())) {
            document.getElementById('trip-days').innerHTML = '(총 0일)';
            return;
        }
        
        // 밀리초 단위의 차이 계산
        var timeDiff = Math.abs(date2.getTime() - date1.getTime());
        // 일수로 변환 (시작일도 포함하므로 +1)
        var dayCount = Math.ceil(timeDiff / (1000 * 60 * 60 * 24)) + 1;
        
        // 결과 표시
        document.getElementById('trip-days').innerHTML = '(총 ' + dayCount + '일)';
        
        // 디버깅 로그
        console.log('출장 일수 계산됨:', startDate, '~', endDate, '=', dayCount, '일');
    }

    // 출장자 추가
    function addMember() {
        const nameInput = document.getElementById('member-name');
        const deptInput = document.getElementById('member-dept');
        
        const name = nameInput.value.trim();
        const dept = deptInput.value.trim();
        
        if (!name || !dept) {
            alert('이름과 부서를 모두 입력해주세요.');
            return;
        }
        
        // HTML 방식으로 직접 추가
        var memberList = document.getElementById('member-list');
        
        // div 요소 생성
        var memberBadge = document.createElement('div');
        memberBadge.className = 'bt-member-badge';
        
        // 텍스트 노드 추가
        var textNode = document.createTextNode(name + ' (' + dept + ')');
        memberBadge.appendChild(textNode);
        
        // hidden input 추가
        var hiddenInput = document.createElement('input');
        hiddenInput.type = 'hidden';
        hiddenInput.className = 'trip-member-input';
        hiddenInput.value = name + ',' + dept;
        memberBadge.appendChild(hiddenInput);
        
        // 삭제 버튼 추가
        var deleteBtn = document.createElement('button');
        deleteBtn.type = 'button';
        deleteBtn.onclick = function() { this.parentElement.remove(); };
        
        // 아이콘 추가
        var icon = document.createElement('i');
        icon.className = 'fas fa-times';
        deleteBtn.appendChild(icon);
        
        memberBadge.appendChild(deleteBtn);
        
        // 최종 추가
        memberList.appendChild(memberBadge);
        
        // 입력 필드 초기화
        nameInput.value = '';
        deptInput.value = '';
        
        console.log('출장자 추가됨: ' + name + ', ' + dept);
    }

    // 결재선 모달 열기
    function openApprovalLineModal() {
        window.open('approvalLineModal.ap', 'approvalLineModal', 'width=800,height=600,scrollbars=yes');
    }
    
    // 결재선 추가 함수
    window.addApprovalLine = function(emp) {
        // 중복 체크
        if (approvalLines.find(line => line.empNo === emp.empNo)) {
            alert('이미 결재선에 포함된 사원입니다.');
            return;
        }
        
        // 결재선에 추가
        approvalLines.push({
            empNo: emp.empNo,
            empName: emp.empName,
            deptName: emp.deptName || '부서 없음',
            positionName: emp.positionName || ''
        });
        
        // 결재선 표시 업데이트
        updateApprovalLineDisplay();
        
        // hidden input에 값 설정
        document.getElementById('approval-lines-data').value = JSON.stringify(approvalLines);
    };

    // 결재선 표시 업데이트
    function updateApprovalLineDisplay() {
        const container = document.getElementById('approval-line-container');
        
        if (approvalLines.length === 0) {
            container.innerHTML = '<div class="bt-empty-approval">결재자를 추가해주세요</div>';
        } else {
            let html = '';
            approvalLines.forEach(function(line, index) {
                html += '<div class="bt-approval-item">';
                html += '<div class="bt-approval-number">' + (index + 1) + '</div>';
                html += '<span class="bt-approval-name">' + (line.empName || '') + ' ' + (line.positionName || '') + '</span>';
                html += '<span class="bt-approval-dept">' + (line.deptName || '') + '</span>';
                html += '<button type="button" class="bt-approval-btn" onclick="removeApprover(' + index + ')">';
                html += '<i class="fas fa-times"></i>';
                html += '</button>';
                html += '</div>';
            });
            container.innerHTML = html;
        }
        
        document.getElementById('approval-lines-data').value = JSON.stringify(approvalLines);
    }

    // 결재자 제거
    function removeApprover(index) {
        approvalLines.splice(index, 1);
        updateApprovalLineDisplay();
        document.getElementById('approval-lines-data').value = JSON.stringify(approvalLines);
    }
    
    // DOMContentLoaded 이벤트 핸들러
    document.addEventListener('DOMContentLoaded', function() {
        // 날짜 입력 필드에 이벤트 연결
        var startDateInput = document.getElementById('trip-start-date');
        var endDateInput = document.getElementById('trip-end-date');
        
        if (startDateInput) {
            startDateInput.addEventListener('change', calculateDays);
            startDateInput.addEventListener('input', calculateDays);
        }
        
        if (endDateInput) {
            endDateInput.addEventListener('change', calculateDays);
            endDateInput.addEventListener('input', calculateDays);
        }
    });
</script>

<!-- 외부 JS 파일 로드 - 기타 함수만 포함 -->
<script src="${pageContext.request.contextPath}/resources/js/businessTripForm.js"></script>
</html>