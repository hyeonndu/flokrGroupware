<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 일정 상세 모달 -->
<div id="scheduleDetailModal" class="schedule-modal">
    <div class="schedule-modal-content">
        <div class="schedule-modal-header">
            <h3 class="schedule-modal-title">
                <span class="schedule-modal-title-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="16" y1="2" x2="16" y2="6"></line>
                        <line x1="8" y1="2" x2="8" y2="6"></line>
                        <line x1="3" y1="10" x2="21" y2="10"></line>
                    </svg>
                </span>
                일정 상세
            </h3>
            <div class="schedule-modal-actions">
                <button type="button" class="schedule-modal-btn-header schedule-modal-btn-edit" onclick="editSchedule()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                        <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                    </svg>
                    수정
                </button>
                <button type="button" class="schedule-modal-btn-header schedule-modal-btn-delete" onclick="confirmDeleteSchedule()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="3 6 5 6 21 6"></polyline>
                        <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                        <line x1="10" y1="11" x2="10" y2="17"></line>
                        <line x1="14" y1="11" x2="14" y2="17"></line>
                    </svg>
                    삭제
                </button>
            </div>
        </div>
        <div class="schedule-modal-body">
            <div class="schedule-detail-container">
                <div class="schedule-detail-section">
                    <div class="schedule-detail-label">일정 제목</div>
                    <div class="schedule-detail-title-area">
                        <h4 id="scheduleTitle" class="schedule-detail-title"></h4>
                        <span id="scheduleImportant" class="schedule-detail-important"></span>
                    </div>
                </div>
                
                <div class="schedule-detail-section">
                    <div class="schedule-detail-label">일정 기간</div>
                    <div id="scheduleDate" class="schedule-detail-value"></div>
                </div>
                
                <div class="schedule-detail-section">
                    <div class="schedule-detail-label">장소</div>
                    <div id="scheduleLocation" class="schedule-detail-value"></div>
                </div>
                
                <div class="schedule-detail-section">
                    <div class="schedule-detail-label">일정 유형</div>
                    <div id="scheduleType" class="schedule-detail-value"></div>
                </div>
                
                <div id="attendeesGroup" class="schedule-detail-section" style="display: none;">
                    <div class="schedule-detail-label">참석자</div>
                    <div id="scheduleAttendees" class="schedule-detail-value">
                        <div class="schedule-detail-attendee-list"></div>
                    </div>
                </div>
                
                <div class="schedule-detail-divider"></div>
                
                <div class="schedule-detail-section">
                    <div class="schedule-detail-label">내용</div>
                    <div id="scheduleDescription" class="schedule-detail-description"></div>
                </div>
            </div>
        </div>
        <div class="schedule-modal-footer">
            <button type="button" class="schedule-modal-btn schedule-modal-btn-back" onclick="closeScheduleDetailModal()">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="15 18 9 12 15 6"></polyline>
                </svg>
                목록으로
            </button>
        </div>
    </div>
</div>

<style>
    /* 일정 상세 모달 스타일 */
    .schedule-modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        align-items: center;
        justify-content: center;
    }
    
    .schedule-modal.active {
        display: flex;
    }
    
    .schedule-modal-content {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        width: 90%;
        max-width: 500px;
        max-height: 90vh;
        display: flex;
        flex-direction: column;
        overflow: hidden;
    }
    
    .schedule-modal-header {
        padding: 16px 20px;
        border-bottom: 1px solid #eaedf0;
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #f9fafb;
    }
    
    .schedule-modal-title {
        margin: 0;
        font-size: 18px;
        font-weight: 600;
        color: #1e293b;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .schedule-modal-title-icon {
        color: #003561;
        display: flex;
        align-items: center;
    }
    
    .schedule-modal-close {
        background: none;
        border: none;
        font-size: 24px;
        cursor: pointer;
        color: #64748b;
        padding: 0;
        width: 24px;
        height: 24px;
        line-height: 1;
    }
    
    .schedule-modal-actions {
        display: flex;
        gap: 8px;
        margin-left: auto;
    }
    
    .schedule-modal-btn-header {
        padding: 6px 10px;
        border-radius: 4px;
        font-size: 12px;
        font-weight: 500;
        cursor: pointer;
        border: 1px solid transparent;
        transition: all 0.2s;
        display: flex;
        align-items: center;
        gap: 4px;
    }
    
    .schedule-modal-btn-edit {
        background-color: #f1f5f9;
        color: #475569;
        border-color: #e2e8f0;
    }
    
    .schedule-modal-btn-delete {
        background-color: #003561;
        color: white;
        border-color: #003561;
    }
    
    .schedule-modal-btn-edit:hover {
        background-color: #e2e8f0;
    }
    
    .schedule-modal-btn-delete:hover {
        background-color: #002a4a;
    }
    
    .schedule-modal-btn-header svg {
        width: 12px;
        height: 12px;
    }
    
    .schedule-modal-body {
        padding: 20px;
        overflow-y: auto;
        flex: 1;
    }
    
    .schedule-detail-container {
        display: flex;
        flex-direction: column;
        gap: 16px;
    }
    
    .schedule-detail-group {
        display: flex;
        flex-direction: column;
        gap: 4px;
    }
    
    .schedule-detail-title-area {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .schedule-detail-title {
        margin: 0;
        font-size: 18px;
        font-weight: 600;
        color: #0f172a;
        line-height: 1.4;
    }
    
    /* 중요도 스타일 */
    .schedule-detail-important {
        display: inline-flex;
        align-items: center;
        padding: 3px 8px;
        border-radius: 50px;
        font-size: 12px;
        font-weight: 500;
    }
    
    .schedule-detail-important.low {
        background-color: #e0f2fe;
        color: #0284c7;
    }
    
    .schedule-detail-important.normal {
        background-color: #f0fdf4;
        color: #16a34a;
    }
    
    .schedule-detail-important.high {
        background-color: #fef2f2;
        color: #dc2626;
    }
    
    .schedule-detail-section {
        margin-bottom: 14px;
    }
    
    .schedule-detail-label {
        font-size: 13px;
        color: #64748b;
        margin-bottom: 4px;
        font-weight: 500;
    }
    
    .schedule-detail-value {
        font-size: 15px;
        color: #334155;
        line-height: 1.5;
    }
    
    /* 일정 유형 스타일 */
    .schedule-detail-type {
        display: inline-flex;
        align-items: center;
        padding: 4px 10px;
        border-radius: 4px;
        font-size: 13px;
        font-weight: 500;
    }
    
    .schedule-detail-type.personal {
        background-color: rgba(0, 53, 97, 0.08);
        color: #003561;
    }
    
    .schedule-detail-type.team {
        background-color: rgba(22, 163, 74, 0.08);
        color: #16a34a;
    }
    
    .schedule-detail-type.company {
        background-color: rgba(234, 88, 12, 0.08);
        color: #ea580c;
    }
    
    .schedule-detail-type.other {
        background-color: rgba(126, 34, 206, 0.08);
        color: #7e22ce;
    }
    
    .schedule-detail-attendee-list {
        display: flex;
        flex-wrap: wrap;
        gap: 6px;
    }
    
    .schedule-detail-attendee-item {
        background-color: #e0e7ff;
        color: #3730a3;
        padding: 3px 8px;
        border-radius: 4px;
        font-size: 13px;
    }
    
    .schedule-detail-divider {
        height: 1px;
        background-color: #e2e8f0;
        margin: 4px 0;
    }
    
    .schedule-detail-description {
        background-color: #f8fafc;
        border-radius: 6px;
        padding: 12px;
        font-size: 14px;
        color: #334155;
        line-height: 1.6;
        white-space: pre-wrap;
        min-height: 60px;
    }
    
    .schedule-modal-footer {
        padding: 12px 20px;
        border-top: 1px solid #eaedf0;
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 10px;
        background-color: #f9fafb;
    }
    
    .schedule-modal-btn {
        padding: 8px 16px;
        border-radius: 4px;
        font-size: 13px;
        font-weight: 500;
        cursor: pointer;
        border: 1px solid transparent;
        transition: all 0.2s;
        display: flex;
        align-items: center;
        gap: 6px;
    }
    
    .schedule-modal-btn-back {
        background-color: #fff;
        color: #475569;
        border-color: #e2e8f0;
    }
    
    .schedule-modal-btn-back:hover {
        background-color: #f1f5f9;
    }
    
    .schedule-modal-btn svg {
        width: 14px;
        height: 14px;
    }
    
    .schedule-detail-empty {
        color: #94a3b8;
        font-style: italic;
    }
</style>

<script>
    // 전역 변수로 현재 일정 ID 저장
    let currentScheduleId = null;
    
    // 일정 상세 모달 열기
    function openScheduleDetailModal(scheduleId) {
        currentScheduleId = scheduleId;
        
        // AJAX로 일정 상세 정보 가져오기
        $.ajax({
            url: 'getScheduleDetail.sc',
            type: 'GET',
            data: { 'no': scheduleId },
            dataType: 'json',
            success: function(data) {
                fillScheduleDetailModal(data);
                $('#scheduleDetailModal').addClass('active');
                
                // 모달 외부 클릭 시 닫기 이벤트 추가
                $(document).on('click', function(e) {
                    if ($(e.target).is('#scheduleDetailModal')) {
                        closeScheduleDetailModal();
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error('일정 정보를 가져오는데 실패했습니다:', error);
                alert('일정 정보를 불러올 수 없습니다.');
            }
        });
    }
    
    // 일정 상세 정보로 모달 채우기
    function fillScheduleDetailModal(schedule) {
        // 일정 제목 설정
        $('#scheduleTitle').text(schedule.scheduleTitle);
        
        // 중요도에 따른 뱃지 설정
        const importantBadge = $('#scheduleImportant');
        importantBadge.removeClass('low normal high');
        
        if (schedule.important === 'LOW') {
            importantBadge.addClass('low').text('낮음');
        } else if (schedule.important === 'HIGH') {
            importantBadge.addClass('high').text('높음');
        } else {
            importantBadge.addClass('normal').text('보통');
        }
        
        // 일정 기간 설정
        let dateText = formatDateRange(schedule.startDate, schedule.endDate, schedule.allDay);
        $('#scheduleDate').text(dateText);
        
        // 장소 설정
        if (schedule.location) {
            $('#scheduleLocation').text(schedule.location);
        } else {
            $('#scheduleLocation').html('<span class="schedule-detail-empty">지정된 장소가 없습니다.</span>');
        }
        
        // 일정 유형 설정
        const typeElem = $('#scheduleType');
        typeElem.empty();
        
        const typeSpan = $('<span>').addClass('schedule-detail-type');
        
        switch (schedule.scheduleType) {
            case 'PERSONAL':
                typeSpan.addClass('personal').text('개인');
                break;
            case 'TEAM':
                typeSpan.addClass('team').text('팀');
                break;
            case 'COMPANY':
                typeSpan.addClass('company').text('회사');
                break;
            default:
                typeSpan.addClass('other').text('기타');
                break;
        }
        
        typeElem.append(typeSpan);
        
        // 참석자 설정
        const attendeesContainer = $('#scheduleAttendees .schedule-detail-attendee-list');
        attendeesContainer.empty();
        
        if (schedule.attendees && schedule.attendees.length > 0) {
            $('#attendeesGroup').show();
            
            schedule.attendees.forEach(function(attendee) {
                const attendeeItem = $('<div>')
                    .addClass('schedule-detail-attendee-item')
                    .html(attendee.empName + ' <span style="font-size: 11px; opacity: 0.8;">' + attendee.deptName + '</span>');
                
                attendeesContainer.append(attendeeItem);
            });
        } else {
            $('#attendeesGroup').hide();
        }
        
        // 내용 설정
        if (schedule.description) {
            $('#scheduleDescription').text(schedule.description);
        } else {
            $('#scheduleDescription').html('<span class="schedule-detail-empty">내용이 없습니다.</span>');
        }
    }
    
    // 일정 상세 모달 닫기
    function closeScheduleDetailModal() {
        $('#scheduleDetailModal').removeClass('active');
        $(document).off('click'); // 외부 클릭 이벤트 제거
        currentScheduleId = null;
    }
    
    // 날짜 범위 포맷팅 함수
    function formatDateRange(startDate, endDate, isAllDay) {
        const start = new Date(startDate);
        const end = new Date(endDate);
        
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        let formattedStart = start.toLocaleDateString('ko-KR', options);
        let formattedEnd = end.toLocaleDateString('ko-KR', options);
        
        if (!isAllDay) {
            formattedStart += ' ' + start.toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });
            formattedEnd += ' ' + end.toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });
        }
        
        let result = formattedStart + ' ~ ' + formattedEnd;
        
        if (isAllDay) {
            result += ' (종일)';
        }
        
        return result;
    }
    
    // 일정 수정 페이지로 이동
    function editSchedule() {
        if (currentScheduleId) {
            location.href = 'updateForm.sc?no=' + currentScheduleId;
        }
    }
    
    // 일정 삭제 확인
    function confirmDeleteSchedule() {
        if (currentScheduleId && confirm('정말로 이 일정을 삭제하시겠습니까?')) {
            location.href = 'delete.sc?no=' + currentScheduleId;
        }
    }
</script>