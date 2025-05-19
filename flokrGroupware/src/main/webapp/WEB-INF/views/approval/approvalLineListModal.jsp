<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결재선 선택 | Flokr</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* 스타일은 기존 코드 유지 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            color: #333;
            height: 100vh;
            overflow: hidden;
        }
        
        .apline-container {
            height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .apline-header {
            background: white;
            border-bottom: 1px solid #eee;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .apline-title {
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }
        
        .apline-close-btn {
            background: none;
            border: none;
            font-size: 20px;
            color: #999;
            cursor: pointer;
            padding: 4px;
        }
        
        .apline-search-section {
            background: white;
            border-bottom: 1px solid #eee;
            padding: 15px 20px;
        }
        
        .apline-search-form {
            display: flex;
            gap: 10px;
        }
        
        .apline-search-input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }
        
        .apline-search-btn {
            padding: 8px 16px;
            background: #003561;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        
        .apline-content {
            display: flex;
            flex: 1;
            overflow: hidden;
        }
        
        .apline-org-tree {
            width: 250px;
            background: white;
            border-right: 1px solid #eee;
            overflow-y: auto;
            padding: 15px;
        }
        
        .apline-dept-item {
            padding: 8px 12px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .apline-dept-item:hover {
            background: #f8f9fa;
        }
        
        .apline-dept-item.active {
            background: #e8f4fd;
            color: #003561;
        }
        
        .apline-emp-list {
            flex: 1;
            overflow-y: auto;
            padding: 15px;
        }
        
        .apline-emp-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
        }
        
        .apline-emp-card {
            background: white;
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 15px;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .apline-emp-card:hover {
            border-color: #003561;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .apline-emp-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .apline-emp-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            color: #495057;
        }
        
        .apline-emp-details {
            flex: 1;
        }
        
        .apline-emp-name {
            font-weight: 500;
            color: #333;
            margin-bottom: 2px;
        }
        
        .apline-emp-position {
            font-size: 12px;
            color: #777;
        }
        
        .apline-recent-section {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        
        .apline-recent-title {
            font-size: 14px;
            font-weight: 600;
            color: #333;
            margin-bottom: 15px;
        }
        
        .apline-recent-list {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .apline-recent-item {
            background: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 6px;
            padding: 8px 12px;
            cursor: pointer;
            font-size: 13px;
            color: #495057;
        }
        
        .apline-recent-item:hover {
            background: #e9ecef;
        }
        
        .apline-action-bar {
            background: white;
            border-top: 1px solid #eee;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .apline-selected-info {
            color: #666;
            font-size: 14px;
        }
        
        .apline-btn {
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            border: 1px solid #ddd;
            background: white;
            color: #666;
        }
        
        .apline-btn-primary {
            background: #003561;
            color: white;
            border-color: #003561;
        }
        
        .apline-btn-primary:hover {
            background: #002d52;
        }
        
        .apline-no-recent {
            color: #94a3b8;
            text-align: center;
            padding: 10px;
            font-size: 13px;
        }
        
        /* 부서 카테고리 스타일 */
    .apline-dept-category {
        margin-bottom: 5px;
    }
    
    .apline-dept-header {
        display: flex;
        align-items: center;
        padding: 8px 12px;
        cursor: pointer;
        border-radius: 4px;
        font-size: 14px;
        position: relative;
    }
    
    .apline-dept-header:hover {
        background: #f8f9fa;
    }
    
    .apline-dept-header span {
        flex: 1;
        margin-left: 8px;
    }
    
    .dept-toggle-icon {
        font-size: 12px;
        transition: transform 0.2s;
    }
    
    .dept-toggle-icon.active {
        transform: rotate(180deg);
    }
    
    .apline-dept-employees {
        padding-left: 28px;
    }
    
    .apline-dept-emp-item {
        display: flex;
        align-items: center;
        padding: 6px 12px;
        margin: 3px 0;
        cursor: pointer;
        border-radius: 4px;
        font-size: 13px;
    }
    
    .apline-dept-emp-item:hover {
        background: #f1f5f9;
    }
    
    .apline-emp-avatar-small {
        width: 24px;
        height: 24px;
        border-radius: 50%;
        background: #e9ecef;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 12px;
        color: #495057;
        margin-right: 8px;
    }
    
    .apline-emp-name-small {
        font-weight: 500;
        color: #333;
    }
    
    .apline-emp-position-small {
        font-size: 11px;
        color: #777;
        margin-left: 4px;
    }
    </style>
</head>
<body>
    <div class="apline-container">
        <div class="apline-header">
            <h2 class="apline-title">결재선 선택</h2>
            <button class="apline-close-btn" onclick="window.close()">
                <i class="fas fa-times"></i>
            </button>
        </div>
        
        <div class="apline-search-section">
            <form class="apline-search-form" onsubmit="searchEmployees(event)">
                <input type="text" class="apline-search-input" placeholder="이름, 부서, 직급 검색" id="apline-search-keyword">
                <button type="submit" class="apline-search-btn">
                    <i class="fas fa-search"></i>
                </button>
            </form>
        </div>
        
        <div class="apline-content">
            <div class="apline-org-tree">
                <div class="apline-dept-item active" onclick="selectDept('ALL', this)">
                    <i class="fas fa-building"></i>
                    <span>전체</span>
                </div>
                
                <!-- 부서 링크로 변경 -->
			    <c:forEach var="dept" items="${departments}">
			        <div class="apline-dept-item" onclick="selectDept('${dept.deptNo}', this)">
			            <i class="fas fa-users"></i>
			            <span>${dept.deptName}</span>
			        </div>
			    </c:forEach>
            </div>
            
            <div class="apline-emp-list">
                <div class="apline-emp-grid" id="apline-employee-grid">
                    <c:forEach var="emp" items="${employeeList}">
                        <div class="apline-emp-card" onclick="selectEmployee(${emp.empNo}, '${emp.empName}', '${emp.deptName}', '${emp.positionName}')">
                            <div class="apline-emp-info">
                                <div class="apline-emp-avatar">
                                    ${emp.empName.substring(0, 1)}
                                </div>
                                <div class="apline-emp-details">
                                    <div class="apline-emp-name">${emp.empName}</div>
                                    <div class="apline-emp-position">${emp.deptName} · ${emp.positionName}</div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <div class="apline-recent-section">
				    <div class="apline-recent-title">최근 선택한 결재자</div>
				    <div class="apline-recent-list" id="apline-recent-list">
				        <!-- 동적으로 최근 결재자가 추가됩니다 -->
				    </div>
				</div>
            </div>
        </div>
        
        <div class="apline-action-bar">
            <div class="apline-selected-info">
                선택한 결재자를 클릭하여 결재선에 추가하세요
            </div>
            <button class="apline-btn" onclick="window.close()">닫기</button>
        </div>
    </div>
    
    <script>
    // 전역 변수 정의
    var recentApproversKey = 'recentApprovers';
    var recentApprovers = []; // 최근 선택한 결재자 목록 (최대 5명)

    // 페이지 로드 시 초기화
    window.onload = function() {
        // 로컬 스토리지에서 최근 선택한 결재자 불러오기
        loadRecentApproversFromStorage();
        
        // 최근 결재자 화면에 표시
        updateRecentApproversDisplay();
        
        // 부서 목록이 없는 경우 부서 목록 로드
        if (document.querySelectorAll('.apline-dept-category').length === 0) {
            loadDepartments();
        }
    };
    
    // 부서 목록 로드 (AJAX)
    function loadDepartments() {
        $.ajax({
            url: 'selectAllDepartments.ap',  // 이 URL을 컨트롤러에 추가해야 함
            method: 'GET',
            dataType: 'json',
            success: function(departments) {
                if (!departments || departments.length === 0) {
                    return;
                }
                
                var html = '';
                var orgTree = document.querySelector('.apline-org-tree');
                
                // 부서별 토글 버튼 생성
                for (var i = 0; i < departments.length; i++) {
                    var dept = departments[i];
                    html += '<div class="apline-dept-category">';
                    html += '    <div class="apline-dept-header" onclick="toggleDeptEmployees(\'' + dept.deptNo + '\')">';
                    html += '        <i class="fas fa-users"></i>';
                    html += '        <span>' + dept.deptName + '</span>';
                    html += '        <i class="fas fa-chevron-down dept-toggle-icon" id="dept-toggle-' + dept.deptNo + '"></i>';
                    html += '    </div>';
                    html += '    <div class="apline-dept-employees" id="dept-employees-' + dept.deptNo + '" style="display: none;">';
                    html += '        <!-- 직원 목록은 토글 시 동적으로 로드됩니다 -->';
                    html += '    </div>';
                    html += '</div>';
                }
                
             // 부서 목록 컨테이너에 HTML 추가
                document.getElementById('department-list-container').innerHTML = html;
            },
            error: function(xhr, status, error) {
                console.error('부서 목록 로드 중 오류 발생:', error);
            }
        });
    }

    // 부서 선택
    function selectDept(deptNo, element) {
        // 부서 선택 상태 업데이트
        document.querySelectorAll('.apline-dept-item').forEach(function(item) {
            item.classList.remove('active');
        });
        element.classList.add('active');
        
        // 해당 부서 직원 목록 로드
        loadEmployeesByDept(deptNo);
    }
    
    // 부서 토글 함수
    function toggleDeptEmployees(deptNo) {
        var employeesContainer = document.getElementById('dept-employees-' + deptNo);
        var toggleIcon = document.getElementById('dept-toggle-' + deptNo);
        
        // 토글 아이콘 회전
        if (toggleIcon.classList.contains('active')) {
            toggleIcon.classList.remove('active');
        } else {
            toggleIcon.classList.add('active');
        }
        
        // 직원 목록이 비어있으면 로드, 아니면 표시/숨김 토글
        if (employeesContainer.innerHTML.trim() === '') {
            // 직원 목록 로드
            loadDeptEmployees(deptNo, employeesContainer);
        } else {
            // 표시/숨김 토글
            if (employeesContainer.style.display === 'none') {
                employeesContainer.style.display = 'block';
            } else {
                employeesContainer.style.display = 'none';
            }
        }
    }

    // 부서별 직원 목록 로드 (토글 내에 직원 표시)
    function loadDeptEmployees(deptNo, container) {
        // 로딩 표시
        container.innerHTML = '<div class="apline-loading">로딩 중...</div>';
        container.style.display = 'block';
        
        // Ajax 요청으로 부서별 직원 목록 가져오기
        $.ajax({
            url: 'selectEmployeesByDept.ap',
            method: 'GET',
            data: { deptNo: deptNo },
            dataType: 'json',
            success: function(employees) {
                if (!employees || employees.length === 0) {
                    container.innerHTML = '<div class="apline-no-data">직원이 없습니다.</div>';
                    return;
                }
                
                var html = '';
                
                // 직원 항목 생성
                for (var i = 0; i < employees.length; i++) {
                    var emp = employees[i];
                    html += '<div class="apline-dept-emp-item" onclick="selectEmployee(' + emp.empNo + ', \'' + emp.empName + '\', \'' + emp.deptName + '\', \'' + emp.positionName + '\')">';
                    html += '    <div class="apline-emp-avatar-small">' + (emp.empName ? emp.empName.charAt(0) : '?') + '</div>';
                    html += '    <span class="apline-emp-name-small">' + (emp.empName || '이름 없음') + '</span>';
                    html += '    <span class="apline-emp-position-small">' + (emp.positionName || '') + '</span>';
                    html += '</div>';
                }
                
                container.innerHTML = html;
            },
            error: function(xhr, status, error) {
                console.error('부서별 직원 목록 로드 중 오류 발생:', error);
                container.innerHTML = '<div class="apline-error">직원 정보를 불러올 수 없습니다.</div>';
            }
        });
    }

    // 메인 영역에 직원 목록 로드 (전체 부서 선택 시)
    function loadEmployeesByDept(deptNo) {
        // Ajax 요청으로 부서별 직원 목록 가져오기
        $.ajax({
            url: 'selectEmployeesByDept.ap',
            method: 'GET',
            data: { deptNo: deptNo },
            dataType: 'json',
            success: function(data) {
                updateEmployeeGrid(data);
            },
            error: function(xhr, status, error) {
                console.error('직원 목록 로드 중 오류 발생:', error);
                // 오류 상황에서도 UI가 깨지지 않도록 처리
                var grid = document.getElementById('apline-employee-grid');
                grid.innerHTML = '<div class="apline-no-data">직원 정보를 불러올 수 없습니다.</div>';
            }
        });
    }
    
    // 직원 검색
    function searchEmployees(event) {
        event.preventDefault();
        var keyword = document.getElementById('apline-search-keyword').value;
        
        if (!keyword || keyword.trim() === '') {
            alert('검색어를 입력해주세요.');
            return;
        }
        
        // Ajax 요청으로 직원 검색
        $.ajax({
            url: 'searchEmployees.ap',
            method: 'GET',
            data: { keyword: keyword },
            dataType: 'json',
            success: function(data) {
                updateEmployeeGrid(data);
            },
            error: function(xhr, status, error) {
                console.error('직원 검색 중 오류 발생:', error);
                alert('검색 중 오류가 발생했습니다.');
            }
        });
    }
    
    // 직원 그리드 업데이트
    function updateEmployeeGrid(employees) {
        var grid = document.getElementById('apline-employee-grid');
        
        if (!employees || employees.length === 0) {
            grid.innerHTML = '<div class="apline-no-data">검색 결과가 없습니다.</div>';
            return;
        }
        
        var html = '';
        
        // 직원 카드 생성
        for (var i = 0; i < employees.length; i++) {
            var emp = employees[i];
            html += '<div class="apline-emp-card" onclick="selectEmployee(' + emp.empNo + ', \'' + emp.empName + '\', \'' + emp.deptName + '\', \'' + emp.positionName + '\')">';
            html += '    <div class="apline-emp-info">';
            html += '        <div class="apline-emp-avatar">';
            html += '            ' + (emp.empName ? emp.empName.charAt(0) : '?');
            html += '        </div>';
            html += '        <div class="apline-emp-details">';
            html += '            <div class="apline-emp-name">' + (emp.empName || '이름 없음') + '</div>';
            html += '            <div class="apline-emp-position">' + (emp.deptName || '부서 없음') + ' · ' + (emp.positionName || '직급 없음') + '</div>';
            html += '        </div>';
            html += '    </div>';
            html += '</div>';
        }
        
        grid.innerHTML = html;
    }
    
    // 직원 선택
    function selectEmployee(empNo, empName, deptName, positionName) {
        console.log("모달에서 선택된 사원:", empNo, empName, deptName, positionName);
        
        // 부모 창의 addApprovalLine 함수 호출
        if (window.opener && window.opener.addApprovalLine) {
            // 직원 정보 객체 생성
            var empData = {
                empNo: empNo,
                empName: empName,
                deptName: deptName,
                positionName: positionName
            };
            
            // 부모 창의 함수 호출하여 결재선에 추가
            window.opener.addApprovalLine(empData);
            
            // 선택한 결재자를 최근 목록에 추가
            saveRecentApprover(empData);
            
            // 선택 성공 표시
            var card = document.querySelector('.apline-emp-card[onclick*="' + empNo + '"]');
            if (card) {
                card.style.borderColor = '#28a745';
                card.style.backgroundColor = '#f8fffe';
                setTimeout(function() {
                    card.style.borderColor = '';
                    card.style.backgroundColor = '';
                }, 500);
            }
            
            // 선택 알림
            alert(empName + " " + positionName + "이(가) 결재선에 추가되었습니다.");
        } else {
            alert("부모 창을 찾을 수 없거나 addApprovalLine 함수가 정의되지 않았습니다.");
        }
    }
    
    // 최근 선택한 결재자 저장
    function saveRecentApprover(employee) {
        // 이미 저장된 결재자 목록 불러오기
        loadRecentApproversFromStorage();
        
        // 중복 결재자 제거 (같은 사원번호를 가진 결재자)
        recentApprovers = recentApprovers.filter(function(approver) {
            return approver.empNo !== employee.empNo;
        });
        
        // 최근 선택한 결재자를 목록의 맨 앞에 추가
        recentApprovers.unshift(employee);
        
        // 최대 5명으로 제한
        if (recentApprovers.length > 5) {
            recentApprovers = recentApprovers.slice(0, 5);
        }
        
        // 로컬 스토리지에 저장
        saveRecentApproversToStorage();
        
        // 화면 갱신
        updateRecentApproversDisplay();
    }
    
    // 로컬 스토리지에서 최근 결재자 불러오기
    function loadRecentApproversFromStorage() {
        try {
            var storedApprovers = localStorage.getItem(recentApproversKey);
            if (storedApprovers) {
                recentApprovers = JSON.parse(storedApprovers);
                // 배열 검증
                if (!Array.isArray(recentApprovers)) {
                    recentApprovers = [];
                }
            } else {
                recentApprovers = [];
            }
        } catch (e) {
            console.error('최근 결재자 불러오기 오류:', e);
            recentApprovers = [];
        }
    }
    
    // 로컬 스토리지에 최근 결재자 저장
    function saveRecentApproversToStorage() {
        try {
            localStorage.setItem(recentApproversKey, JSON.stringify(recentApprovers));
        } catch (e) {
            console.error('최근 결재자 저장 오류:', e);
        }
    }
    
    // 최근 결재자 화면에 표시
    function updateRecentApproversDisplay() {
        var recentList = document.getElementById('apline-recent-list');
        
        // 결재자가 없는 경우
        if (!recentApprovers || recentApprovers.length === 0) {
            recentList.innerHTML = '<div class="apline-no-recent">최근 선택한 결재자가 없습니다.</div>';
            return;
        }
        
        var html = '';
        
        // 최근 결재자 목록 생성
        for (var i = 0; i < recentApprovers.length; i++) {
            var approver = recentApprovers[i];
            var displayName = approver.empName + ' ' + (approver.positionName || '');
            var deptName = approver.deptName || '';
            
            html += '<div class="apline-recent-item" onclick="selectRecentApprover(' + approver.empNo + ')">';
            html += displayName + (deptName ? ' · ' + deptName : '');
            html += '</div>';
        }
        
        recentList.innerHTML = html;
    }
    
    // 최근 결재자 선택
    function selectRecentApprover(empNo) {
        // 결재자 찾기
        var selectedApprover = recentApprovers.find(function(approver) {
            return approver.empNo === empNo;
        });
        
        if (!selectedApprover) {
            alert('결재자 정보를 찾을 수 없습니다.');
            return;
        }
        
        // 결재자 선택 함수 호출
        selectEmployee(
            selectedApprover.empNo,
            selectedApprover.empName,
            selectedApprover.deptName,
            selectedApprover.positionName
        );
    }
    
    // 엔터키 검색
    document.getElementById('apline-search-keyword').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            searchEmployees(e);
        }
    });
</script>
</body>
</html>