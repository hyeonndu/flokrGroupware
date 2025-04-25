<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flokr</title>
<%-- FullCalendar CSS --%>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/main.min.css' rel='stylesheet' />
<style>
    /* 기본 스타일 */
    body {
        background-color: #F8F9FAFF;
        margin: 0;
        font-family: sans-serif;
        display: flex;
        flex-direction: column;
        height: 100vh;
    }
    * {
        box-sizing: border-box;
    }

    .outer {
        display: flex;
        padding: 60px 20px; /* 내부 콘텐츠 여백 */
        gap: 20px;
        overflow: auto; /* 필요시 스크롤 */
        max-width: 1600px; /* 콘텐츠 영역 최대 너비 */
        width: 100%;
        margin-left: auto;  /* 중앙 정렬 */
        margin-right: auto; /* 중앙 정렬 */
        height: 750px; /* outer 높이 고정 (필요에 따라 조절) */
    }

    .section {
        padding: 20px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        overflow: hidden; /* 내부 요소 넘침 방지 */
    }

    /* 컬럼 레이아웃 */
    .s01 { /* 왼쪽 컬럼 */
        flex-basis: 35%;
        height: 100%;
        display: flex;
        flex-direction: column;
        gap: 20px;
    }
    .s02 { /* 가운데 컬럼 */
        flex-basis: 45%;
        height: 100%;
        display: flex;
        flex-direction: column;
        gap: 20px;
    }
    .s03 { /* 오른쪽 컬럼 */
        flex-basis: 20%;
        height: 100%;
        /* s03 .section 자체에 대한 추가 스타일은 아래 .section.s03 에서 정의 */
    }

    /* 섹션 내부 파트 레이아웃 */
    .part01 { flex-basis: 40%; min-height: 150px; display: flex; align-items: center; gap: 30px; }
    .part02 { flex-grow: 1; min-height: 200px; } /* 업무 목록이 남은 공간 차지 */
    .part03 { flex-basis: 65%; min-height: 300px; display: flex; flex-direction: column;} /* 달력이 높이 차지하도록 */
    .part04 { flex-grow: 1; min-height: 150px; } /* 공지사항이 남은 공간 차지 */

    /* --- 공통 요소 스타일 --- */
    .sub-title {
        font-weight: 600;
        font-size: 17px;
        color: #003561;
        padding-bottom: 5px;
    }

    /* --- 왼쪽 컬럼 (s01) 스타일 --- */
    /* 프로필 (#p01-profile) */
    #p01-profile { display: flex; flex-direction: column; align-items: center; text-align: center; flex-shrink: 0; width: 180px; }
    .profile-image-container { position: relative; width: 90px; height: 90px; margin-top: 5px; margin-bottom: 5px; }
    .profile-image { display: block; width: 100%; height: 100%; border-radius: 50%; object-fit: cover; border: 1px solid #eee; }
    .status-indicator { position: absolute; bottom: 5px; right: 5px; width: 18px; height: 18px; border-radius: 50%; background-color: #cccccc; border: 3px solid white; }
    .status-indicator.online { background-color: #28a745; }
    .profile-name { font-size: 1.1em; font-weight: bold; margin: 0 0 5px 0; }
    .profile-title { font-size: 13px; color: #6c757d; margin: 0 0 10px 0; }
    .profile-buttons { display: flex; gap: 8px; }
    .btn-small { padding: 4px 12px; font-size: 12px; font-weight: 700; border-radius: 15px; border: 1px solid #0d6efd; background-color: white; color: #0d6efd; cursor: pointer; transition: background-color 0.2s, color 0.2s; }
    .btn-small:hover { background-color: #e7f1ff; }
    .btn-small.active { background-color: #0d6efd; color: white; border-color: #0d6efd; }

    /* 출퇴근 정보 (#p01-onoffbtn) */
    #p01-onoffbtn { display: flex; flex-direction: column; flex-grow: 1; gap: 15px; }
    .current-date { text-align: right; font-size: 13px; color: #6c757d; margin: 0; }
    .time-info-box { display: flex; background-color: #f8f9fa; border-radius: 8px; padding: 20px 15px; }
    .time-section { flex: 1; text-align: center; padding: 0 10px; }
    .time-section + .time-section { border-left: 1px solid #dee2e6; }
    .time-label { display: block; font-size: 0.85em; color: #6c757d; margin-bottom: 8px; }
    .time-value { font-size: 16px; font-weight: bold; color: #212529; }
    .time-value.placeholder { color: #adb5bd; }
    .action-buttons { display: flex; gap: 10px; }
    .btn-large { flex-grow: 1; padding: 12px 15px; font-size: 1em; font-weight: bold; border-radius: 6px; border: 1px solid; cursor: pointer; transition: opacity 0.2s; }
    .btn-large:hover { opacity: 0.9; }
    .btn-checkin { background-color: #ffffff; color: #0d6efd; border-color: #dee2e6; }
    .btn-checkout { background-color: #0747a6; color: white; border-color: #0747a6; }

    /* --- 가운데 컬럼 (s02) 스타일 --- */
    /* 달력 (part03) */
    .section.part03 { padding: 20px; background-color: #fff; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* display: flex; flex-direction: column; */ /* Flex 설정 제거 또는 조정 - FullCalendar 높이 설정에 따라 */ }
    #main-calender { /* height: 100%; display: flex; flex-direction: column; */ /* Flex 설정 제거 또는 조정 */ }
    #calendar-container { /* margin-top: 15px; flex-grow: 1; min-height: 0; */ /* Flex 설정 제거 또는 조정 */ }

    /* FullCalendar 커스텀 스타일 */
    .fc-header-toolbar { margin-bottom: 1.5em !important; }
    .fc .fc-toolbar-title { font-weight: 600; font-size: 17px; color: #003561; padding-bottom: 5px; }
    .fc .fc-button { background-color: transparent !important; border: none !important; color: #adb5bd !important; box-shadow: none !important; padding: 0 5px !important; }
    .fc .fc-button .fc-icon { font-size: 1.5em; }
    .fc .fc-prev-button:hover, .fc .fc-next-button:hover { color: #6c757d !important; }
    .fc .fc-col-header-cell { background-color: #f8f9fa; border: none !important; padding: 10px 0; }
    .fc .fc-col-header-cell-cushion { color: #0d6efd; font-weight: bold; text-decoration: none !important; font-size: 0.9em; }
    .fc .fc-daygrid-day { border: none !important; text-align: center; }
    .fc .fc-daygrid-day-frame { min-height: 45px; /* 높이 약간 줄임 */ display: flex; justify-content: center; align-items: center; }
    .fc .fc-daygrid-day-number { color: #6c757d; text-decoration: none !important; padding: 5px; font-size: 0.9em; }
    .fc .fc-day-today .fc-daygrid-day-frame { background-color: rgba(230, 240, 255, 0.5); }
    .fc .fc-day-other .fc-daygrid-day-number { color: #ced4da; }
    .fc-scrollgrid { border: none !important; } /* 달력 외곽선 제거 */
    .fc-theme-standard td, .fc-theme-standard th { border: none !important; } /* 내부 선 추가 제거 */
    .fc-scrollgrid-section > * { border: none !important; } /* 내부 섹션 선 추가 제거 */


    /* 날짜 하이라이트 스타일 */
    .highlight-day-19 .fc-daygrid-day-frame { background-color: rgba(255, 192, 203, 0.5); border-radius: 50%; width: 35px; height: 35px; margin: auto; }
    .highlight-day-19 .fc-daygrid-day-number { font-weight: bold; color: #d1456b; }
    .highlight-range .fc-daygrid-day-frame { background-color: rgba(255, 235, 153, 0.6); border-radius: 20px; width: 100%; height: 35px; margin: auto; }
    .highlight-range.range-start .fc-daygrid-day-frame { border-top-right-radius: 0; border-bottom-right-radius: 0; }
    .highlight-range.range-end .fc-daygrid-day-frame { border-top-left-radius: 0; border-bottom-left-radius: 0; }
    .highlight-range.range-middle .fc-daygrid-day-frame { border-radius: 0; }
    .highlight-range .fc-daygrid-day-number { color: #856404; font-weight: bold; }


    /* --- 공통 테이블 리스트 스타일 (업무목록, 공지사항, 팀원주소록) --- */
    #work-list table, #notice-list table, #work-address table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
         /* 테이블 자체 그림자 제거 (섹션 그림자로 대체) */
        /* box-shadow: 0 2px 5px rgba(0,0,0,0.1); */
        /* 테이블 배경색/반경 제거 (섹션 배경 사용) */
        /* background-color: #f8f9fa; */
        /* border-radius: 8px; */
        /* overflow: hidden; */
    }

    #work-list th, #notice-list th, #work-address th,
    #work-list td, #notice-list td, #work-address td {
        padding: 10px 8px; /* 패딩 약간 조정 */
        text-align: left;
        border-bottom: 1px solid #eee; /* 구분선 연하게 */
        font-size: 13px; /* 기본 폰트 크기 통일 */
        vertical-align: middle; /* 세로 중앙 정렬 */
    }
     /* 마지막 행 구분선 제거 */
    #work-list tr:last-child td,
    #notice-list tr:last-child td,
    #work-address tr:last-child td {
        border-bottom: none;
    }


    #work-list th, #notice-list th, #work-address th {
        background-color: #f8f9fa; /* 헤더 배경색 */
        font-size: 11px;
        color: #888;
        font-weight: 600; /* 헤더 약간 두껍게 */
        text-transform: uppercase;
        border-bottom-width: 1px; /* 헤더 아래 구분선 두께 */
        border-bottom-color: #dee2e6; /* 헤더 아래 구분선 색상 */
    }

    /* 업무 목록 체크박스 */
    #work-list input[type="checkbox"] {
        vertical-align: middle;
    }

    /* 업무 목록 상태 라벨 */
    .status { display: inline-block; padding: 4px 8px; border-radius: 4px; font-size: 0.8em; font-weight: 600; color: #333; }
    .status-inprogress { background-color: #fff3cd; border: 1px solid #ffeeba; }
    .status-completed { background-color: #d4edda; border: 1px solid #c3e6cb; }
    .status-pending { background-color: #f8d7da; border: 1px solid #f5c6cb; }
    .status-rejected { background-color: #e2e3e5; border: 1px solid #d6d8db; }


    /* --- 오른쪽 컬럼 (s03) & 팀원 주소록 상세 스타일 --- */
    .section.s03 {
        /* s03 섹션 자체 스타일 필요한 경우 여기에 추가 */
    }

    #work-address {
       /* 이전에 ul/li 기반 스타일 있었다면 제거 */
    }

     /* 팀원 주소록 테이블 컬럼 정렬 및 너비 조정 */
    #work-address th:nth-child(1), /* 이름 */
    #work-address td:nth-child(1) {
        text-align: left;
    }
     #work-address th:nth-child(2), /* 등급 */
    #work-address td:nth-child(2) {
        text-align: center;
    }
     #work-address th:nth-child(3), /* 체크 */
    #work-address td:nth-child(3) {
        text-align: center;
    }
     #work-address th:nth-child(4), /* 옵션 */
    #work-address td:nth-child(4) {
        text-align: right;
    }


    /* 주소록 이름 + 이미지 셀 내부 정렬 */
    #work-address td:nth-child(1) .addr-name-cell {
        display: flex;
        align-items: center;
        gap: 10px; /* 이미지와 텍스트 간격 */
    }

    /* 주소록 프로필 이미지 */
    .addr-profile-img {
        width: 32px; /* 이미지 크기 조정 */
        height: 32px;
        border-radius: 50%;
        object-fit: cover;
        flex-shrink: 0;
    }

    /* 주소록 이름/부제목 텍스트 컨테이너 */
    .addr-text {
        display: flex;
        flex-direction: column;
        min-width: 0; /* 줄바꿈/말줄임표 위해 */
    }
    .addr-name {
        font-weight: 600;
        font-size: 13px; /* 폰트 크기 통일 */
        color: #333;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .addr-subtitle {
        font-size: 11px; /* 부제목 크기 */
        color: #888;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    /* 주소록 등급 라벨 */
    .addr-grade-label {
        display: inline-block;
        padding: 3px 10px;
        background-color: #e7f1ff;
        color: #0d6efd;
        border-radius: 15px;
        font-size: 11px;
        font-weight: 600;
    }

    /* 주소록 체크 아이콘 */
    .addr-check-icon {
        display: inline-block;
        width: 18px;
        height: 18px;
        border-radius: 4px;
        border: 1.5px solid #adb5bd;
        background-color: white;
        position: relative;
        vertical-align: middle;
    }
    .addr-check-icon.check-filled {
        background-color: #0d6efd;
        border-color: #0d6efd;
    }
    .addr-check-icon.check-filled::after {
        content: '';
        position: absolute;
        left: 5px;
        top: 1px;
        width: 5px;
        height: 10px;
        border: solid white;
        border-width: 0 2px 2px 0;
        transform: rotate(45deg);
    }

    /* 주소록 옵션 아이콘 */
    .addr-options-icon {
        font-size: 1.2em;
        color: #adb5bd;
        cursor: pointer;
        vertical-align: middle;
    }
    .addr-options-icon:hover {
        color: #6c757d;
    }

</style>
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
                        <th>CHECK</th>
                        <th></th> <%-- 옵션 헤더 --%>
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
                        <td><input type="checkbox"></td>
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
                        <td><input type="checkbox"></td>
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
                        <td><input type="checkbox"></td>
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