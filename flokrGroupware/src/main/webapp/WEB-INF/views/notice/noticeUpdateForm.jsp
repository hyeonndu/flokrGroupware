<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>공지사항 수정</title>
  <!-- jQuery 라이브러리 -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <!-- Font Awesome CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <!-- Alertify -->
  <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
  <style>
    .notice-container {
      max-width: 1280px;
      margin: 0 auto;
      padding: 2rem 1.5rem;
    }
    
    .notice-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1.5rem;
    }
    
    .notice-title h1 {
      font-size: 1.75rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
    }
    
    .notice-title p {
      color: #64748b;
      font-size: 0.95rem;
    }
    
    .btn {
      padding: 0.5rem 1rem;
      border-radius: 4px;
      font-size: 0.95rem;
      cursor: pointer;
      transition: all 0.2s;
      border: none;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      justify-content: center;
    }
    
    .btn-primary {
      background-color: #003561;
      color: white;
    }
    
    .btn-primary:hover {
      background-color: #002a4c;
    }
    
    .btn-secondary {
      background-color: #e2e8f0;
      color: #333;
    }
    
    .btn-secondary:hover {
      background-color: #cbd5e1;
    }
    
    .btn i {
      margin-right: 0.25rem;
    }
    
    /* 공지사항 폼 */
    .notice-form {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
      padding: 1.5rem;
      margin-bottom: 1.5rem;
    }
    
    .form-group {
      margin-bottom: 1.5rem;
    }
    
    .form-label {
      display: block;
      margin-bottom: 0.5rem;
      font-weight: 600;
      font-size: 0.95rem;
    }
    
    .form-control {
      width: 100%;
      padding: 0.75rem 1rem;
      border: 1px solid #e2e8f0;
      border-radius: 4px;
      font-size: 0.95rem;
      outline: none;
      transition: border-color 0.2s;
    }
    
    .form-control:focus {
      border-color: #003561;
    }
    
    .form-select {
      width: 100%;
      padding: 0.75rem 1rem;
      border: 1px solid #e2e8f0;
      border-radius: 4px;
      font-size: 0.95rem;
      outline: none;
    }
    
    textarea.form-control {
      min-height: 300px;
      resize: vertical;
    }
    
    .form-check {
      display: flex;
      align-items: center;
      margin-bottom: 0.5rem;
    }
    
    .form-check-input {
      margin-right: 0.5rem;
      width: 1rem;
      height: 1rem;
    }
    
    .form-actions {
      display: flex;
      justify-content: flex-end;
      gap: 0.5rem;
      margin-top: 1.5rem;
    }
    
    /* 경고 텍스트 */
    .form-text {
      font-size: 0.85rem;
      color: #64748b;
      margin-top: 0.5rem;
    }
    
    .text-danger {
      color: #ef4444;
    }
  </style>
</head>
<body>
  <jsp:include page="../common/header.jsp"/>
  
  <main class="notice-container">
    <div class="notice-header">
      <div class="notice-title">
        <h1>공지사항 수정</h1>
        <p>공지사항 내용을 수정하세요.</p>
      </div>
    </div>
    
    <form id="noticeForm" action="${pageContext.request.contextPath}/noticeUpdate" method="post">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      
      <div class="notice-form">
        <!-- 제목 -->
        <div class="form-group">
          <label for="noticeTitle" class="form-label">제목</label>
          <input type="text" class="form-control" id="noticeTitle" name="noticeTitle" placeholder="공지사항 제목을 입력하세요" value="${notice.noticeTitle}" required>
        </div>
        
        <!-- 분류 -->
        <div class="form-group">
          <label for="category" class="form-label">분류</label>
          <select class="form-select" id="category" name="category" required>
            <option value="">선택하세요</option>
            <option value="GENERAL" ${notice.category eq 'GENERAL' ? 'selected' : ''}>일반</option>
            <option value="EVENT" ${notice.category eq 'EVENT' ? 'selected' : ''}>행사</option>
            <option value="SYSTEM" ${notice.category eq 'SYSTEM' ? 'selected' : ''}>시스템</option>
            <option value="HR" ${notice.category eq 'HR' ? 'selected' : ''}>인사</option>
          </select>
        </div>
        
        <!-- 필독 여부 -->
        <div class="form-group">
          <div class="form-check">
            <input type="checkbox" class="form-check-input" id="isMandatory" name="isMandatory" value="1" ${notice.isMandatory eq 1 ? 'checked' : ''}>
            <label for="isMandatory" class="form-check-label">필독 공지로 설정</label>
          </div>
          <p class="form-text">필독 공지는 항상 상단에 표시되며 강조됩니다.</p>
        </div>
        
        <!-- 내용 -->
        <div class="form-group">
          <label for="noticeContent" class="form-label">내용</label>
          <textarea class="form-control" id="noticeContent" name="noticeContent" placeholder="공지사항 내용을 입력하세요" required>${notice.noticeContent}</textarea>
        </div>
        
        <!-- 알림 발송 여부 -->
        <div class="form-group">
          <div class="form-check">
            <input type="checkbox" class="form-check-input" id="sendNotification" name="sendNotification" value="true">
            <label for="sendNotification" class="form-check-label">전체 직원에게 알림 발송</label>
          </div>
          <p class="form-text">체크하면 공지사항 수정 시 모든 직원에게 알림이 전송됩니다.</p>
        </div>
      </div>
      
      <!-- 버튼 -->
      <div class="form-actions">
        <a href="${pageContext.request.contextPath}/noticeDetail/${notice.noticeNo}" class="btn btn-secondary">
          <i class="fas fa-times"></i> 취소
        </a>
        <button type="submit" class="btn btn-primary" id="submitBtn">
          <i class="fas fa-check"></i> 수정하기
        </button>
      </div>
    </form>
  </main>
  
  <script>
    $(document).ready(function() {
      // 폼 제출 전 유효성 검사
      $('#noticeForm').submit(function(event) {
        // 제목 검사
        const title = $('#noticeTitle').val().trim();
        if (!title) {
          alertify.error('제목을 입력해주세요.');
          $('#noticeTitle').focus();
          event.preventDefault();
          return false;
        }
        
        // 분류 검사
        const category = $('#category').val();
        if (!category) {
          alertify.error('분류를 선택해주세요.');
          $('#category').focus();
          event.preventDefault();
          return false;
        }
        
        // 내용 검사
        const content = $('#noticeContent').val().trim();
        if (!content) {
          alertify.error('내용을 입력해주세요.');
          $('#noticeContent').focus();
          event.preventDefault();
          return false;
        }
        
        // 필독 체크박스 값 처리
        if (!$('#isMandatory').is(':checked')) {
          // 체크 해제 시 hidden 필드로 0 값 전송
          $('<input>').attr({
            type: 'hidden',
            name: 'isMandatory',
            value: '0'
          }).appendTo('#noticeForm');
        }
        
        // 제출 버튼 비활성화 (중복 제출 방지)
        $('#submitBtn').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> 처리중...');
        
        return true;
      });
    });
  </script>
</body>
</html>