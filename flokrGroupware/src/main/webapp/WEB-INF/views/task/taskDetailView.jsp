<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="detail-wrapper">
  <!-- 상단 헤더 -->
  <div class="detail-header">
    <div class="title-left">
      <span class="emoji">🎨</span>
      <h2>화면 설계</h2>
    </div>
    <div class="header-actions">
      <button class="refresh-btn">⟳</button>
      <button class="close-btn" onclick="backToList()">✕</button>
    </div>
  </div>

  <!-- 본문 -->
  <div class="detail-body">
    <!-- 왼쪽 업무 내용 -->
	<div class="left-pane">
	  <div class="rowLeft">
	    <label>업무 내용</label>
	    <div class="content-box">- 사이트맵 만들기  
	      - 페이지 테마색 정하기  
	      - 메인 페이지 화면설계  
	      - 피그마 틀로 보고서 작성 (핵심 화면 캡처 포함)  
	      - 길어지면  
	      - 어떻게  
	      - 되는지  
	      - 테스트입니다  
	      - 우와  
	      - 스크롤뜨나  
	      - 집가고싶다
	      - ㅇㅇㅇㅇㅇ
	      - ㅋㅋㅋㅋ
	      - ㄹㄹㄹㄹㄹ
	      - ㅇㄹㄴㅇㄹ
	      - ㅇㄴㄹㄴㅇㄹㄴㅇ</div>
	  </div>
	
	  <div class="rowLeft">
	    <label>첨부파일</label>
	    <div class="attachment-box">
	      <input type="file" />
	    </div>
	  </div>
	</div>


    <!-- 오른쪽 정보 영역 -->
    <div class="right-pane">
      <div class="rowRight">
        <label>카테고리</label>
        <select class="dropdown" disabled>
          <option selected>디자인</option>
        </select>
      </div>

      <div class="rowRight">
        <label>상태</label>
        <div class="status-tags">
          <span class="tag 요청">요청</span>
          <span class="tag 진행중">진행 중</span>
          <span class="tag 피드백">피드백</span>
          <span class="tag 보류">보류</span>
          <span class="tag 완료">완료</span>
        </div>
      </div>

      <div class="rowRight">
        <label>마감일</label>
        <input type="date" value="2025-04-18" disabled class="date-input" />
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
