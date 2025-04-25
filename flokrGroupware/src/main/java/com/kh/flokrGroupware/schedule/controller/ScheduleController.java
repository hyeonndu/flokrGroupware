package com.kh.flokrGroupware.schedule.controller;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.flokrGroupware.employee.model.vo.Employee;
import com.kh.flokrGroupware.schedule.model.service.ScheduleService;
import com.kh.flokrGroupware.schedule.model.vo.Schedule;
import com.kh.flokrGroupware.schedule.model.vo.ScheduleAttendee;

@Controller
public class ScheduleController {
	
	@Autowired
    private ScheduleService scheduleService;
    
    // 일정 캘린더 화면으로 이동
    @RequestMapping("calendar.sc")
    public String scheduleCalendar(Model model) {
        model.addAttribute("currentPage", "schedule");
        return "schedule/scheduleCalendar";
    }
    
    // 일정 데이터 조회 (AJAX 요청 처리)
    @ResponseBody
    @RequestMapping("getSchedules.sc")    
    public ArrayList<Map<String, Object>> getSchedules(String start, String end, String personal, String dept, String company, HttpSession session) {
        
    	// 로그인한 사용자 정보 가져오기
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        int empNo = loginUser.getEmpNo();
        int deptNo = loginUser.getDeptNo();
        
        // 서비스를 통해 일정 데이터 조회 및 변환
        return scheduleService.getScheduleEvents(empNo, deptNo, start, end, personal, dept, company);
    }
    
    // 일정 상세 조회 (모달용)
    @RequestMapping("detailModal.sc")
    public String scheduleDetail(int scheduleNo, Model model) {
    	// 일정 정보 조회
    	Schedule schedule = scheduleService.selectSchedule(scheduleNo);
    	
    	// 참석자 정보 조회
    	ArrayList<ScheduleAttendee> sa = scheduleService.selectAttendees(scheduleNo);
    	
    	model.addAttribute("schedule", schedule);
    	model.addAttribute("sa", sa);
    	
    	// 모달용 부분 뷰 리턴
    	return "schedule/scheduleDetailModal";
    	
    	
    }


}
