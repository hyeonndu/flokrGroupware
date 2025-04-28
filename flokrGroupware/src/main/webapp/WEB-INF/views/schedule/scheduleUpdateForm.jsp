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
        /* --- 깔끔한 일정 등록 페이지 스타일 --- */
        .sc-enroll-container {
            max-width: 720px;
            margin: 24px auto;
            padding: 0;
        }

        .sc-enroll-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 1px 10px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            border: 1px solid #eaedf0;
        }

        .sc-enroll-header {
            padding: 20px 24px;
            border-bottom: 1px solid #eaedf0;
            background-color: #f9fafb;
        }

        .sc-enroll-title {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .sc-enroll-title svg {
            color: #003561;
            width: 20px;
            height: 20px;
        }

        .sc-enroll-body {
            padding: 24px;
        }

        .sc-enroll-notice {
            display: flex;
            align-items: flex-start;
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            padding: 12px 16px;
            margin-bottom: 24px;
            gap: 12px;
        }

        .sc-enroll-notice-icon {
            color: #003561;
            margin-top: 2px;
            flex-shrink: 0;
        }

        .sc-enroll-notice-text {
            font-size: 14px;
            color: #334155;
            line-height: 1.5;
        }

        .sc-enroll-group {
            margin-bottom: 20px;
        }

        .sc-enroll-label {
            display: block;
            font-size: 13px;
            color: #475569;
            margin-bottom: 6px;
            font-weight: 500;
        }

        .sc-enroll-label.required::after {
            content: '*';
            color: #dc2626;
            margin-left: 4px;
        }

        .sc-enroll-input, .sc-enroll-select, .sc-enroll-textarea {
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

        .sc-enroll-input:focus, .sc-enroll-select:focus, .sc-enroll-textarea:focus {
            border-color: #003561;
            outline: none;
            box-shadow: 0 0 0 2px rgba(0, 53, 97, 0.1);
        }

        .sc-enroll-textarea {
            min-height: 100px;
            resize: vertical;
            line-height: 1.5;
        }

        .sc-enroll-fields-group {
            display: flex;
            gap: 16px;
            margin-bottom: 20px;
        }

        .sc-enroll-field-half {
            flex: 1;
            position: relative;
        }

        .sc-enroll-date-wrapper, .sc-enroll-time-wrapper {
            position: relative;
        }

        .sc-enroll-date-icon, .sc-enroll-time-icon {
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

        .sc-enroll-input[type="date"], .sc-enroll-input[type="time"] {
            position: relative;
        }

        .sc-enroll-date-input-overlay, .sc-enroll-time-input-overlay {
            position: absolute;
            right: 0;
            top: 0;
            width: 36px;
            height: 100%;
            cursor: pointer;
            z-index: 3;
        }

        .sc-enroll-checkbox-wrapper {
            display: flex;
            align-items: center;
            margin: 0 0 16px 0;
        }

        .sc-enroll-checkbox {
            margin-right: 8px;
            accent-color: #003561;
        }

        .sc-enroll-checkbox-label {
            font-size: 13px;
            color: #475569;
            cursor: pointer;
        }

        .sc-enroll-type-title {
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 8px;
            color: #475569;
        }

        .sc-enroll-radio-group {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .sc-enroll-radio-item {
            position: relative;
            display: inline-block;
        }

        .sc-enroll-radio-input {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .sc-enroll-radio-label {
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

        .sc-enroll-radio-input:checked + .sc-enroll-radio-label {
            border-color: #003561;
            background-color: #003561;
            color: #ffffff;
            font-weight: 500;
        }

        .sc-enroll-color-group {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .sc-enroll-color-item {
            position: relative;
            display: inline-block;
        }

        .sc-enroll-color-input {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .sc-enroll-color-label {
            display: flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
            user-select: none;
            transition: all 0.2s;
        }

        .sc-enroll-color-input:checked + .sc-enroll-color-label {
            box-shadow: 0 0 0 2px currentColor;
            font-weight: 500;
        }

        .sc-enroll-color-blue { background-color: rgba(0, 53, 97, 0.08); color: #003561; }
        .sc-enroll-color-green { background-color: rgba(22, 163, 74, 0.08); color: #16a34a; }
        .sc-enroll-color-orange { background-color: rgba(234, 88, 12, 0.08); color: #ea580c; }
        .sc-enroll-color-purple { background-color: rgba(126, 34, 206, 0.08); color: #7e22ce; }

        .sc-enroll-footer {
            padding: 16px 24px;
            border-top: 1px solid #eaedf0;
            background-color: #f9fafb;
            display: flex;
            justify-content: flex-end;
        }

        .sc-enroll-buttons {
            display: flex;
            gap: 12px;
        }

        .sc-enroll-btn-cancel {
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

        .sc-enroll-btn-submit {
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            border: none;
            background-color: #003561;
            color: white;
            font-weight: 500;
        }

        .sc-enroll-btn-cancel:hover {
            background-color: #f1f5f9;
            text-decoration: none;
            color: #1e293b;
        }

        .sc-enroll-btn-submit:hover {
            background-color: #002a4a;
        }

        .sc-enroll-time-fields {
            max-height: 100px;
            overflow: hidden;
            transition: max-height 0.3s ease, margin-bottom 0.3s ease, padding-top 0.3s ease;
            padding-top: 0;
            margin-bottom: 20px;
        }

        .sc-enroll-time-fields.hidden {
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
        .sc-enroll-input[readonly] {
            background-color: #f8fafc;
            color: #64748b;
            cursor: not-allowed;
            border-color: #e2e8f0;
        }
        .sc-enroll-input[readonly]:focus {
             border-color: #e2e8f0;
             box-shadow: none;
        }
        /* --- 읽기 전용 필드 스타일 끝 --- */

    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="page-body">
        <div class="sc-enroll-container">
            <div class="sc-enroll-card">
                <div class="sc-enroll-header">
                    <h3 class="sc-enroll-title">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                           <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                        </svg>
                        일정 수정
                    </h3>
                </div>
                <div class="sc-enroll-body">
                    <div class="sc-enroll-notice">
                        <div class="sc-enroll-notice-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"></circle>
                                <line x1="12" y1="16" x2="12" y2="12"></line>
                                <line x1="12" y1="8" x2="12.01" y2="8"></line>
                            </svg>
                        </div>
                        <div class="sc-enroll-notice-text">
                            기존 일정 정보를 수정합니다. 필수 항목(*)을 확인하고 저장해주세요.
                        </div>
                    </div>

                    <form action="update.sc" method="post" id="scheduleUpdateForm">
                        <input type="hidden" name="scheduleNo" value="${schedule.scheduleNo}">

                        <div class="sc-enroll-group">
                            <label class="sc-enroll-label required">일정 제목</label>
                            <input type="text" class="sc-enroll-input" name="scheduleTitle" placeholder="일정 제목을 입력하세요" value="${schedule.scheduleTitle}" required>
                        </div>

                        <div class="sc-enroll-fields-group">
                            <div class="sc-enroll-field-half">
                                <label class="sc-enroll-label required">시작일</label>
                                <div class="sc-enroll-date-wrapper">
                                    <input type="date" class="sc-enroll-input" name="startDate" value="<fmt:formatDate value='${schedule.startDate}' pattern='yyyy-MM-dd'/>" required>
                                    <div class="sc-enroll-date-input-overlay" onclick="this.previousElementSibling.showPicker()"></div>
                                </div>
                            </div>
                            <div class="sc-enroll-field-half">
                                <label class="sc-enroll-label required">종료일</label>
                                <div class="sc-enroll-date-wrapper">
                                     <input type="date" class="sc-enroll-input" name="endDate" value="<fmt:formatDate value='${schedule.endDate}' pattern='yyyy-MM-dd'/>" required>
                                    <div class="sc-enroll-date-input-overlay" onclick="this.previousElementSibling.showPicker()"></div>
                                </div>
                            </div>
                        </div>

                        <div class="sc-enroll-checkbox-wrapper">
                             <input type="checkbox" id="allDay" name="allDay" class="sc-enroll-checkbox" ${schedule.allDay ? 'checked' : ''}>
                            <label for="allDay" class="sc-enroll-checkbox-label">종일 일정</label>
                        </div>

                        <div class="sc-enroll-fields-group sc-enroll-time-fields ${schedule.allDay ? 'hidden' : ''}">
                            <div class="sc-enroll-field-half">
                                <label class="sc-enroll-label">시작 시간</label>
                                <div class="sc-enroll-time-wrapper">
                                     <input type="time" class="sc-enroll-input" name="startTime" value="<fmt:formatDate value='${schedule.startDate}' pattern='HH:mm'/>">
                                    <div class="sc-enroll-time-input-overlay" onclick="this.previousElementSibling.showPicker()"></div>
                                </div>
                            </div>
                            <div class="sc-enroll-field-half">
                                <label class="sc-enroll-label">종료 시간</label>
                                <div class="sc-enroll-time-wrapper">
                                     <input type="time" class="sc-enroll-input" name="endTime" value="<fmt:formatDate value='${schedule.endDate}' pattern='HH:mm'/>">
                                    <div class="sc-enroll-time-input-overlay" onclick="this.previousElementSibling.showPicker()"></div>
                                </div>
                            </div>
                        </div>

                        <div class="sc-enroll-group">
                            <label class="sc-enroll-label">장소</label>
                            <input type="text" class="sc-enroll-input" name="location" placeholder="일정 장소를 입력하세요" value="${schedule.location}">
                        </div>

                        <div class="sc-enroll-group">
                            <label class="sc-enroll-label">중요도</label>
                            <div class="sc-enroll-radio-group">
                                <label class="sc-enroll-radio-item">
                                    <input type="radio" name="priority" value="LOW" class="sc-enroll-radio-input" ${schedule.priority == 'LOW' ? 'checked' : ''}>
                                    <span class="sc-enroll-radio-label">낮음</span>
                                </label>
                                <label class="sc-enroll-radio-item">
                                    <input type="radio" name="priority" value="NORMAL" class="sc-enroll-radio-input" ${schedule.priority == 'NORMAL' ? 'checked' : ''}>
                                    <span class="sc-enroll-radio-label">보통</span>
                                </label>
                                <label class="sc-enroll-radio-item">
                                    <input type="radio" name="priority" value="HIGH" class="sc-enroll-radio-input" ${schedule.priority == 'HIGH' ? 'checked' : ''}>
                                    <span class="sc-enroll-radio-label">높음</span>
                                </label>
                            </div>
                        </div>

                        <div class="sc-enroll-group">
                            <label class="sc-enroll-label">일정 유형</label>
                            <div class="sc-enroll-color-group">
                                <label class="sc-enroll-color-item">
                                    <input type="radio" name="scheduleType" value="PERSONAL" class="sc-enroll-color-input" ${schedule.scheduleType == 'PERSONAL' ? 'checked' : ''}>
                                    <span class="sc-enroll-color-label sc-enroll-color-blue">개인</span>
                                </label>
                                <label class="sc-enroll-color-item">
                                    <input type="radio" name="scheduleType" value="TEAM" class="sc-enroll-color-input" ${schedule.scheduleType == 'TEAM' ? 'checked' : ''}>
                                    <span class="sc-enroll-color-label sc-enroll-color-green">팀</span>
                                </label>
                                <label class="sc-enroll-color-item">
                                    <input type="radio" name="scheduleType" value="COMPANY" class="sc-enroll-color-input" ${schedule.scheduleType == 'COMPANY' ? 'checked' : ''}>
                                    <span class="sc-enroll-color-label sc-enroll-color-orange">회사</span>
                                </label>
                                <label class="sc-enroll-color-item">
                                    <input type="radio" name="scheduleType" value="OTHER" class="sc-enroll-color-input" ${schedule.scheduleType == 'OTHER' ? 'checked' : ''}>
                                    <span class="sc-enroll-color-label sc-enroll-color-purple">기타</span>
                                </label>
                            </div>
                        </div>

                        <div class="sc-enroll-group">
                            <label class="sc-enroll-label">참석자</label>
                            <div id="selectedAttendeesDisplay" class="selected-attendees-display empty">
                                참석자를 선택해주세요.
                            </div>
                            <input type="hidden" name="attendees" id="attendeeIds">
                            <button type="button" class="btn-select-attendee" id="openAttendeeModalBtn">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="8.5" cy="7" r="4"></circle><line x1="20" y1="8" x2="20" y2="14"></line><line x1="17" y1="11" x2="23" y2="11"></line></svg>
                                참석자 선택
                            </button>
                        </div>

                        <div class="sc-enroll-group">
                            <label class="sc-enroll-label">내용</label>
                            <textarea class="sc-enroll-textarea" name="description" placeholder="일정에 대한 세부 내용을 입력하세요" rows="4">${schedule.description}</textarea>
                        </div>

                         <div class="sc-enroll-group">
                            <label class="sc-enroll-label">작성자</label>
                            <input type="text" class="sc-enroll-input" value="${schedule.empName}" readonly>
                            <input type="hidden" name="empNo" value="${schedule.empNo}">
                        </div>

                        <div class="sc-enroll-group">
                            <label class="sc-enroll-label">생성일</label>
                            <input type="text" class="sc-enroll-input" value="<fmt:formatDate value='${schedule.createDate}' pattern='yyyy-MM-dd HH:mm'/>" readonly>
                        </div>

                    </form>
                </div>
                <div class="sc-enroll-footer">
                    <div class="sc-enroll-buttons">
                         <a href="javascript:history.back()" class="sc-enroll-btn-cancel">취소</a>
                        <button type="submit" form="scheduleUpdateForm" class="sc-enroll-btn-submit">수정</button>
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
                <c:if test="${empty employeeList}">
                    <p style="color: #64748b; font-size: 14px; text-align: center; margin: 20px 0;">선택 가능한 직원이 없습니다.</p>
                </c:if>
                <c:forEach var="emp" items="${employeeList}">
                    <div class="attendee-modal-item" data-emp-name="${emp.empName}" data-dept-name="${emp.deptName}">
                        <input type="checkbox" value="${emp.empNo}" id="modal_attendee_${emp.empNo}" class="attendee-modal-checkbox">
                        <label for="modal_attendee_${emp.empNo}" class="attendee-modal-label">
                            <span class="name">${emp.empName}</span>
                            <span class="details">${emp.deptName} / ${emp.position}</span>
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
        // --- 기존 로직 (수정 없음 - ID/클래스명 동일하게 유지) ---
        const allDayCheckbox = document.getElementById('allDay');
        const timeFieldsContainer = document.querySelector('.sc-enroll-time-fields');
        const startTimeInput = document.querySelector('input[name="startTime"]');
        const endTimeInput = document.querySelector('input[name="endTime"]');
        const startDateInput = document.querySelector('input[name="startDate"]');
        const endDateInput = document.querySelector('input[name="endDate"]');

        function toggleTimeFields() {
            if (allDayCheckbox.checked) {
                timeFieldsContainer.classList.add('hidden');
            } else {
                timeFieldsContainer.classList.remove('hidden');
                if (!startTimeInput.value) startTimeInput.value = '09:00';
                if (!endTimeInput.value) endTimeInput.value = '18:00';
            }
        }

        toggleTimeFields();
        allDayCheckbox.addEventListener('change', toggleTimeFields);

        startDateInput.addEventListener('change', function() {
            if (!endDateInput.value || new Date(endDateInput.value) < new Date(this.value)) {
                endDateInput.value = this.value;
            }
            endDateInput.min = this.value;
        });

         endDateInput.addEventListener('change', function() {
             if (startDateInput.value && new Date(this.value) < new Date(startDateInput.value)) {
                 this.value = startDateInput.value;
             }
         });

         if (startDateInput.value) {
            endDateInput.min = startDateInput.value;
         }

        document.querySelectorAll('.sc-enroll-date-input-overlay, .sc-enroll-time-input-overlay').forEach(overlay => {
            overlay.addEventListener('click', function() {
                try { this.previousElementSibling.showPicker(); }
                catch (e) { this.previousElementSibling.focus(); }
            });
        });

        // --- 참석자 선택 모달 관련 로직 (수정폼용 로직 추가) ---
        const openModalBtn = document.getElementById('openAttendeeModalBtn');
        const modalOverlay = document.getElementById('attendeeModalOverlay');
        const closeModalBtn = document.getElementById('closeAttendeeModalBtn');
        const cancelBtn = document.getElementById('cancelAttendeeSelectionBtn');
        const confirmBtn = document.getElementById('confirmAttendeeSelectionBtn');
        const attendeeSearchInput = document.getElementById('attendeeSearchInput');
        const attendeeModalList = document.getElementById('attendeeModalList');
        const selectedAttendeesDisplay = document.getElementById('selectedAttendeesDisplay');
        const attendeeIdsInput = document.getElementById('attendeeIds');

        // 수정폼 로드 시, 서버에서 전달된 현재 참석자 정보로 초기 상태 설정
        const initialAttendeeIds = [
            <c:forEach var="attendee" items="${currentAttendees}" varStatus="status">
                "${attendee.empNo}"${!status.last ? ',' : ''}
            </c:forEach>
        ];
        const initialAttendeeNames = [
             <c:forEach var="attendee" items="${currentAttendees}" varStatus="status">
                "${attendee.empName}"${!status.last ? ',' : ''}
            </c:forEach>
        ];

        function updateSelectedAttendeesDisplay(names) {
            selectedAttendeesDisplay.innerHTML = '';
            if (names && names.length > 0) {
                selectedAttendeesDisplay.classList.remove('empty');
                names.forEach(name => {
                    const tag = document.createElement('span');
                    tag.className = 'attendee-tag';
                    tag.textContent = name;
                    selectedAttendeesDisplay.appendChild(tag);
                });
            } else {
                selectedAttendeesDisplay.classList.add('empty');
                selectedAttendeesDisplay.textContent = '참석자를 선택해주세요.';
            }
        }

        updateSelectedAttendeesDisplay(initialAttendeeNames);
        attendeeIdsInput.value = initialAttendeeIds.join(',');

        // 모달 열기
        openModalBtn.addEventListener('click', function() {
            modalOverlay.classList.add('active');
            const currentIds = attendeeIdsInput.value.split(',').filter(id => id);
            const checkboxes = attendeeModalList.querySelectorAll('.attendee-modal-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = currentIds.includes(checkbox.value);
            });
            attendeeSearchInput.value = '';
            filterAttendees();
        });

        // 모달 닫기
        function closeModal() {
            modalOverlay.classList.remove('active');
        }
        closeModalBtn.addEventListener('click', closeModal);
        cancelBtn.addEventListener('click', closeModal);
        modalOverlay.addEventListener('click', function(event) {
            if (event.target === modalOverlay) closeModal();
        });

        // 참석자 검색
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

        // 확인 버튼 클릭
        confirmBtn.addEventListener('click', function() {
            const selectedNames = [];
            const selectedIds = [];
            const checkedCheckboxes = attendeeModalList.querySelectorAll('.attendee-modal-checkbox:checked');

            checkedCheckboxes.forEach(checkbox => {
                selectedIds.push(checkbox.value);
                const label = checkbox.closest('.attendee-modal-item').querySelector('.attendee-modal-label .name');
                if (label) selectedNames.push(label.textContent.trim());
            });

            updateSelectedAttendeesDisplay(selectedNames);
            attendeeIdsInput.value = selectedIds.join(',');
            closeModal();
        });

    });
    </script>
</body>
</html>