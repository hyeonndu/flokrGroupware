package com.kh.flokrGroupware.attendance.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDate;
import java.time.temporal.ChronoField;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.flokrGroupware.attendance.model.service.AttendanceServiceImpl;
import com.kh.flokrGroupware.attendance.model.vo.Attendance;
import com.kh.flokrGroupware.employee.model.vo.Employee;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {
	
	@Autowired
	private AttendanceServiceImpl attService;
	// 나중에 impl말고 그냥 service로 바꿔주기!!!!!!!!
	
	private Map<String, String> formatDuration(Duration d) {
	    long totalSeconds = d.getSeconds();
	    long h = totalSeconds / 3600;
	    long m = (totalSeconds % 3600) / 60;
	    long s = totalSeconds % 60;
	    return Map.of(
	        "h", String.format("%02d", h),
	        "m", String.format("%02d", m),
	        "s", String.format("%02d", s)
	    );
	}
	
	@RequestMapping("/main")
	public String attendanceMainpage(HttpSession session, Model model) {
	    Employee loginUser = (Employee) session.getAttribute("loginUser");
	    int empNo = loginUser.getEmpNo();

	    Attendance todayAttendance = attService.getTodayAttendance(empNo);
	    if (todayAttendance == null) {
	        Date today = new Date(System.currentTimeMillis());
	        attService.insertTodayAttendance(empNo, today);
	        todayAttendance = attService.getTodayAttendance(empNo); // 다시 조회
	    }

	    // 주차 계산 추가
	    int currentWeek = LocalDate.now().get(java.time.temporal.ChronoField.ALIGNED_WEEK_OF_MONTH);
	    model.addAttribute("currentWeek", currentWeek);  // ✅ 이거 추가하면 됨

	    // 주간 누적/초과/잔여 계산
	    Duration weekDur = attService.calculateWeekWorkDuration(empNo);
	    Duration weeklyOver = weekDur.minus(Duration.ofHours(35)).isNegative() ? Duration.ZERO : weekDur.minus(Duration.ofHours(35));
	    Duration weeklyRemain = weekDur.minus(Duration.ofHours(35)).isNegative() ? Duration.ofHours(35).minus(weekDur) : Duration.ZERO;

	    model.addAttribute("week", formatDuration(weekDur));
	    model.addAttribute("weekOver", formatDuration(weeklyOver));
	    model.addAttribute("weekRemain", formatDuration(weeklyRemain));

	    // 월간 누적/연장 계산
	    Map<String, Duration> monthMap = attService.calculateMonthSummary(empNo);
	    model.addAttribute("month", formatDuration(monthMap.get("monthlyTotal")));
	    model.addAttribute("monthOver", formatDuration(monthMap.get("monthlyOvertime")));
	    model.addAttribute("monthDuration", monthMap.get("monthlyTotal"));
	    model.addAttribute("monthOverDuration", monthMap.get("monthlyOvertime"));
	    model.addAttribute("attendance", todayAttendance);
	    model.addAttribute("weekDuration", weekDur);
	    model.addAttribute("weeklySummaries", attService.calculateWeeklySummaries(empNo));
	    
	    LocalDate now = LocalDate.now();
	    model.addAttribute("currentYear", now.getYear());
	    model.addAttribute("currentMonth", now.getMonthValue());

	    Map<Integer, List<Attendance>> weeklyAttendanceMap = attService.getWeeklyAttendanceMap(empNo);
	    model.addAttribute("weeklyAttendanceMap", weeklyAttendanceMap);

	    return "attendance/attendanceMain";
	}


	
	@PostMapping("/clockIn")
	@ResponseBody
	public Map<String, Object> clockIn(@RequestBody Map<String, String> req, HttpSession session) {
		Employee loginUser = (Employee) session.getAttribute("loginUser");
		int empNo = loginUser.getEmpNo();
	    String type = req.get("type"); // NORMAL 또는 REMOTE
	    Timestamp now = new Timestamp(System.currentTimeMillis());

	    int result = attService.updateClockIn(empNo, now, type);
	    return Map.of("success", result > 0);
	}
	
	@PostMapping("/clockOut")
	@ResponseBody
	public Map<String, Object> clockOut(HttpSession session) {
		Employee loginUser = (Employee) session.getAttribute("loginUser");
		int empNo = loginUser.getEmpNo();
		Timestamp now = new Timestamp(System.currentTimeMillis());

	    int result = attService.updateClockOut(empNo, now);
	    return Map.of("success", result > 0);
	}


}
