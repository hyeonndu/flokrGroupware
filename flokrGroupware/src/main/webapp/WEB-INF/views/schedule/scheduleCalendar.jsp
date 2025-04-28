<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Flokr - 일정관리</title>
    
    <!-- FullCalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css" rel="stylesheet">
    
    <style>
        /* 전체 레이아웃 */
        .calendar-wrapper {
            background-color: #f5f6f8;
            margin-top: 0;
        }
        
        /* body 태그의 마진 제거 */
		body {
		    margin: 0;
		    padding: 0;
		}
        
        .calendar-content-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }
        
        /* 캘린더 상단 컨트롤 영역 */
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .calendar-title {
            display: flex;
            align-items: center;
            font-size: 24px;
            font-weight: 500;
            color: #333;
        }
        
        .calendar-navigation {
            display: flex;
            align-items: center;
        }
        
        .calendar-nav-button {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 20px;
            color: #555;
            padding: 0 10px;
        }
        
        .calendar-today-button {
            background-color: #f0f2f5;
            border: none;
            border-radius: 4px;
            padding: 6px 12px;
            font-size: 14px;
            margin: 0 10px;
            cursor: pointer;
        }
        
        .calendar-view-controls {
            display: flex;
            margin-left: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
        }
        
        .calendar-view-button {
            background-color: #fff;
            border: none;
            padding: 6px 12px;
            font-size: 14px;
            cursor: pointer;
        }
        
        .calendar-view-button.active {
            background-color: #003561;
            color: #fff;
        }
        
        /* 캘린더 메인 영역 */
        .calendar-main-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        #calendar-main {
            width: 100%;
            min-height: 700px;
        }
        
        /* FullCalendar 커스텀 스타일 */
        .fc-theme-standard th {
            padding: 10px 0;
            font-weight: 500;
            font-size: 14px;
            text-align: center;
        }
        
        .fc-col-header-cell-cushion {
            color: #333;
            text-decoration: none !important;
            width: 100%;
            display: inline-block;
            text-align: center;
        }
        
        .fc-day-sun .fc-col-header-cell-cushion {
            color: #ff3b30;
        }
        
        .fc-day-sat .fc-col-header-cell-cushion {
            color: #003561;
        }
        
        /* 날짜 번호 스타일 및 위치 조정 */
        .fc-daygrid-day-number {
            display: inline-block;
            padding: 3px 0;
            color: #333;
            text-decoration: none !important;
            width: 100%;
            text-align: left;
            padding-left: 10px;
            margin-top: 5px;
        }
        
        .fc-day-sun .fc-daygrid-day-number {
            color: #ff3b30;
        }
        
        .fc-day-sat .fc-daygrid-day-number {
            color: #003561;
        }
        
        .fc-theme-standard td, .fc-theme-standard th {
            border: 1px solid #e9e9e9;
        }
        
        .fc .fc-daygrid-day-top {
            justify-content: flex-start;
            flex-direction: row;
        }
        
        /* 이벤트 스타일 */
        .fc-event {
            border: none;
            border-radius: 0;
            padding: 3px 5px;
            margin-bottom: 2px;
            font-size: 12px;
            margin-left: 4px;
            font-weight: normal;
        }
        
        /* 일정 유형별 스타일 */
		.calendar-personal-event {
		    background-color: #dbeafe !important;
		    color: #003561 !important;
		    border-left: 3px solid #003561 !important;
		}
		
		.calendar-team-event {
		    background-color: #d1fae5;
		    color: #27ae60 !important;
		    border-left: 3px solid #27ae60;
		}
		
		.calendar-company-event {
		    background-color: #ffedd5;
		    color: #f39c12 !important;
		    border-left: 3px solid #f39c12;
		}
		
		.calendar-other-event {
		    background-color: #ede9fe  !important;
		    color: #8e44ad !important; /* 보라색 */
		    border-left: 3px solid #8e44ad !important;
		}
		
		/* 중요도 배지 (일정 제목 옆에 작은 원형 또는 알약 모양) */
		.importance-high {
		    background-color: #e74c3c;
		    color: white;
		    padding: 2px 6px;
		    border-radius: 10px;
		    font-size: 0.7em;
		    margin-left: 5px;
		}
		
		.importance-medium {
		    background-color: #27ae60; /* 녹색 */
		    color: white;
		    padding: 2px 6px;
		    border-radius: 10px;
		    font-size: 0.7em;
		    margin-left: 5px;
		}
		
		.importance-low {
		    background-color: #003561; /* 파란색 */
		    color: white;
		    padding: 2px 6px;
		    border-radius: 10px;
		    font-size: 0.7em;
		    margin-left: 5px;
		}
        
        /* 오늘 날짜 스타일 */
        .fc .fc-daygrid-day.fc-day-today {
            background-color: inherit;
        }
        
        /* 날짜 선택 스타일 */
        .fc-day-selected {
            background-color: #dbebfb !important;
        }
        
        /* 날짜 선택 동그라미 스타일 */
		.date-circle {
		    width: 36px;
		    height: 36px;
		    background-color: #003561;
		    color: white !important;
		    border-radius: 50%;
		    display: inline-flex !important;
		    justify-content: center;
		    align-items: center;
		    font-weight: bold;
		    text-align: center;
		}
		
        
        /* 요일 행 스타일 */
        .fc-col-header {
            background-color: #f8f9fa;
        }
        
        /* 선택된 날짜 스타일 */
        .fc-day-selected .fc-daygrid-day-number {
            font-weight: bold;
        }
        
		.fc-day-selected .fc-daygrid-day-number.date-circle {
		    padding: 0 !important;
		    margin: 5px 0 0 5px !important;
		    width: 35px !important;
		    height: 35px !important;
		    text-align: center !important;
		}
        
        /* 날짜 그리드 높이 조정 */
        .fc-daygrid-body .fc-daygrid-day {
            min-height: 100px;
        }
        
        /* 날짜 셀 높이 증가 */
		.fc-daygrid-day {
		    height: 130px !important; /* 원하는 높이로 조정 */
		}
        
        /* 날짜 번호 크기 및 위치 조정 */
        .fc-daygrid-day-number {
            font-size: 14px;
            padding: 5px 0 0 10px;
        }
        
        /* 달력 헤더 버튼 스타일링 */
        .calendar-header h4 {
            margin: 0;
            font-size: 24px;
            font-weight: 500;
        }
        
        /* 오늘 날짜 표시 */
        .fc-day-today .fc-daygrid-day-number {
            font-weight: bold;
        }
        
        /* 일정 높이 조정 */
        .fc-daygrid-event-harness {
            margin-top: 1px;
        }
        
       /* 월/연도 선택기 스타일 */
		#month-year-picker {
		    background-color: #fff;
		    border: 1px solid #ddd;
		    border-radius: 4px;
		    box-shadow: 0 2px 5px rgba(0,0,0,0.15);
		    padding: 10px;
		    z-index: 1000;
		}
		
		#calendar-current-month-year {
		    cursor: pointer;
		}
		
		#calendar-current-month-year:hover {
		    color: #003561;
		    text-decoration: underline;
		} 
    </style>
</head>
<body class="calendar-wrapper">
    <jsp:include page="../common/header.jsp"/>
    <jsp:include page="scheduleDetailModal.jsp" /> 
        
    <div class="calendar-content-container">
        <div class="calendar-header">
            <div style="display: flex; align-items: center;">
                <button class="calendar-nav-button" id="calendar-prev-button" style="font-size: 24px; margin-right: 5px;">
                    <span>&#8249;</span>
                </button>
                <h4 id="calendar-current-month-year" style="margin: 0; font-size: 20px; font-weight: 500;">2024년 4월</h4>
                <button class="calendar-nav-button" id="calendar-next-button" style="font-size: 24px; margin-left: 5px;">
                    <span>&#8250;</span>
                </button>
                <button class="calendar-today-button" id="calendar-today-button" style="margin-left: 10px; background-color: #dbebfb; color: #114d79; border-radius: 4px; font-size: 14px; font-weight: bold; padding: 5px 12px;">오늘</button>
	            <button id="add-schedule-btn" class="calendar-today-button" style="margin-left: 10px; background-color: white; color: #003561; border: 1px solid #003561; border-radius: 4px; font-size: 14px; font-weight: bold; padding: 5px 12px; transition: background-color 0.2s ease;">
				    <span style="font-size: 16px; margin-right: 4px;">+</span> 새 일정 등록
				</button>            
            </div>
            <div class="calendar-navigation">
                <div class="calendar-view-controls">
                    <button class="calendar-view-button active" id="calendar-month-view">월</button>
                    <button class="calendar-view-button" id="calendar-week-view">주</button>
                    <button class="calendar-view-button" id="calendar-day-view">일</button>
                </div>
            </div>
        </div>
        
        <div class="calendar-main-container">
            <div id="calendar-main"></div>
        </div>
    </div>
    
    <!-- 일정 상세 모달 컨테이너 -->
	<div id="schedule-detail-modal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 1000; justify-content: center; align-items: center;"></div>
    
    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales/ko.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log("DOM loaded, initializing calendar...");
            
            // 캘린더 요소 가져오기
            var calendarEl = document.getElementById('calendar-main');
            
            // FullCalendar가 정의되었는지 확인
            if (typeof FullCalendar === 'undefined') {
                console.error("FullCalendar is not defined! Check library loading.");
                calendarEl.innerHTML = '<div style="padding: 20px; text-align: center; color: red;">캘린더 라이브러리를 로드할 수 없습니다. 페이지를 새로고침 해주세요.</div>';
                return;
            }
            
            // FullCalendar 초기화
            var calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: false, // 커스텀 헤더 사용
                locale: 'ko', // 한국어 설정
                initialView: 'dayGridMonth', // 초기 뷰 (월간)
                height: 'auto',
                contentHeight: 700,
                dayMaxEvents: true, // 이벤트가 많을 경우 "more" 링크 표시
                weekNumbers: false,
                navLinks: false,
                fixedWeekCount: false,
                showNonCurrentDates: true,
                firstDay: 0, // 일요일부터 시작
                
                // DB에서 데이터를 동적으로 가져오는 방식 (실제 구현 시)
                events: function(info, successCallback, failureCallback) {
                    // AJAX 요청으로 서버에서 데이터 가져오기
                    $.ajax({
                        url: 'getSchedules.sc', // 실제 컨트롤러 URL로 변경
                        type: 'GET',
                        dataType: 'json',
                        data: {
                            start: info.startStr, // 시작 날짜
                            end: info.endStr      // 종료 날짜
                        },
                        success: function(result) { 
                        	// 서버에서 받은 일정 데이터 처리
                            successCallback(result);  // 서버에서 이미 FullCalendar 형식으로 변환된 데이터를 받기 때문에 바로 사용
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            failureCallback(errorThrown);
                            console.error("일정 데이터를 불러오는데 실패했습니다.", errorThrown);
                            
                         	// 실패 시 빈 배열을 전달
                            successCallback([]);
                         	
                         	// 사용자에게 오류 메시지 표시
                            alert("일정을 불러오는데 실패했습니다. 페이지를 새로고침하거나 나중에 다시 시도해주세요.");
                        }
                    });
                },
                
                // 날짜 클릭 이벤트 - 해당 날짜에 색상 적용 및 동그라미 추가
                dateClick: function(info) {
                    // 모든 셀의 배경색 초기화
                    document.querySelectorAll('.fc-day').forEach(function(cell) {
                        cell.classList.remove('fc-day-selected');
                        cell.style.backgroundColor = '';
                    });
                    document.querySelectorAll('.fc-daygrid-day-number').forEach(function(dateEl) {
                        dateEl.classList.remove('date-circle');
                    });
                    
                    // 선택한 날짜에 배경색 적용
                    info.dayEl.classList.add('fc-day-selected');
                    info.dayEl.style.backgroundColor = 'rgba(0, 53, 97, 0.1)';
                    
                 	// 선택한 날짜의 번호에 동그라미 스타일 적용
                    var dateEl = info.dayEl.querySelector('.fc-daygrid-day-number');
                    if(dateEl) {
                        dateEl.classList.add('date-circle');
                    }
                    
                    console.log('날짜 클릭: ' + info.dateStr);
                    
                    // 선택한 날짜의 일정 상세 정보를 가져오는 AJAX 요청 (실제 구현 시)
                    /*
                    $.ajax({
                        url: 'getDaySchedules.sc',
                        type: 'GET',
                        data: {
                            date: info.dateStr
                        },
                        success: function(result) {
                            // 해당 날짜의 일정 상세 정보 표시 처리
                            console.log('해당 날짜 일정:', result);
                        }
                    });
                    */
                },
                
                // 이벤트(일정) 클릭 시 처리
                eventClick: function(info) {
                    console.log('일정 클릭:', info.event.title);
                    
                 	// 일정 상세 정보 모달로 표시
                    $.ajax({
                        url: 'detailModal.sc',
                        type: 'GET',
                        data: {
                            scheduleNo: info.event.id
                        },
                        success: function(response) {
                            $('#schedule-detail-modal').html(response);
                            $('#schedule-detail-modal').css('display', 'flex');
                        },
                        error: function(xhr, status, error) {
                            console.error('일정 상세 정보를 불러오는데 실패했습니다:', error);
                            alert('일정 정보를 불러오는데 실패했습니다.');
                        }
                    });
                },
                
                // 달력 렌더링 후 추가 작업
                datesSet: function(info) {
                    // 현재 날짜(오늘)를 가져오기
                    var today = new Date();
                    var year = today.getFullYear();
                    var month = today.getMonth() + 1;
                    var day = today.getDate();
                    
                    // ISO 형식의 오늘 날짜 문자열 생성 (YYYY-MM-DD)
                    var todayStr = year + '-' + 
                                  (month < 10 ? '0' + month : month) + '-' + 
                                  (day < 10 ? '0' + day : day);
                    
                    // 약간의 지연 후 적용 (렌더링 완료 후)
                    setTimeout(function() {
                        // 모든 날짜 셀의 선택 초기화
                        document.querySelectorAll('.fc-day').forEach(function(cell) {
                            cell.classList.remove('fc-day-selected');
                            cell.style.backgroundColor = '';
                        });
                        document.querySelectorAll('.fc-daygrid-day-number').forEach(function(dateEl) {
                            dateEl.classList.remove('date-circle');
                        });
                        
                        // 오늘 날짜 셀 찾기 및 강조 표시
                        var todayEl = document.querySelector('.fc-day[data-date="' + todayStr + '"]');
                        if (todayEl) {
                            todayEl.classList.add('fc-day-selected');
                            todayEl.style.backgroundColor = 'rgba(0, 53, 97, 0.1)';
                            
                         	// 오늘 날짜 번호에 동그라미 추가
                            var todayNumEl = todayEl.querySelector('.fc-daygrid-day-number');
                            if (todayNumEl) {
                                todayNumEl.classList.add('date-circle');
                            }
                            
                            console.log('오늘 날짜 강조:', todayStr);
                        }
                    }, 100);
                }
            });
            
            try {
                // 캘린더 렌더링
                calendar.render();
                
                // 현재 표시하는 월/년 업데이트 함수
                function updateMonthYearTitle() {
                    var date = calendar.getDate();
                    var year = date.getFullYear();
                    var month = date.getMonth() + 1;
                    document.getElementById('calendar-current-month-year').textContent = year + '년 ' + month + '월';
                }
                
                // 초기 월/년 표시
                updateMonthYearTitle();
                
                // 이전 달 버튼 이벤트
                document.getElementById('calendar-prev-button').addEventListener('click', function() {
                    calendar.prev();
                    updateMonthYearTitle();
                });
                
                // 다음 달 버튼 이벤트
                document.getElementById('calendar-next-button').addEventListener('click', function() {
                    calendar.next();
                    updateMonthYearTitle();
                });
                
                // 오늘 버튼 이벤트
                document.getElementById('calendar-today-button').addEventListener('click', function() {
                    calendar.today();
                    updateMonthYearTitle();
                });
                
                // 뷰 전환 버튼 이벤트
                document.getElementById('calendar-month-view').addEventListener('click', function() {
                    changeView('calendar-month-view', 'dayGridMonth');
                });
                
                document.getElementById('calendar-week-view').addEventListener('click', function() {
                    changeView('calendar-week-view', 'timeGridWeek');
                });
                
                document.getElementById('calendar-day-view').addEventListener('click', function() {
                    changeView('calendar-day-view', 'timeGridDay');
                });
                
                // 뷰 변경 함수
                function changeView(buttonId, viewName) {
                    // 모든 버튼 비활성화
                    document.querySelectorAll('.calendar-view-button').forEach(function(btn) {
                        btn.classList.remove('active');
                    });
                    
                    // 선택한 버튼 활성화
                    document.getElementById(buttonId).classList.add('active');
                    
                    // 캘린더 뷰 변경
                    calendar.changeView(viewName);
                    updateMonthYearTitle();
                }
            } catch (error) {
                console.error("캘린더 렌더링 오류:", error);
                calendarEl.innerHTML = '<div style="padding: 20px; text-align: center; color: red;">캘린더를 로드하는 중 오류가 발생했습니다: ' + error.message + '</div>';
            }
            
         // calendar-current-month-year 요소에 클릭 이벤트 추가
            document.getElementById('calendar-current-month-year').addEventListener('click', function(e) {
                e.preventDefault();
                
                // 이미 열려있는 선택기가 있으면 닫기
                const existingPicker = document.getElementById('month-year-picker');
                if (existingPicker) {
                    existingPicker.remove();
                    return;
                }
                
                // 현재 날짜 구하기
                const currentDate = calendar.getDate();
                const currentYear = currentDate.getFullYear();
                const currentMonth = currentDate.getMonth();
                
                // 월/연도 선택기 컨테이너 생성
                const picker = document.createElement('div');
                picker.id = 'month-year-picker';
                picker.style.position = 'absolute';
                picker.style.top = (this.offsetTop + this.offsetHeight + 5) + 'px';
                picker.style.left = this.offsetLeft + 'px';
                
                // 연도 선택 드롭다운
                const yearSelect = document.createElement('select');
                yearSelect.style.margin = '0 5px 10px 0';
                yearSelect.style.padding = '5px';
                yearSelect.style.width = '120px';
                
                // 연도 옵션 추가 (현재 연도 ±5년)
                for (let y = currentYear - 5; y <= currentYear + 5; y++) {
                    const option = document.createElement('option');
                    option.value = y;
                    option.textContent = y + '년';
                    option.selected = y === currentYear;
                    yearSelect.appendChild(option);
                }
                
                // 월 선택 드롭다운
                const monthSelect = document.createElement('select');
                monthSelect.style.margin = '0 0 10px 5px';
                monthSelect.style.padding = '5px';
                monthSelect.style.width = '100px';
                
                // 월 옵션 추가
                const months = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
                months.forEach((month, index) => {
                    const option = document.createElement('option');
                    option.value = index;
                    option.textContent = month;
                    option.selected = index === currentMonth;
                    monthSelect.appendChild(option);
                });
                
                // 선택 버튼
                const selectBtn = document.createElement('button');
                selectBtn.textContent = '선택';
                selectBtn.style.marginRight = '5px';
                selectBtn.style.padding = '6px 12px';
                selectBtn.style.backgroundColor = '#003561';
                selectBtn.style.color = '#fff';
                selectBtn.style.border = 'none';
                selectBtn.style.borderRadius = '4px';
                selectBtn.style.cursor = 'pointer';
                
                // 취소 버튼
                const cancelBtn = document.createElement('button');
                cancelBtn.textContent = '취소';
                cancelBtn.style.padding = '6px 12px';
                cancelBtn.style.backgroundColor = '#e9e9e9';
                cancelBtn.style.color = '#333';
                cancelBtn.style.border = 'none';
                cancelBtn.style.borderRadius = '4px';
                cancelBtn.style.cursor = 'pointer';
                
                // 버튼 컨테이너
                const buttonContainer = document.createElement('div');
                buttonContainer.style.textAlign = 'center';
                buttonContainer.appendChild(selectBtn);
                buttonContainer.appendChild(cancelBtn);
                
                // 모든 요소를 피커에 추가
                picker.appendChild(yearSelect);
                picker.appendChild(monthSelect);
                picker.appendChild(buttonContainer);
                
                // 선택 버튼 클릭 이벤트
                selectBtn.addEventListener('click', function() {
                    const year = parseInt(yearSelect.value);
                    const month = parseInt(monthSelect.value);
                    const newDate = new Date(year, month, 1);
                    
                    // 새 날짜로 캘린더 이동
                    calendar.gotoDate(newDate);
                    updateMonthYearTitle();
                    
                    // 선택기 제거
                    picker.remove();
                });
                
                // 취소 버튼 클릭 이벤트
                cancelBtn.addEventListener('click', function() {
                    picker.remove();
                });
                
                // 다른 곳 클릭 시 닫기
                document.addEventListener('click', function closeOnClickOutside(e) {
                    if (!picker.contains(e.target) && e.target !== document.getElementById('calendar-current-month-year')) {
                        picker.remove();
                        document.removeEventListener('click', closeOnClickOutside);
                    }
                });
                
                // 피커를 DOM에 추가
                document.body.appendChild(picker);
            });
         
	         // 새 일정 등록 버튼 호버 효과
	            const addScheduleBtn = document.getElementById('add-schedule-btn');
	            addScheduleBtn.addEventListener('mouseenter', function() {
	                this.style.backgroundColor = 'rgba(0, 53, 97, 0.1)'; // 테마 색상의 투명도를 낮춘 배경색
	            });
	            addScheduleBtn.addEventListener('mouseleave', function() {
	                this.style.backgroundColor = 'white';
	            });
	
	            // 새 일정 등록 버튼 클릭 이벤트
	            addScheduleBtn.addEventListener('click', function() {
	                // 일정 등록 페이지로 이동
	                location.href = 'enrollForm.sc';
	            });
        });   
        
    </script>

</body>
</html>