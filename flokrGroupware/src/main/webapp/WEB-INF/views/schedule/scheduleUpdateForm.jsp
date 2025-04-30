<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Flokr - 일정 수정</title>
    <link href="${pageContext.request.contextPath}/resources/css/tabler.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/flokr.css" rel="stylesheet" />
    <style>
        /* --- 깔끔한 일정 수정 페이지 스타일 --- */
        .sc-update-container {
            max-width: 720px;
            margin: 24px auto;
            padding: 0;
        }

        .sc-update-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 1px 10px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            border: 1px solid #eaedf0;
        }

        .sc-update-header {
            padding: 20px 24px;
            border-bottom: 1px solid #eaedf0;
            background-color: #f9fafb;
        }

        .sc-update-title {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .sc-update-title svg {
            color: #003561;
            width: 20px;
            height: 20px;
        }

        .sc-update-body {
            padding: 24px;
        }

        .sc-update-notice {
            display: flex;
            align-items: flex-start;
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            padding: 12px 16px;
            margin-bottom: 24px;
            gap: 12px;
        }

        .sc-update-notice-icon {
            color: #003561;
            margin-top: 2px;
            flex-shrink: 0;
        }

        .sc-update-notice-text {
            font-size: 14px;
            color: #334155;
            line-height: 1.5;
        }

        .sc-update-group {
            margin-bottom: 20px;
        }

        .sc-update-label {
            display: block;
            font-size: 13px;
            color: #475569;
            margin-bottom: 6px;
            font-weight: 500;
        }

        .sc-update-label.required::after {
            content: '*';
            color: #dc2626;
            margin-left: 4px;
        }

        .sc-update-input, .sc-update-select, .sc-update-textarea {
            width: 100%;
            padding: 9px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 14px;
            color: #1e293b;
            transition: all 0.2s;
            background-color: #fff;
            box-sizing: border-box;
        }

        .sc-update-input:focus, .sc-update-select:focus, .sc-update-textarea:focus {
            border-color: #003561;
            outline: none;
            box-shadow: 0 0 0 2px rgba(0, 53, 97, 0.1);
        }

        .sc-update-textarea {
            min-height: 100px;
            resize: vertical;
            line-height: 1.5;
        }

        .sc-update-fields-group {
            display: flex;
            gap: 16px;
            margin-bottom: 20px;
        }

        .sc-update-field-half {
            flex: 1;
            position: relative;
        }

        .sc-update-date-wrapper, .sc-update-time-wrapper {
            position: relative;
        }

        .sc-update-date-icon, .sc-update-time-icon {
            position: absolute;
            right: 0;
            top: 0;
            width: 36px;
            height: 36px;
            display: none;
            align-items: center;
            justify-content: center;
            color: transparent;
            z-index: 1;
        }

        .sc-update-input[type="date"], .sc-update-input[type="time"] {
            position: relative;
        }

        .sc-update-date-input-overlay, .sc-update-time-input-overlay {
            position: absolute;
            right: 0;
            top: 0;
            width: 36px;
            height: 100%;
            cursor: pointer;
            z-index: 3;
        }

        .sc-update-checkbox-wrapper {
            display: flex;
            align-items: center;
            margin: 0 0 16px 0;
        }

        .sc-update-checkbox {
            margin-right: 8px;
            accent-color: #003561;
        }

        .sc-update-checkbox-label {
            font-size: 13px;
            color: #475569;
            cursor: pointer;
        }

        .sc-update-type-title {
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 8px;
            color: #475569;
        }

        .sc-update-radio-group {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .sc-update-radio-item {
            position: relative;
            display: inline-block;
        }

        .sc-update-radio-input {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .sc-update-radio-label {
            display: flex;
            align-items: center;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
            user-select: none;
            transition: all 0.2s;
            border: 1px solid #e2e8f0;
            background-color: #fff;
            color: #475569;
            line-height: 1.4;
        }

        .sc-update-radio-input:checked + .sc-update-radio-label {
            border-color: #003561;
            background-color: #003561;
            color: #ffffff;
            font-weight: 500;
        }

        .sc-update-color-group {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .sc-update-color-item {
            position: relative;
            display: inline-block;
        }

        .sc-update-color-input {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .sc-update-color-label {
            display: flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
            user-select: none;
            transition: all 0.2s;
        }

        .sc-update-color-input:checked + .sc-update-color-label {
            box-shadow: 0 0 0 2px currentColor;
            font-weight: 500;
        }

        .sc-update-color-blue { background-color: rgba(0, 53, 97, 0.08); color: #003561; }
        .sc-update-color-green { background-color: rgba(22, 163, 74, 0.08); color: #16a34a; }
        .sc-update-color-orange { background-color: rgba(234, 88, 12, 0.08); color: #ea580c; }
        .sc-update-color-purple { background-color: rgba(126, 34, 206, 0.08); color: #7e22ce; }

        .sc-update-footer {
            padding: 16px 24px;
            border-top: 1px solid #eaedf0;
            background-color: #f9fafb;
            display: flex;
            justify-content: flex-end;
        }

        .sc-update-buttons {
            display: flex;
            gap: 12px;
        }

        .sc-update-btn-cancel {
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            border: 1px solid #e2e8f0;
            background-color: #fff;
            color: #475569;
            text-decoration: none;
            font-weight: 500;
        }

        .sc-update-btn-submit {
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            border: none;
            background-color: #003561;
            color: white;
            font-weight: 500;
        }

        .sc-update-btn-cancel:hover {
            background-color: #f1f5f9;
            text-decoration: none;
            color: #1e293b;
        }

        .sc-update-btn-submit:hover {
            background-color: #002a4a;
        }

        .sc-update-time-fields {
            max-height: 100px;
            overflow: hidden;
            transition: max-height 0.3s ease, margin-bottom 0.3s ease, padding-top 0.3s ease;
            padding-top: 0;
            margin-bottom: 20px;
        }

        .sc-update-time-fields.hidden {
            max-height: 0;
            margin-bottom: 0;
            padding-top: 0;
            overflow: hidden;
        }
        /* --- 기존 스타일 끝 --- */

        /* --- 참석자 선택 모달 관련 스타일 (등록폼과 동일) --- */
        .attendee-modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        .attendee-modal-overlay.active {
            display: flex;
        }
        .attendee-modal-content {
            background-color: #fff;
            padding: 24px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 450px;
            max-height: 80vh;
            display: flex;
            flex-direction: column;
        }
        .attendee-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eaedf0;
        }
        .attendee-modal-title {
            font-size: 16px;
            font-weight: 600;
            color: #1e293b;
        }
        .attendee-modal-close-btn {
            background: none; border: none; font-size: 20px;
            cursor: pointer; color: #64748b; padding: 0;
        }
        .attendee-search-input {
            width: 100%; padding: 8px 12px; border: 1px solid #e2e8f0;
            border-radius: 6px; font-size: 14px; margin-bottom: 16px; box-sizing: border-box;
        }
        .attendee-search-input:focus {
             border-color: #003561; outline: none; box-shadow: 0 0 0 2px rgba(0, 53, 97, 0.1);
        }
        .attendee-modal-list {
            flex-grow: 1; overflow-y: auto; margin-bottom: 16px;
            border: 1px solid #eaedf0; border-radius: 6px; padding: 10px;
        }
        .attendee-modal-item {
            display: flex; align-items: center; padding: 6px 0;
        }
         .attendee-modal-item:not(:last-child) {
             border-bottom: 1px solid #f1f5f9;
         }
        .attendee-modal-checkbox {
            margin-right: 10px; accent-color: #003561; flex-shrink: 0;
        }
        .attendee-modal-label {
            font-size: 14px; color: #334155; cursor: pointer;
            display: flex; flex-direction: column;
        }
        .attendee-modal-label .name { font-weight: 500; }
        .attendee-modal-label .details { font-size: 12px; color: #64748b; }
        .attendee-modal-footer {
            display: flex; justify-content: flex-end; gap: 10px;
            padding-top: 16px; border-top: 1px solid #eaedf0;
        }
        .attendee-modal-btn {
            padding: 8px 16px; border-radius: 6px; font-size: 14px;
            cursor: pointer; font-weight: 500; border: 1px solid #e2e8f0;
        }
        .attendee-modal-btn-cancel { background-color: #fff; color: #475569; }
        .attendee-modal-btn-confirm { background-color: #003561; color: white; border-color: #003561; }
        .attendee-modal-btn-cancel:hover { background-color: #f1f5f9; }
        .attendee-modal-btn-confirm:hover { background-color: #002a4a; }
        .selected-attendees-display {
            min-height: 38px; border: 1px solid #e2e8f0; border-radius: 6px;
            padding: 9px 12px; background-color: #f8fafc; font-size: 14px;
            color: #475569; display: flex; flex-wrap: wrap; gap: 6px; cursor: default;
        }
        .selected-attendees-display.empty { color: #94a3b8; }
        .attendee-tag {
            background-color: #e0e7ff; color: #3730a3; padding: 2px 8px;
            border-radius: 4px; font-size: 13px; font-weight: 500;
        }
        .btn-select-attendee {
            padding: 9px 15px; border-radius: 6px; font-size: 14px; cursor: pointer;
            border: 1px solid #003561; background-color: #fff; color: #003561;
            font-weight: 500; transition: all 0.2s; margin-top: 8px;
            display: inline-flex; align-items: center; gap: 6px;
        }
        .btn-select-attendee:hover { background-color: rgba(0, 53, 97, 0.05); }
        .btn-select-attendee svg { width: 16px; height: 16px; }

        /* --- 읽기 전용 필드 스타일 (수정폼 전용) --- */
        .sc-update-input[readonly] {
            background-color: #f8fafc;
            color: #64748b;
            cursor: not-allowed;
            border-color: #e2e8f0;
        }
        .sc-update-input[readonly]:focus {
             border-color: #e2e8f0;
             box-shadow: none;
        }
        /* --- 읽기 전용 필드 스타일 끝 --- */

    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="page-body">
        <div class="sc-update-container">
            <div class="sc-update-card">
                <div class="sc-update-header">
                    <h3 class="sc-update-title">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                           <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                        </svg>
                        일정 수정
                    </h3>
                </div>
                <div class="sc-update-body">
                    <div class="sc-update-notice">
                        <div class="sc-update-notice-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"></circle>
                                <line x1="12" y1="16" x2="12" y2="12"></line>
                                <line x1="12" y1="8" x2="12.01" y2="8"></line>
                            </svg>
                        </div>
                        <div class="sc-update-notice-text">
                          기존 일정 정보를 수정합니다. 필수 항목(*)을 확인하고 저장해주세요.
                        </div>
                    </div>

                    <form action="update.sc" method="post" id="scheduleUpdateForm">
                        <input type="hidden" name="scheduleNo" value="${schedule.scheduleNo}">
                        <input type="hidden" name="createEmpNo" value="${schedule.createEmpNo}">

                        <div class="sc-update-group">
                            <label class="sc-update-label required">일정 제목</label>
                            <input type="text" class="sc-update-input" name="scheduleTitle" placeholder="일정 제목을 입력하세요" value="${schedule.scheduleTitle}" required>
                        </div>

                        <div class="sc-update-fields-group">
                            <div class="sc-update-field-half">
                                <label class="sc-update-label required">시작일</label>
                                <div class="sc-update-date-wrapper">
                                    <input type="date" class="sc-update-input" name="startDate" value="<fmt:formatDate value='${schedule.startDate}' pattern='yyyy-MM-dd'/>" required>
                                    <div class="sc-update-date-input-overlay" onclick="this.previousElementSibling.showPicker()"></div>
                                </div>
                            </div>
                            <div class="sc-update-field-half">
                                <label class="sc-update-label required">종료일</label>
                                <div class="sc-update-date-wrapper">
                                     <input type="date" class="sc-update-input" name="endDate" value="<fmt:formatDate value='${schedule.endDate}' pattern='yyyy-MM-dd'/>" required>
                                    <div class="sc-update-date-input-overlay" onclick="this.previousElementSibling.showPicker()"></div>
                                </div>
                            </div>
                        </div>

                        <div class="sc-update-checkbox-wrapper">
                             <input type="checkbox" id="allDay" name="allDay" class="sc-update-checkbox" ${schedule.allDay ? 'checked' : ''}>
                            <label for="allDay" class="sc-update-checkbox-label">종일 일정</label>
                        </div>

                        <div class="sc-update-fields-group sc-update-time-fields ${schedule.allDay ? 'hidden' : ''}">
                            <div class="sc-update-field-half">
                                <label class="sc-update-label">시작 시간</label>
                                <div class="sc-update-time-wrapper">
                                     <input type="time" class="sc-update-input" name="startTime" value="<fmt:formatDate value='${schedule.startDate}' pattern='HH:mm'/>">
                                    <div class="sc-update-time-input-overlay" onclick="this.previousElementSibling.showPicker()"></div>
                                </div>
                            </div>
                            <div class="sc-update-field-half">
                                <label class="sc-update-label">종료 시간</label>
                                <div class="sc-update-time-wrapper">
                                     <input type="time" class="sc-update-input" name="endTime" value="<fmt:formatDate value='${schedule.endDate}' pattern='HH:mm'/>">
                                    <div class="sc-update-time-input-overlay" onclick="this.previousElementSibling.showPicker()"></div>
                                </div>
                            </div>
                        </div>

                        <div class="sc-update-group">
                            <label class="sc-update-label">장소</label>
                            <input type="text" class="sc-update-input" name="location" placeholder="일정 장소를 입력하세요" value="${schedule.location}">
                        </div>

                        <div class="sc-update-group">
                            <label class="sc-update-label">중요도</label>
                            <div class="sc-update-radio-group">
                                <label class="sc-update-radio-item">
                                    <input type="radio" name="important" value="LOW" class="sc-update-radio-input" ${schedule.important eq 'LOW' ? 'checked' : ''}>
                                    <span class="sc-update-radio-label">낮음</span>
                                </label>
                                <label class="sc-update-radio-item">
                                    <input type="radio" name="important" value="NORMAL" class="sc-update-radio-input" ${schedule.important eq 'NORMAL' ? 'checked' : ''}>
                                    <span class="sc-update-radio-label">보통</span>
                                </label>
                                <label class="sc-update-radio-item">
                                    <input type="radio" name="important" value="HIGH" class="sc-update-radio-input" ${schedule.important eq 'HIGH' ? 'checked' : ''}>
                                    <span class="sc-update-radio-label">높음</span>
                                </label>
                            </div>
                        </div>

                        <div class="sc-update-group">
                            <label class="sc-update-label">일정 유형</label>
                            <div class="sc-update-color-group">
                                <label class="sc-update-color-item">
                                    <input type="radio" name="scheduleType" value="PERSONAL" class="sc-update-color-input" ${schedule.scheduleType eq 'PERSONAL' ? 'checked' : ''}>
                                    <span class="sc-update-color-label sc-update-color-blue">개인</span>
                                </label>
                                <label class="sc-update-color-item">
                                    <input type="radio" name="scheduleType" value="TEAM" class="sc-update-color-input" ${schedule.scheduleType eq 'TEAM' ? 'checked' : ''}>
                                    <span class="sc-update-color-label sc-update-color-green">팀</span>
                                </label>
                                <label class="sc-update-color-item">
                                    <input type="radio" name="scheduleType" value="COMPANY" class="sc-update-color-input" ${schedule.scheduleType eq 'COMPANY' ? 'checked' : ''}>
                                    <span class="sc-update-color-label sc-update-color-orange">회사</span>
                                </label>
                                <label class="sc-update-color-item">
                                    <input type="radio" name="scheduleType" value="OTHER" class="sc-update-color-input" ${schedule.scheduleType eq 'OTHER' ? 'checked' : ''}>
                                    <span class="sc-update-color-label sc-update-color-purple">기타</span>
                                </label>
                            </div>
                        </div>

                        <div class="sc-update-group">
                            <label class="sc-update-label">참석자</label>
                            <div id="selectedAttendeesDisplay" class="selected-attendees-display ${empty attendees ? 'empty' : ''}">
                                <c:if test="${empty attendees}">
                                    
                                </c:if>
                                <c:forEach items="${attendees}" var="attendee">
                                    <span class="attendee-tag">${attendee.empName}</span>
                                </c:forEach>
                            </div>
                            <input type="hidden" name="attendee" id="attendeeIds" value="${attendeeIds}">
                            <button type="button" class="btn-select-attendee" id="openAttendeeModalBtn">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="8.5" cy="7" r="4"></circle><line x1="20" y1="8" x2="20" y2="14"></line><line x1="17" y1="11" x2="23" y2="11"></line></svg>
                                참석자 선택
                            </button>
                        </div>

                        <div class="sc-update-group">
                            <label class="sc-update-label">내용</label>
                            <textarea class="sc-update-textarea" name="description" placeholder="일정에 대한 세부 내용을 입력하세요" rows="4">${schedule.description}</textarea>
                        </div>

                        <div class="sc-update-group">
                            <label class="sc-update-label">등록일</label>
                            <input type="text" class="sc-update-input" value="<fmt:formatDate value='${schedule.createDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" readonly>
                        </div>

                    </form>
                </div>
                <div class="sc-update-footer">
                    <div class="sc-update-buttons">
                        <a href="calendar.sc" class="sc-update-btn-cancel">취소</a>
                        <button type="submit" form="scheduleUpdateForm" class="sc-update-btn-submit">수정</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="attendeeModalOverlay" class="attendee-modal-overlay">
        <div class="attendee-modal-content">
            <div class="attendee-modal-header">
                <h4 class="attendee-modal-title">참석자 선택</h4>
                <button type="button" class="attendee-modal-close-btn" id="closeAttendeeModalBtn">&times;</button>
            </div>
            <input type="text" id="attendeeSearchInput" class="attendee-search-input" placeholder="이름 또는 부서로 검색...">
            <div id="attendeeModalList" class="attendee-modal-list">
                <c:if test="${empty eList}">
                    <p style="color: #64748b; font-size: 14px; text-align: center; margin: 20px 0;">선택 가능한 직원이 없습니다.</p>
                </c:if>
                <c:forEach var="emp" items="${eList}">
                    <div class="attendee-modal-item" data-emp-name="${emp.empName}" data-dept-name="${emp.deptName}">
                        <input type="checkbox" value="${emp.empNo}" id="modal_attendee_${emp.empNo}" class="attendee-modal-checkbox" 
                            ${attendeeIdsArray.contains(emp.empNo) ? 'checked' : ''}>
                        <label for="modal_attendee_${emp.empNo}" class="attendee-modal-label">
                            <span class="name">${emp.empName}</span>
                            <span class="details">${emp.deptName} / ${emp.positionName}</span>
                        </label>
                    </div>
                </c:forEach>
            </div>
            <div class="attendee-modal-footer">
                <button type="button" class="attendee-modal-btn attendee-modal-btn-cancel" id="cancelAttendeeSelectionBtn">취소</button>
                <button type="button" class="attendee-modal-btn attendee-modal-btn-confirm" id="confirmAttendeeSelectionBtn">확인</button>
            </div>
        </div>
    </div>


    <script src="${pageContext.request.contextPath}/resources/js/tabler.min.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // --- 기본 일정 필드 관련 로직 ---
        const allDayCheckbox = document.getElementById('allDay');
        const timeFieldsContainer = document.querySelector('.sc-update-time-fields');
        const startTimeInput = document.querySelector('input[name="startTime"]');
        const endTimeInput = document.querySelector('input[name="endTime"]');
        const startDateInput = document.querySelector('input[name="startDate"]');
        const endDateInput = document.querySelector('input[name="endDate"]');

        function toggleTimeFields() {
            if (allDayCheckbox.checked) {
                timeFieldsContainer.classList.add('hidden');
                startTimeInput.value = '00:00';
                endTimeInput.value = '23:59';
                allDayCheckbox.value = 'Y'; // 체크됐을 때 "Y" 값 설정
            } else {
                timeFieldsContainer.classList.remove('hidden');
                if (!startTimeInput.value || startTimeInput.value === '00:00') startTimeInput.value = '09:00';
                if (!endTimeInput.value || endTimeInput.value === '23:59') endTimeInput.value = '18:00';
                allDayCheckbox.value = 'N'; // 체크 해제됐을 때 "N" 값 설정
            }
        }

        // 초기 상태 설정
        toggleTimeFields();
        allDayCheckbox.addEventListener('change', toggleTimeFields);

        // 시작일 변경 시 종료일 자동 업데이트
        startDateInput.addEventListener('change', function() {
            if (!endDateInput.value || new Date(endDateInput.value) < new Date(this.value)) {
                endDateInput.value = this.value;
            }
            endDateInput.min = this.value;
        });

        // 종료일 변경 시 시작일 검증
        endDateInput.addEventListener('change', function() {
            if (startDateInput.value && new Date(this.value) < new Date(startDateInput.value)) {
                this.value = startDateInput.value;
            }
        });

        if (startDateInput.value) {
            endDateInput.min = startDateInput.value;
        }

        // 날짜/시간 선택기 오버레이 클릭 이벤트
        document.querySelectorAll('.sc-update-date-input-overlay, .sc-update-time-input-overlay').forEach(overlay => {
            overlay.addEventListener('click', function() {
                try { 
                    this.previousElementSibling.showPicker(); 
                } catch (e) { 
                    this.previousElementSibling.focus(); 
                }
            });
        });

        // --- 참석자 선택 모달 관련 로직 ---
        const openModalBtn = document.getElementById('openAttendeeModalBtn');
        const modalOverlay = document.getElementById('attendeeModalOverlay');
        const closeModalBtn = document.getElementById('closeAttendeeModalBtn');
        const cancelBtn = document.getElementById('cancelAttendeeSelectionBtn');
        const confirmBtn = document.getElementById('confirmAttendeeSelectionBtn');
        const attendeeSearchInput = document.getElementById('attendeeSearchInput');
        const attendeeModalList = document.getElementById('attendeeModalList');
        const selectedAttendeesDisplay = document.getElementById('selectedAttendeesDisplay');
        const attendeeIdsInput = document.getElementById('attendeeIds');

        // 모달 열기
        openModalBtn.addEventListener('click', function() {
            modalOverlay.classList.add('active');
            // 모달 열 때, 현재 숨겨진 필드에 저장된 ID를 기반으로 체크박스 상태 복원
            const currentIds = attendeeIdsInput.value.split(',').filter(id => id); // 빈 값 제거
            const checkboxes = attendeeModalList.querySelectorAll('.attendee-modal-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = currentIds.includes(checkbox.value);
            });
            // 검색창 초기화 및 필터링 초기화
            attendeeSearchInput.value = '';
            filterAttendees();
        });

        // 모달 닫기 (X 버튼 또는 취소 버튼)
        function closeModal() {
            modalOverlay.classList.remove('active');
        }
        closeModalBtn.addEventListener('click', closeModal);
        cancelBtn.addEventListener('click', closeModal);

        // 모달 외부 클릭 시 닫기
        modalOverlay.addEventListener('click', function(event) {
            if (event.target === modalOverlay) {
                closeModal();
            }
        });

        // 참석자 검색 (실시간 필터링)
        attendeeSearchInput.addEventListener('input', filterAttendees);

        function filterAttendees() {
            const searchTerm = attendeeSearchInput.value.toLowerCase();
            const items = attendeeModalList.querySelectorAll('.attendee-modal-item');
            items.forEach(item => {
                const name = item.dataset.empName?.toLowerCase() || '';
                const dept = item.dataset.deptName?.toLowerCase() || '';
                const isVisible = name.includes(searchTerm) || dept.includes(searchTerm);
                item.style.display = isVisible ? 'flex' : 'none';
            });
        }

        // 확인 버튼 클릭 시 선택된 참석자 처리
        confirmBtn.addEventListener('click', function() {
            const selectedNames = [];
            const selectedIds = [];
            const checkedCheckboxes = attendeeModalList.querySelectorAll('.attendee-modal-checkbox:checked');

            checkedCheckboxes.forEach(checkbox => {
                selectedIds.push(checkbox.value);
                // 체크박스에 연결된 라벨에서 이름 찾기
                const label = checkbox.closest('.attendee-modal-item').querySelector('.attendee-modal-label .name');
                if (label) {
                    selectedNames.push(label.textContent.trim());
                }
            });

            // 선택된 이름 표시 업데이트
            selectedAttendeesDisplay.innerHTML = ''; // 기존 내용 지우기
            if (selectedNames.length > 0) {
                selectedAttendeesDisplay.classList.remove('empty');
                selectedNames.forEach(name => {
                    const tag = document.createElement('span');
                    tag.className = 'attendee-tag';
                    tag.textContent = name;
                    selectedAttendeesDisplay.appendChild(tag);
                });
            } else {
                selectedAttendeesDisplay.classList.add('empty');
                selectedAttendeesDisplay.textContent = '참석자를 선택해주세요.';
            }

            // 숨겨진 필드에 ID 목록 업데이트 (쉼표로 구분)
            attendeeIdsInput.value = selectedIds.join(',');

            closeModal(); // 모달 닫기
        });

        // 폼 제출 시 유효성 검사
        const scheduleUpdateForm = document.getElementById('scheduleUpdateForm');
        scheduleUpdateForm.addEventListener('submit', function(e) {
            e.preventDefault(); // 기본 제출 동작 중지
            
            // 필수 필드 검증
            const title = this.querySelector('input[name="scheduleTitle"]').value.trim();
            if (!title) {
                alert('일정 제목을 입력해주세요.');
                return false;
            }
            
            // 종일 일정이 아닐 경우, 시작일/시간과 종료일/시간 검증
            if (!allDayCheckbox.checked) {
                const startDateValue = startDateInput.value;
                const endDateValue = endDateInput.value;
                const startTimeValue = startTimeInput.value;
                const endTimeValue = endTimeInput.value;
                
                // 같은 날짜에 종료 시간이 시작 시간보다 빠른지 확인
                if (startDateValue === endDateValue && startTimeValue > endTimeValue) {
                    alert('종료 시간은 시작 시간보다 늦어야 합니다.');
                    return false;
                }
            }
            
            // 모든 검증 통과 시 폼 제출
            this.submit();
        });
    });
    </script>
</body>
</html>