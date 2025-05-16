<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>재택근무신청서 | Flokr</title>
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
        
        .rwf-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 40px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 53, 97, 0.08);
        }
        
        /* 문서 헤더 */
        .rwf-header {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }
        
        .rwf-title {
            font-size: 26px;
            font-weight: 700;
            color: #003561;
            margin-bottom: 20px;
            letter-spacing: -0.5px;
        }
        
        /* 로고 */
        .rwf-logo {
            text-align: center;
            margin-bottom: 5px;
        }
        
        /* 기본 정보 */
        .rwf-info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            background-color: #f8fafc;
            padding: 15px;
            border-radius: 8px;
            font-size: 14px;
            border: 1px solid #e2e8f0;
        }
        
        /* 폼 그룹 */
        .rwf-group {
            margin-bottom: 25px;
        }
        
        .rwf-label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
            color: #1e293b;
            font-size: 15px;
        }
        
        .rwf-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            background-color: #f8fafc;
        }
        
        .rwf-textarea {
            min-height: 120px;
            resize: vertical;
            background-color: #f8fafc;
            line-height: 1.8;
        }
        
        /* 체크 그룹 */
        .rwf-check-group {
            display: flex;
            gap: 25px;
            flex-wrap: wrap;
        }
        
        .rwf-check-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .rwf-check {
            width: 18px;
            height: 18px;
        }
        
        /* 날짜 선택 */
        .rwf-date-group {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px;
            background-color: #f8fafc;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }
        
        .rwf-date-group input[type="date"] {
            padding: 8px;
            border: 1px solid #e2e8f0;
            border-radius: 5px;
            width: 200px;
        }
        
        /* 결재선 */
        .rwf-approval-section {
            margin-top: 30px;
            margin-bottom: 30px;
        }
        
        .rwf-approval-line {
            margin-top: 12px;
            margin-bottom: 16px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 16px;
            background-color: #fff;
            min-height: 100px;
        }
        
        .rwf-empty-approval {
            color: #94a3b8;
            text-align: center;
            padding: 20px;
            font-size: 14px;
        }
        
        .rwf-approval-item {
            display: flex;
            align-items: center;
            background-color: #f8fafc;
            padding: 12px;
            margin-bottom: 8px;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }
        
        .rwf-approval-number {
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
        
        .rwf-approval-name {
            flex: 1;
            font-weight: 500;
        }
        
        .rwf-approval-dept {
            color: #64748b;
            font-size: 13px;
            margin-left: 12px;
            padding-left: 12px;
            border-left: 1px solid #e2e8f0;
        }
        
        .rwf-approval-btn {
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
        
        /* 구분선 */
        .rwf-divider {
            height: 1px;
            background-color: #e2e8f0;
            margin: 30px 0;
        }
        
        /* 버튼 스타일 */
        .rwf-actions {
            margin-top: 40px;
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        
        .rwf-btn {
            padding: 10px 24px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .rwf-btn-outline {
            background: none;
            border: 1px solid #ddd;
            color: #666;
        }
        
        .rwf-btn-outline:hover {
            background-color: #f5f5f5;
        }
        
        .rwf-btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
        }
        
        .rwf-btn-secondary:hover {
            background-color: #5a6268;
        }
        
        .rwf-btn-primary {
            background-color: #003561;
            color: white;
            border: none;
        }
        
        .rwf-btn-primary:hover {
            background-color: #002d52;
        }
        
        /* 첨부파일 영역 */
        .rwf-attach-section {
            margin-top: 20px;
            margin-bottom: 30px;
        }
        
        .rwf-attach-title {
            font-size: 16px;
            margin-bottom: 10px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <!-- header.jsp include -->
    <jsp:include page="../common/header.jsp" />

    <div class="rwf-container">
        <!-- 로고 -->
        <div class="rwf-logo">
            <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Flokr" 
                 width="80" height="50"
                 onerror="this.src='https://via.placeholder.com/120x30?text=FLOKR'">
        </div>
        
        <!-- 문서 헤더 -->
        <div class="rwf-header">
            <h1 class="rwf-title">재택근무 신청서</h1>
        </div>

        <form id="remoteWorkForm" method="post" action="insertDocument.ap" enctype="multipart/form-data">
            <input type="hidden" name="formNo" value="${form.formNo}">
            <input type="hidden" name="title" value="재택근무신청서">
            <input type="hidden" name="lines" id="approval-lines-data">
            <input type="hidden" name="action" id="form-action">
            <input type="hidden" name="docContent" id="doc-content-data">
            
            <!-- 기본 정보 -->
            <div class="rwf-group">
                <div class="rwf-info-row">
                    <div><strong>기안자:</strong> ${loginUser.empName}</div>
                    <div><strong>부서:</strong> ${loginUser.deptName}</div>
                    <div><strong>직위:</strong> ${loginUser.positionName}</div>
                    <div><strong>기안일:</strong> ${today}</div>
                </div>
            </div>
            
            <!-- 재택근무 유형 -->
            <div class="rwf-group">
                <label class="rwf-label">재택근무 유형</label>
                <div class="rwf-check-group" style="padding: 15px; background-color: #f8fafc; border-radius: 8px; border: 1px solid #e2e8f0;">
                    <div class="rwf-check-item">
                        <input type="radio" name="workType" value="정기 재택근무(주 2~3일)" id="workType1" class="rwf-check">
                        <label for="workType1">정기 재택근무(주 2~3일)</label>
                    </div>
                    <div class="rwf-check-item">
                        <input type="radio" name="workType" value="비정기 재택근무(특정일)" id="workType2" class="rwf-check">
                        <label for="workType2">비정기 재택근무(특정일)</label>
                    </div>
                    <div class="rwf-check-item">
                        <input type="radio" name="workType" value="전일 재택근무(특별사유)" id="workType3" class="rwf-check">
                        <label for="workType3">전일 재택근무(특별사유)</label>
                    </div>
                </div>
            </div>
            
            <!-- 재택근무 기간 -->
            <div class="rwf-group">
                <label class="rwf-label">재택근무 기간</label>
                <div class="rwf-date-group">
                    <input type="date" id="startDate" style="width:200px;" onchange="calculateDays()">
                    ~
                    <input type="date" id="endDate" style="width:200px;" onchange="calculateDays()">
                    <span id="dayCount" style="margin-left:10px; color: #64748b;">(총 0일)</span>
                </div>
            </div>
            
            <!-- 결재선 -->
            <div class="rwf-approval-section">
                <label class="rwf-label">결재선</label>
                <div id="approval-line-container" class="rwf-approval-line">
                    <div class="rwf-empty-approval">결재자를 추가해주세요</div>
                </div>
                <button type="button" class="rwf-btn rwf-btn-outline" onclick="openApprovalLineModal()">
                    <i class="fas fa-plus"></i> 결재자 추가
                </button>
            </div>
            
            <!-- 재택근무 사유 -->
            <div class="rwf-group">
                <label class="rwf-label">재택근무 사유</label>
                <textarea id="reason" class="rwf-control rwf-textarea" placeholder="재택근무 사유를 입력하세요."></textarea>
            </div>
            
            <!-- 업무 계획 -->
            <div class="rwf-group">
                <label class="rwf-label">업무 계획</label>
                <textarea id="workPlan" class="rwf-control rwf-textarea" placeholder="재택근무 기간 동안의 업무 계획을 입력하세요."></textarea>
            </div>
            
            <!-- 근무 환경 -->
            <div class="rwf-group">
                <label class="rwf-label">근무 환경</label>
                <div class="rwf-check-group" style="padding: 15px; background-color: #f8fafc; border-radius: 8px; border: 1px solid #e2e8f0;">
                    <div class="rwf-check-item">
                        <input type="checkbox" name="workEnv[]" value="업무용 노트북 보유" id="env1" class="rwf-check">
                        <label for="env1">업무용 노트북 보유</label>
                    </div>
                    <div class="rwf-check-item">
                        <input type="checkbox" name="workEnv[]" value="안정적인 인터넷 환경" id="env2" class="rwf-check">
                        <label for="env2">안정적인 인터넷 환경</label>
                    </div>
                    <div class="rwf-check-item">
                        <input type="checkbox" name="workEnv[]" value="화상회의 장비" id="env3" class="rwf-check">
                        <label for="env3">화상회의 장비</label>
                    </div>
                    <div class="rwf-check-item">
                        <input type="checkbox" name="workEnv[]" value="VPN 접속 가능" id="env4" class="rwf-check">
                        <label for="env4">VPN 접속 가능</label>
                    </div>
                </div>
            </div>
            
            <!-- 비상 연락처 -->
            <div class="rwf-group">
                <label class="rwf-label">비상 연락처</label>
                <input type="text" id="contact" class="rwf-control" placeholder="비상 연락처를 입력하세요.">
            </div>
            
            <div class="rwf-divider"></div>
            
            <!-- 첨부파일 -->
            <div class="rwf-attach-section">
                <h3 class="rwf-attach-title">첨부파일</h3>
                <input type="file" name="attachFile" class="rwf-control" style="padding: 10px;">
            </div>
            
            <!-- 액션 버튼 -->
            <div class="rwf-actions">
                <button type="button" class="rwf-btn rwf-btn-outline" onclick="goBack()">취소</button>
                <button type="button" class="rwf-btn rwf-btn-secondary" onclick="saveAsDraft()">임시저장</button>
                <button type="button" class="rwf-btn rwf-btn-primary" onclick="submitDocument()">결재요청</button>
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
                container.innerHTML = '<div class="rwf-empty-approval">결재자를 추가해주세요</div>';
            } else {
                let html = '';
                approvalLines.forEach(function(line, index) {
                    html += '<div class="rwf-approval-item">';
                    html += '<div class="rwf-approval-number">' + (index + 1) + '</div>';
                    html += '<span class="rwf-approval-name">' + (line.empName || '') + ' ' + (line.positionName || '') + '</span>';
                    html += '<span class="rwf-approval-dept">' + (line.deptName || '') + '</span>';
                    html += '<button type="button" class="rwf-approval-btn" onclick="removeApprover(' + index + ')">';
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
        
        // 근무일수 계산 함수
        function calculateDays() {
            var startDate = document.getElementById('startDate').value;
            var endDate = document.getElementById('endDate').value;
            
            if (!startDate || !endDate) {
                document.getElementById('dayCount').textContent = '(총 0일)';
                return;
            }
            
            var date1 = new Date(startDate);
            var date2 = new Date(endDate);
            
            if (isNaN(date1.getTime()) || isNaN(date2.getTime())) {
                document.getElementById('dayCount').textContent = '(총 0일)';
                return;
            }
            
            var timeDiff = Math.abs(date2.getTime() - date1.getTime());
            var dayDiff = Math.ceil(timeDiff / (1000 * 60 * 60 * 24)) + 1;
            
            document.getElementById('dayCount').textContent = '(총 ' + dayDiff + '일)';
            
            console.log('재택근무 일수 계산됨:', startDate, '~', endDate, '=', dayDiff, '일');
        }
        
        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            // 날짜 필드에 이벤트 핸들러 직접 설정
            document.getElementById('startDate').addEventListener('change', calculateDays);
            document.getElementById('endDate').addEventListener('change', calculateDays);
            
            // 이미 날짜가 있다면 계산 실행
            if (document.getElementById('startDate').value && document.getElementById('endDate').value) {
                calculateDays();
            }
        });
    </script>
    
    <!-- 외부 JS 파일 로드 -->
    <script src="${pageContext.request.contextPath}/resources/js/remoteWorkForm.js"></script>
</body>
</html>