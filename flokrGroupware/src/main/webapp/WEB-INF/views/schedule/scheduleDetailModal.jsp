<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="schedule-modal-content">
    <div class="schedule-modal-header">
        <h3>일정 상세</h3>
        <button type="button" class="schedule-modal-close" onclick="closeScheduleModal()">&times;</button>
    </div>
    
    <div class="schedule-modal-body">
        <div class="schedule-modal-info">
            <div class="schedule-modal-row">
                <label class="schedule-modal-label">제목</label>
                <div class="schedule-modal-value">
                    <c:choose>
                        <c:when test="${schedule.scheduleType eq 'PERSONAL'}">
                            <span class="schedule-badge personal">개인</span>
                        </c:when>
                        <c:when test="${schedule.scheduleType eq 'TEAM'}">
                            <span class="schedule-badge team">팀</span>
                        </c:when>
                        <c:when test="${schedule.scheduleType eq 'COMPANY'}">
                            <span class="schedule-badge company">회사</span>
                        </c:when>
                        <c:otherwise>
                            <span class="schedule-badge other">기타</span>
                        </c:otherwise>
                    </c:choose>
                    ${schedule.scheduleTitle}
                </div>
            </div>
            
            <div class="schedule-modal-row">
                <label class="schedule-modal-label">기간</label>
                <div class="schedule-modal-value">
                    <fmt:parseDate value="${schedule.startDate}" pattern="yyyy-MM-dd HH:mm:ss" var="startDate" />
                    <fmt:parseDate value="${schedule.endDate}" pattern="yyyy-MM-dd HH:mm:ss" var="endDate" />
                    <fmt:formatDate value="${startDate}" pattern="yyyy년 MM월 dd일 HH:mm" /> - 
                    <fmt:formatDate value="${endDate}" pattern="yyyy년 MM월 dd일 HH:mm" />
                </div>
            </div>
            
            <div class="schedule-modal-row">
                <label class="schedule-modal-label">장소</label>
                <div class="schedule-modal-value">${empty schedule.location ? '없음' : schedule.location}</div>
            </div>
            
            <div class="schedule-modal-row">
                <label class="schedule-modal-label">내용</label>
                <div class="schedule-modal-value schedule-modal-content-text">${schedule.scheduleContent}</div>
            </div>
            
            <c:if test="${not empty sa}">
                <div class="schedule-modal-row">
                    <label class="schedule-modal-label">참석자</label>
                    <div class="schedule-modal-value">
                        <c:forEach var="attendee" items="${sa}" varStatus="status">
                            ${attendee.empName}<c:if test="${!status.last}">, </c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
            
            <div class="schedule-modal-row">
                <label class="schedule-modal-label">작성자</label>
                <div class="schedule-modal-value">${schedule.empName}</div>
            </div>
            
            <div class="schedule-modal-row">
                <label class="schedule-modal-label">작성일</label>
                <div class="schedule-modal-value">
                    <fmt:formatDate value="${schedule.createDate}" pattern="yyyy년 MM월 dd일 HH:mm" />
                </div>
            </div>
        </div>
    </div>
    
    <div class="schedule-modal-footer">
        <c:if test="${loginUser.empNo eq schedule.empNo}">
            <button type="button" class="btn-edit" onclick="location.href='updateForm.sc?scheduleNo=${schedule.scheduleNo}'">수정</button>
            <button type="button" class="btn-delete" onclick="deleteScheduleModal(${schedule.scheduleNo})">삭제</button>
        </c:if>
        <button type="button" class="btn-close" onclick="closeScheduleModal()">닫기</button>
    </div>
</div>

<style>
    /* 모달 스타일 */
    #schedule-detail-modal {
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
    
    .schedule-modal-content {
        background-color: #fff;
        width: 500px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        margin: auto;
        position: relative;
    }
    
    .schedule-modal-header {
        padding: 15px 20px;
        border-bottom: 1px solid #e9e9e9;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .schedule-modal-header h3 {
        margin: 0;
        font-size: 18px;
        font-weight: 500;
        color: #333;
    }
    
    .schedule-modal-close {
        background: none;
        border: none;
        font-size: 20px;
        cursor: pointer;
        color: #777;
    }
    
    .schedule-modal-body {
        padding: 20px;
    }
    
    .schedule-modal-footer {
        padding: 15px 20px;
        border-top: 1px solid #e9e9e9;
        text-align: right;
        background-color: #f8f9fa;
    }
    
    .schedule-modal-row {
        margin-bottom: 15px;
    }
    
    .schedule-modal-label {
        display: block;
        font-size: 13px;
        color: #666;
        margin-bottom: 5px;
    }
    
    .schedule-modal-value {
        font-size: 14px;
        color: #333;
        line-height: 1.5;
    }
    
    .schedule-modal-content-text {
        white-space: pre-line;
        max-height: 150px;
        overflow-y: auto;
    }
    
    .schedule-badge {
        display: inline-block;
        padding: 2px 6px;
        border-radius: 3px;
        font-size: 12px;
        color: white;
        margin-right: 6px;
    }
    
    .schedule-badge.personal {
        background-color: #003561;
    }
    
    .schedule-badge.team {
        background-color: #27ae60;
    }
    
    .schedule-badge.company {
        background-color: #f39c12;
    }
    
    .schedule-badge.other {
        background-color: #8e44ad;
    }
    
    .btn-edit, .btn-delete, .btn-close {
        padding: 6px 14px;
        border-radius: 4px;
        font-size: 13px;
        cursor: pointer;
        margin-left: 8px;
        border: none;
    }
    
    .btn-edit {
        background-color: #003561;
        color: white;
    }
    
    .btn-delete {
        background-color: #e74c3c;
        color: white;
    }
    
    .btn-close {
        background-color: #e9e9e9;
        color: #333;
    }
</style>

<script>
    function closeScheduleModal() {
        document.getElementById('schedule-detail-modal').style.display = 'none';
    }
    
    function deleteScheduleModal(scheduleNo) {
        if (confirm('정말 이 일정을 삭제하시겠습니까?')) {
            $.ajax({
                url: 'deleteModal.sc',
                type: 'GET',
                data: { scheduleNo: scheduleNo },
                success: function(result) {
                    if(result === "success") {
                        alert('일정이 성공적으로 삭제되었습니다.');
                        closeScheduleModal();
                        // 캘린더 새로고침
                        location.reload();
                    } else {
                        alert('일정 삭제에 실패했습니다.');
                    }
                },
                error: function() {
                    alert('일정 삭제 중 오류가 발생했습니다.');
                }
            });
        }
    }
    
    // 모달 외부 클릭 시 닫기
    $(document).ready(function() {
        $('#schedule-detail-modal').click(function(e) {
            if ($(e.target).is('#schedule-detail-modal')) {
                closeScheduleModal();
            }
        });
    });
</script>