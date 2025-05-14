<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form id="insert-task-form" action="${pageContext.request.contextPath}/task/insert" method="post" enctype="multipart/form-data">
<input type="hidden" name="taskWriter" value="${ loginUser.empNo }" />
  <div class="insert-wrapper">
    <!-- 상단 헤더 -->
    <div class="insert-header">
      <div class="insert-title-left">
        <button type="button" class="emoji-btn">
        	<span class="material-icons">
				add_circle_outline
			</span>
        </button>
        <input type="hidden" name="emoji" id="selectedEmoji" value=""/>
        <input type="text" name="taskTitle" class="insert-title-input" placeholder="제목을 입력하세요" required/>
      </div>
      <div class="insert-header-actions">
        <button type="button" class="close-btn" onclick="backToList()">✕</button>
      </div>
    </div>

    <!-- 본문 -->
    <div class="insert-body">
      <!-- 왼쪽 업무 내용 -->
      <div class="insert-left-pane">
        <div class="insert-rowLeft">
          <label>업무 내용</label>
          <textarea name="taskContent" class="insert-content-box" placeholder="업무 내용을 입력하세요" required></textarea>
        </div>

        <div class="insert-rowLeft">
          <label>첨부파일</label>
          <div class="insert-attachment-box">
            <input type="file" name="uploadFile"/>
          </div>
        </div>
      </div>

      <!-- 오른쪽 정보 영역 -->
      <div class="insert-right-pane">
        <div class="insert-rowRight">
          <label>카테고리</label>
          <select name="category" class="insert-dropdown">
            <option value="">선택하세요</option>
            <option value="디자인">디자인</option>
            <option value="데이터">데이터</option>
            <option value="개발">개발</option>
            <option value="기획">기획</option>
          </select>
        </div>

        <div class="insert-rowRight">
          <label>마감일</label>
          <input type="date" name="dueDate" class="insert-date-input" required/>
        </div>

        <div class="insert-rowRight">
          <label>담당자</label>
          <div class="assignees">
            <div class="avatar">👤</div>
            <div class="avatar red">👩</div>
            <div class="avatar gray">A</div>
            <div class="avatar empty">+3</div>
          </div>
        </div>

        <div class="insert-btn-group">
          <button type="button" class="gray-btn" onclick="resetInsertForm()">초기화</button>
          <button type="submit" class="red-btn">등록</button>
        </div>
      </div>

    </div>
  </div>

</form>
