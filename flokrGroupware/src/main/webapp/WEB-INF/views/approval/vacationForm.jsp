<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>휴가신청서 | Flokr</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        /* 전체 스타일 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Noto Sans KR', sans-serif;
        }
        
        body {
            background-color: #f9fbfd;
            color: #333;
            line-height: 1.6;
        }
        
        .va-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 40px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 53, 97, 0.08);
        }
        
        /* 문서 헤더 */
        .va-header {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }
        
        .va-title {
            font-size: 26px;
            font-weight: 700;
            color: #003561;
            margin-bottom: 20px;
            letter-spacing: -0.5px;
        }
        
        /* 로고 */
        .va-logo {
            text-align: center;
            margin-bottom: 5px;
        }
        
        /* 그룹 스타일 */
        .va-group {
            margin-bottom: 25px;
        }
        
        .va-label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
            color: #1e293b;
            font-size: 15px;
        }
        
        .va-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            background-color: #f8fafc;
        }
        
        .va-textarea {
            min-height: 120px;
            resize: vertical;
            background-color: #f8fafc;
            line-height: 1.8;
        }
        
        /* 기본 정보 */
        .va-info-row {
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
        .va-check-group {
            display: flex;
            gap: 25px;
            flex-wrap: wrap;
            padding: 15px;
            background-color: #f8fafc;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }
        
        .va-check-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .va-check {
            width: 18px;
            height: 18px;
        }
        
        /* 날짜 선택 */
        .va-date-group {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px;
            background-color: #f8fafc;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }
        
        .va-date-group input[type="date"] {
            padding: 8px;
            border: 1px solid #e2e8f0;
            border-radius: 5px;
            width: 200px;
        }
        
        /* 연차 정보 */
        .va-annual-info {
            display: flex;
            gap: 15px;
            padding: 15px;
            background-color: #f8fafc;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            font-size: 14px;
            align-items: center;
        }
        
        .va-annual-info input {
            width: 50px;
            text-align: center;
            padding: 5px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 14px;
        }
        
        /* 결재선 */
        .va-approval-section {
            margin-top: 20px;
            margin-bottom: 20px;
        }
        
        .va-approval-line {
            margin-top: 12px;
            margin-bottom: 16px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 16px;
            background-color: #fff;
            min-height: 100px;
        }
        
        .va-empty-approval {
            color: #94a3b8;
            text-align: center;
            padding: 20px;
            font-size: 14px;
        }
        
        .va-approval-item {
            display: flex;
            align-items: center;
            background-color: #f8fafc;
            padding: 12px;
            margin-bottom: 8px;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }
        
        .va-approval-number {
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
        
        .va-approval-name {
            flex: 1;
            font-weight: 500;
        }
        
        .va-approval-dept {
            color: #64748b;
            font-size: 13px;
            margin-left: 12px;
            padding-left: 12px;
            border-left: 1px solid #e2e8f0;
        }
        
        .va-approval-btn {
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
        .va-divider {
            height: 1px;
            background-color: #e2e8f0;
            margin: 30px 0;
        }
        
        /* 버튼 스타일 */
        .va-actions {
            margin-top: 40px;
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        
        .va-btn {
            padding: 10px 24px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .va-btn-outline {
            background: none;
            border: 1px solid #ddd;
            color: #666;
        }
        
        .va-btn-outline:hover {
            background-color: #f5f5f5;
        }
        
        .va-btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
        }
        
        .va-btn-secondary:hover {
            background-color: #5a6268;
        }
        
        .va-btn-primary {
            background-color: #003561;
            color: white;
            border: none;
        }
        
        .va-btn-primary:hover {
            background-color: #002d52;
        }
        
        /* 첨부파일 영역 */
        .va-attach-section {
            margin-top: 20px;
            margin-bottom: 30px;
        }
        
        .va-attach-title {
            font-size: 16px;
            margin-bottom: 10px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <!-- header.jsp include -->
    <jsp:include page="../common/header.jsp" />
    
    <div class="va-container">
        <!-- 로고 -->
        <div class="va-logo">
            <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Flokr" 
                 width="80" height="50"
                 onerror="this.src='https://via.placeholder.com/120x30?text=FLOKR'">
        </div>
        
        <!-- 문서 헤더 -->
        <div class="va-header">
            <h1 class="va-title">휴가 신청서</h1>
        </div>
        
        <form id="vacationForm" method="post" action="insertDocument.ap" enctype="multipart/form-data">
            <input type="hidden" name="formNo" value="${form.formNo}">
            <input type="hidden" name="title" value="휴가신청서">
            <input type="hidden" name="lines" id="approval-lines-data">
            <input type="hidden" name="action" id="form-action">
            <input type="hidden" name="docContent" id="doc-content-data">
            
            <!-- 기본 정보 -->
            <div class="va-group">
                <div class="va-info-row">
                    <div><strong>기안자:</strong> ${loginUser.empName}</div>
                    <div><strong>부서:</strong> ${loginUser.deptName}</div>
                    <div><strong>직위:</strong> ${loginUser.positionName}</div>
                    <div><strong>기안일:</strong> ${today}</div>
                </div>
            </div>
            
            <!-- 휴가 종류 -->
            <div class="va-group">
                <label class="va-label">휴가 종류</label>
                <div class="va-check-group">
                    <div class="va-check-item">
                        <input type="radio" name="vacationType" value="연차" id="vacation-type-1" class="va-check">
                        <label for="vacation-type-1">연차</label>
                    </div>
                    <div class="va-check-item">
                        <input type="radio" name="vacationType" value="반차" id="vacation-type-2" class="va-check">
                        <label for="vacation-type-2">반차</label>
                    </div>
                    <div class="va-check-item">
                        <input type="radio" name="vacationType" value="병가" id="vacation-type-3" class="va-check">
                        <label for="vacation-type-3">병가</label>
                    </div>
                    <div class="va-check-item">
                        <input type="radio" name="vacationType" value="특별휴가" id="vacation-type-4" class="va-check">
                        <label for="vacation-type-4">특별휴가</label>
                    </div>
                </div>
            </div>
            
            <!-- 휴가 기간 -->
            <div class="va-group">
			    <label class="va-label">휴가 기간</label>
			    <div class="va-date-group">
			        <input type="date" id="vacation-start-date" required onchange="calculateVacationDays()">
			        ~
			        <input type="date" id="vacation-end-date" required onchange="calculateVacationDays()">
			        <span id="vacation-days" style="margin-left:10px; color: #64748b;">(총 0일)</span>
			    </div>
			</div>
            
            <!-- 연차 현황 -->
            <div class="va-group">
                <label class="va-label">연차 현황</label>
                <div class="va-annual-info">
                    총 <input type="text" id="total-days" value="15">일 중 
                    사용 <input type="text" id="used-days" value="5">일,  
                    잔여 <span id="remaining-days">10</span>일
                </div>
            </div>
            
            <!-- 결재선 -->
            <div class="va-approval-section">
                <label class="va-label">결재선</label>
                <div id="approval-line-container" class="va-approval-line">
                    <div class="va-empty-approval">결재자를 추가해주세요</div>
                </div>
                <button type="button" class="va-btn va-btn-outline" onclick="openApprovalLineModal()">
                    <i class="fas fa-plus"></i> 결재자 추가
                </button>
            </div>
            
            <!-- 휴가 사유 -->
            <div class="va-group">
                <label class="va-label">휴가 사유</label>
                <textarea id="vacation-reason" class="va-control va-textarea" placeholder="휴가 사유를 입력하세요."></textarea>
            </div>
            
            <!-- 비상 연락처 -->
            <div class="va-group">
                <label class="va-label">비상 연락처</label>
                <input type="text" id="emergency-contact" class="va-control" placeholder="비상 연락처를 입력하세요.">
            </div>
            
            <div class="va-divider"></div>
            
            <!-- 첨부파일 -->
            <div class="va-attach-section">
                <h3 class="va-attach-title">첨부파일</h3>
                <input type="file" name="attachFile" id="attachFile" class="va-control" style="padding: 10px;">
            </div>
            
            <!-- 액션 버튼 -->
            <div class="va-actions">
                <button type="button" class="va-btn va-btn-outline" onclick="goBack()">취소</button>
                <button type="button" class="va-btn va-btn-secondary" onclick="saveAsDraft()">임시저장</button>
                <button type="button" class="va-btn va-btn-primary" onclick="submitDocument()">결재요청</button>
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
        
        // 로컬 스토리지 정리 - 페이지 초기화 시
        document.addEventListener('DOMContentLoaded', function() {
            localStorage.removeItem('tempVacationDays');
            
            // 초기 연차 현황 계산
            updateRemainingDays();
            
            // 페이지 로드 시 즉시 계산 실행 (이미 날짜가 있다면)
            calculateVacationDays();
            
            // 휴가 종류 선택 이벤트 연결
            document.querySelectorAll('input[name="vacationType"]').forEach(function(radio) {
                radio.addEventListener('change', handleVacationTypeChange);
            });
            
            // 연차 입력 필드 이벤트 연결
            document.getElementById('total-days').addEventListener('change', updateRemainingDays);
            document.getElementById('used-days').addEventListener('change', updateRemainingDays);
        });
        
        // 휴가 종류 변경 처리
        function handleVacationTypeChange() {
            // 선택된 휴가 종류 가져오기
            const vacationType = document.querySelector('input[name="vacationType"]:checked').value;
            
            // 반차인 경우 시작일과 종료일 동일하게 설정
            if (vacationType === '반차') {
                const startDate = document.getElementById('vacation-start-date').value;
                if (startDate) {
                    document.getElementById('vacation-end-date').value = startDate;
                }
                calculateVacationDays();
            }
        }
        
        // 휴가일수 계산 함수
        function calculateVacationDays() {
            var startDate = document.getElementById('vacation-start-date').value;
            var endDate = document.getElementById('vacation-end-date').value;
            
            if (!startDate || !endDate) {
                document.getElementById('vacation-days').textContent = '(총 0일)';
                return;
            }
            
            var date1 = new Date(startDate);
            var date2 = new Date(endDate);
            
            if (isNaN(date1.getTime()) || isNaN(date2.getTime())) {
                document.getElementById('vacation-days').textContent = '(총 0일)';
                return;
            }
            
            // 반차 처리
            const vacationType = document.querySelector('input[name="vacationType"]:checked');
            if (vacationType && vacationType.value === '반차') {
                document.getElementById('vacation-days').textContent = '(총 0.5일)';
                return;
            }
            
            // 일반 휴가 처리
            var timeDiff = Math.abs(date2.getTime() - date1.getTime());
            var dayDiff = Math.ceil(timeDiff / (1000 * 60 * 60 * 24)) + 1;
            
            document.getElementById('vacation-days').textContent = '(총 ' + dayDiff + '일)';
            
            console.log('휴가 일수 계산됨:', startDate, '~', endDate, '=', dayDiff, '일');
        }
        
        // 잔여일수 계산 함수
        function updateRemainingDays() {
            var totalDays = parseInt(document.getElementById('total-days').value) || 0;
            var usedDays = parseFloat(document.getElementById('used-days').value) || 0;
            var remainingDays = totalDays - usedDays;
            
            document.getElementById('remaining-days').textContent = remainingDays.toFixed(1);
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
                container.innerHTML = '<div class="va-empty-approval">결재자를 추가해주세요</div>';
            } else {
                let html = '';
                approvalLines.forEach(function(line, index) {
                    html += '<div class="va-approval-item">';
                    html += '<div class="va-approval-number">' + (index + 1) + '</div>';
                    html += '<span class="va-approval-name">' + (line.empName || '') + ' ' + (line.positionName || '') + '</span>';
                    html += '<span class="va-approval-dept">' + (line.deptName || '') + '</span>';
                    html += '<button type="button" class="va-approval-btn" onclick="removeApprover(' + index + ')">';
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
    </script>
    
    <!-- 외부 JS 파일 로드 -->
    <script src="${pageContext.request.contextPath}/resources/js/vacationForm.js"></script>
</body>
</html>