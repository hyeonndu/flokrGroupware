<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flokr</title>
<%-- FullCalendar CSS --%>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/main.min.css' rel='stylesheet' />
<!-- main CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<!-- Material Icons 추가 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"rel="stylesheet">
</head>
<body>

    <jsp:include page="common/header.jsp"/>

    <div class="outer">
        <%-- 왼쪽 컬럼 --%>
        <div class="s01">
            <div class="section part01">
                <div id="p01-profile">
                    <div class="profile-image-container">
                        <img src="placeholder-profile.png" alt="프로필 사진" class="profile-image"> <%-- 실제 이미지 경로 필요 --%>
                        <span class="status-indicator online"></span>
                    </div>
                    <p class="profile-name">Full name</p> <%-- 실제 이름 필요 --%>
                    <p class="profile-title">Professional title</p> <%-- 실제 직책 필요 --%>
                    <div class="profile-buttons">
                        <button class="btn-small btn-home">HOME</button>
                        <button class="btn-small btn-office active">OFFICE</button>
                    </div>
                </div>
                <div id="p01-onoffbtn">
                    <p class="current-date">2025년 05월 19일</p> <%-- 실제 날짜 필요 --%>
                    <div class="time-info-box">
                        <div class="time-section">
                            <span class="time-label">출근 시간</span>
                            <span class="time-value">08 : 52</span> <%-- 실제 시간 필요 --%>
                        </div>
                        <div class="time-section">
                            <span class="time-label">퇴근 시간</span>
                            <span class="time-value placeholder">-- : --</span> <%-- 실제 시간 필요 --%>
                        </div>
                    </div>
                    <div class="action-buttons">
                        <button class="btn-large btn-checkin">출근</button>
                        <button class="btn-large btn-checkout">퇴근</button>
                    </div>
                </div>
            </div>
            <div class="section part02">
                <div class="sub-title">업무 목록</div>
                <div id="work-list">
                    <table>
                        <thead>
                            <tr>
                                <th></th>
                                <th>TASK NAME</th>
                                <th>REQUEST DATE</th>
                                <th>DEADLINE</th>
                                <th>STATUS</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- 업무 목록 데이터 (예시) --%>
                            <tr>
                                <td><input type="checkbox"></td>
                                <td>업무목록 입니다.</td>
                                <td>07/12/2023</td>
                                <td>07/12/2023</td>
                                <td><span class="status status-inprogress">진행중</span></td>
                            </tr>
                            <tr>
                                <td><input type="checkbox"></td>
                                <td>업무목록 입니다.</td>
                                <td>05/12/2023</td>
                                <td>05/12/2023</td>
                                <td><span class="status status-inprogress">진행중</span></td>
                            </tr>
                            <tr>
                                <td><input type="checkbox"></td>
                                <td>업무목록 입니다.</td>
                                <td>11/12/2023</td>
                                <td>11/12/2023</td>
                                <td><span class="status status-completed">완료</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%-- 가운데 컬럼 --%>
        <div class="s02">
            <div class="section part03">
                <%-- 달력 제목은 FullCalendar에서 생성 --%>
                <div id="main-calender">
                    <div id="calendar-container"></div>
                </div>
            </div>
            <div class="section part04">
                <div class="sub-title">회사 공지</div>
                <div id="notice-list">
                     <table>
                        <thead>
                            <tr>
                                <th width="60%">TITLE</th> <%-- 제목 컬럼명 수정 --%>
                                <th width="20%">WRITER</th>
                                <th width="20%">DATE</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- 공지사항 데이터 (예시) --%>
                            <tr>
                                <td>새로운 그룹웨어 사용 안내</td>
                                <td>관리자</td>
                                <td>04/25/2025</td>
                            </tr>
                            <tr>
                                <td>정기 서버 점검 안내 (5/1)</td>
                                <td>관리자</td>
                                <td>04/24/2025</td>
                            </tr>
                             <tr>
                                <td>[필독] 보안 강화 관련 협조 요청</td>
                                <td>관리자</td>
                                <td>04/23/2025</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%-- 오른쪽 컬럼 (팀원 주소록) --%>
        <div class="section s03">
            <div class="sub-title">팀원 주소록</div>
            <div id="work-address">
                <table>
                    <colgroup> <%-- 컬럼 너비 정의 --%>
                       <col style="width: auto;">  <%-- 이름/이미지 --%>
                       <col style="width: 70px;">  <%-- 등급 (Label) --%>
                       <col style="width: 50px;">  <%-- 체크 --%>
                       <col style="width: 30px;">  <%-- 옵션 --%>
                    </colgroup>
                    <thead>
                      <tr>
                        <th>NAME</th>
                        <th>GRADE</th>
                        <th>CHAT</th>
                        <th></th>
                      </tr>
                    </thead>
                    <tbody>
                      <%-- Pedro --%>
                      <tr>
                        <td>
                          <div class="addr-name-cell"> <%-- 셀 내부 Flex 컨테이너 --%>
                            <img src="" alt="팀원" class="addr-profile-img">
                            <div class="addr-text">
                              <span class="addr-name">Pedro</span>
                              <span class="addr-subtitle">Developer</span> <%-- 직책 예시 --%>
                            </div>
                          </div>
                        </td>
                        <td><span class="addr-grade-label">팀원</span></td> <%-- 등급 예시 --%>
                        <td><span class="material-icons" style="font-size: 20px;">sms</span></td>
                        <td><span class="addr-options-icon">⋮</span></td>
                      </tr>
                      <%-- Ryan --%>
                      <tr>
                         <td>
                          <div class="addr-name-cell">
                            <img src="https://via.placeholder.com/32/33FF57/FFFFFF?text=R" alt="Ryan profile" class="addr-profile-img">
                            <div class="addr-text">
                              <span class="addr-name">Ryan</span>
                              <span class="addr-subtitle">Designer</span> <%-- 직책 예시 --%>
                            </div>
                          </div>
                        </td>
                        <td><span class="addr-grade-label">팀원</span></td> <%-- 등급 예시 --%>
                        <td><span class="material-icons" style="font-size: 20px;">sms</span></td>
                        <td><span class="addr-options-icon">⋮</span></td>
                      </tr>
                      <%-- Brian --%>
                       <tr>
                         <td>
                          <div class="addr-name-cell">
                            <img src="https://via.placeholder.com/32/3357FF/FFFFFF?text=B" alt="Brian profile" class="addr-profile-img">
                            <div class="addr-text">
                              <span class="addr-name">Brian</span>
                              <span class="addr-subtitle">Manager</span> <%-- 직책 예시 --%>
                            </div>
                          </div>
                        </td>
                        <td><span class="addr-grade-label">팀장</span></td> <%-- 등급 예시 --%>
                        <td><span class="material-icons" style="font-size: 20px;">sms</span></td>
                        <td><span class="addr-options-icon">⋮</span></td>
                      </tr>
                    </tbody>
                  </table>
            </div>
        </div>
    </div>

    <%-- FullCalendar JS --%>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>
    <script>
        // 달력 초기화 스크립트
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar-container');
            if (!calendarEl) { console.error("달력 컨테이너 없음"); return; }
            if (typeof FullCalendar === 'undefined') { console.error("FullCalendar 라이브러리 로드 안됨"); return; }

            try {
                var calendar = new FullCalendar.Calendar(calendarEl, {
                    initialView: 'dayGridMonth',
                    initialDate: '2025-05-01', // 오늘 날짜나 특정 날짜로 설정 가능
                    firstDay: 1,
                    headerToolbar: { left: 'title', center: '', right: 'prev,next' },
                    dayHeaderFormat: { weekday: 'short' },
                    // height: '100%', // 부모 높이에 맞춤 (CSS 설정과 연관됨)
                    height: 'auto', // 또는 내용에 맞춤
                    dayCellDidMount: function(info) {
                        // 19일 하이라이트 예시
                        if (info.date.getFullYear() === 2025 && info.date.getMonth() === 4 && info.date.getDate() === 19) {
                            info.el.classList.add('highlight-day-19');
                        }
                        // 13-18일 범위 하이라이트 예시
                        const day = info.date.getDate(); const month = info.date.getMonth(); const year = info.date.getFullYear();
                        if (year === 2025 && month === 4 && day >= 13 && day <= 18) {
                            info.el.classList.add('highlight-range');
                            if (day === 13) info.el.classList.add('range-start');
                            if (day === 18) info.el.classList.add('range-end');
                            if (day > 13 && day < 18) info.el.classList.add('range-middle');
                        }
                    },
                });
                calendar.render();
            } catch (error) {
                console.error("FullCalendar 실행 중 오류:", error);
            }
        });
    </script>

</body>
</html>