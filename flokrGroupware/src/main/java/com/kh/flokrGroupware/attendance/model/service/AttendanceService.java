package com.kh.flokrGroupware.attendance.model.service;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.Duration;
import java.util.List;
import java.util.Map;

import com.kh.flokrGroupware.attendance.model.vo.Attendance;
import com.kh.flokrGroupware.attendance.model.vo.WeeklySummary;

public interface AttendanceService {
	
	// 오늘 근태 데이터가 들어갔는지 확인하고 가져오는 메소드
	Attendance getTodayAttendance(int empNo);
	
	// 매일매일 근태 데이터 넣어주는 메소드
	int insertTodayAttendance(int empNo, Date today);
	
	// 출퇴근 데이터 수정
	int updateClockIn(int empNo, Timestamp now, String status); // 출근
	int updateClockOut(int empNo, Timestamp now); // 퇴근
	
	// 근무 시간 계산
	Duration calculateWeekWorkDuration(int empNo);

	List<WeeklySummary> calculateWeeklySummaries(int empNo);

	Map<String, Duration> calculateMonthSummary(int empNo);
	
	Map<Integer, List<Attendance>> getWeeklyAttendanceMap(int empNo);

	List<WeeklySummary> getWeeklySummariesForMonth(int empNo, int year, int month);

	Map<Integer, List<Attendance>> getWeeklyAttendanceMapForMonth(int empNo, int year, int month);


}
