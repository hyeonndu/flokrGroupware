<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 등록</title>
<style>
    .form-container {
        max-width: 800px;
        margin: 30px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 6px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    
    .form-title {
        font-size: 24px;
        font-weight: 600;
        color: #003561;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 1px solid #eee;
    }
    
    .form-group {
        margin-bottom: 15px;
    }
    
    .form-label {
        display: block;
        font-weight: 500;
        margin-bottom: 5px;
        color: #333;
    }
    
    .form-input {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
    }
    
    .form-select {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
    }
    
    .form-row {
        display: flex;
        margin-left: -10px;
        margin-right: -10px;
    }
    
    .form-col {
        padding-left: 10px;
        padding-right: 10px;
        flex: 1;
    }
    
    .btn-primary {
        background-color: #003561;
        color: white;
        border: none;
        border-radius: 4px;
        padding: 10px 16px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.2s;
    }
    
    .btn-primary:hover {
        background-color: #002b4e;
    }
    
    .btn-container {
        margin-top: 20px;
        text-align: right;
    }
</style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    
    <div class="form-container">
        <h2 class="form-title">사원 등록</h2>
        
        <form action="insert" method="post">
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label class="form-label">이름</label>
                        <input type="text" name="empName" class="form-input" required>
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label class="form-label">아이디 (사번)</label>
                        <input type="text" name="empId" class="form-input" required>
                    </div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label class="form-label">비밀번호</label>
                        <input type="password" name="passwordHash" class="form-input" required>
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label class="form-label">이메일</label>
                        <input type="email" name="email" class="form-input" required>
                    </div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label class="form-label">전화번호</label>
                        <input type="tel" name="phone" class="form-input" placeholder="예: 010-1234-5678">
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label class="form-label">입사일</label>
                        <input type="date" name="hireDate" class="form-input" required>
                    </div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-col">
                    <div class="form-group">
                        <label class="form-label">부서</label>
                        <select name="deptNo" class="form-select" required>
                            <option value="">부서 선택</option>
                            <c:forEach var="dept" items="${deptList}">
                                <option value="${dept.deptNo}">${dept.deptName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-col">
                    <div class="form-group">
                        <label class="form-label">직급</label>
                        <select name="positionNo" class="form-select" required>
                            <option value="">직급 선택</option>
                            <c:forEach var="position" items="${positionList}">
                                <option value="${position.positionNo}">${position.positionName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label class="form-label">근무지</label>
                <input type="text" name="workLocation" class="form-input" placeholder="예: 서울본사">
            </div>
            
            <!-- 관리자 여부 필드 제거됨 -->
            <input type="hidden" name="isAdmin" value="N">
            
            <div class="btn-container">
                <button type="submit" class="btn-primary">등록하기</button>
            </div>
        </form>
    </div>
</body>
</html>