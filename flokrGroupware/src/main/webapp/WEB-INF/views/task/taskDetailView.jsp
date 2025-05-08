<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="detail-wrapper">
  <!-- 상단 헤더 -->
  <div class="detail-header">
    <div class="title-left">
      <span class="emoji">${ task.emoji }</span>
      <h2>${ task.taskTitle }</h2>
    </div>
    <div class="header-actions">
      <button class="refresh-btn" onclick="toggleOptions(event)">
      	<span class="material-icons">
			more_horiz
		</span>
      </button>
      
      <div class="dropdown-options" id="actionMenu" style="display: none;">
	    <ul>
	      <li onclick="editTask('${task.taskNo}')">수정하기</li>
	      <li onclick="deleteTask('${task.taskNo}')">삭제하기</li>
	    </ul>
	  </div>
      
      <button class="close-btn" onclick="backToList()">
		<span class="material-icons">
			close
		</span>
      </button>
    </div>
  </div>

  <!-- 본문 -->
  <div class="detail-body">
    <!-- 왼쪽 업무 내용 -->
	<div class="left-pane">
	  <div class="rowLeft">
	    <label>업무 내용</label>
	    <div class="content-box">${ task.taskContent }</div>
	  </div>
	
	<div class="rowLeft">
	  <label>첨부파일</label>
	  <div class="attachment-box">
	    <c:if test="${not empty atmt}">
	      <a href="${pageContext.request.contextPath}/${atmt.storedFilepath}" 
	         download="${atmt.originalFilename}" 
	         class="file-link">
	         📎 ${atmt.originalFilename}
	      </a>
	    </c:if>
	    <c:if test="${empty atmt}">
	      <span class="no-file">첨부된 파일이 없습니다</span>
	    </c:if>
	  </div>
	</div>

	</div>


    <!-- 오른쪽 정보 영역 -->
    <div class="right-pane">
      <div class="rowRight">
        <label>카테고리</label>
        <select class="dropdown" disabled>
          <option selected>${ task.category }</option>
        </select>
      </div>

      <div class="rowRight">
        <label>상태</label>
        <div class="status-tags">
		  <span class="tag 요청 ${statusKor eq '요청' ? 'active' : ''}">요청</span>
		  <span class="tag 진행중 ${statusKor eq '진행중' ? 'active' : ''}">진행 중</span>
		  <span class="tag 피드백 ${statusKor eq '피드백' ? 'active' : ''}">피드백</span>
		  <span class="tag 보류 ${statusKor eq '보류' ? 'active' : ''}">보류</span>
		  <span class="tag 완료 ${statusKor eq '완료' ? 'active' : ''}">완료</span>
		</div>
      </div>

      <div class="rowRight">
        <label>마감일</label>
        <input type="date" value="${ task.dueDate }" disabled class="date-input" />
      </div>

      <div class="rowRight">
        <label>담당자</label>
        <div class="assignees">
          <div class="avatar">👤</div>
          <div class="avatar red">👩</div>
          <div class="avatar gray">A</div>
          <div class="avatar empty">+3</div>
        </div>
      </div>
    </div>
  </div>


</div>
