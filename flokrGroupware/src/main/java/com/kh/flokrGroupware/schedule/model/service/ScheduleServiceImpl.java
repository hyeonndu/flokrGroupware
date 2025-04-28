package com.kh.flokrGroupware.schedule.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.flokrGroupware.employee.model.vo.Employee;
import com.kh.flokrGroupware.schedule.model.dao.ScheduleDao;
import com.kh.flokrGroupware.schedule.model.vo.Schedule;
import com.kh.flokrGroupware.schedule.model.vo.ScheduleAttendee;

@Service
public class ScheduleServiceImpl implements ScheduleService {
	
	@Autowired
	private ScheduleDao sDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<Schedule> selectScheduleList(int empNo, String start, String end) {
		return null;
	}

	@Override
	public Schedule selectSchedule(int scheduleNo) {
		return null;
	}

	@Override
	public int insertSchedule(Schedule schedule, int[] attendeeArray) {
		// 일정 기본 정보 등록
		int result = sDao.insertSchedule(sqlSession, schedule);
		
		// 등록 성공 & 참석자 있으면 참석자 정보 등록
		if(result > 0 && attendeeArray != null && attendeeArray.length > 0) {
			for(int empNo : attendeeArray) {
				ScheduleAttendee attendee = new ScheduleAttendee();
				attendee.setScheduleNo(schedule.getScheduleNo());
				attendee.setEmpNo(empNo);
				attendee.setResponseStatus("PENDING");
				attendee.setNotificationSent(1); // 알림 발송 여부
				
				int attendeeResult = sDao.insertScheduleAttendee(sqlSession, attendee);
				if(attendeeResult == 0) {
					// 로그 기록 등 실패 처리
					System.out.println("참석자 등록 실패: " + empNo);
				}
			}
		}

		return result;
	
	}

	@Override
	public int updateSchedule(Schedule schedule, int[] attendees) {
		return 0;
	}

	@Override
	public int deleteSchedule(int scheduleNo) {
		return 0;
	}

	@Override
	public ArrayList<ScheduleAttendee> selectAttendees(int scheduleNo) {
		return null;
	}

	@Override
	public ArrayList<Schedule> selectDeptScheduleList(int deptNo, String start, String end) {
		return null;
	}

	@Override
	public ArrayList<Schedule> selectCompanyScheduleList(String start, String end) {
		return null;
	}

	@Override
	public ArrayList<Map<String, Object>> convertToCalendarEvents(ArrayList<Schedule> scheduleList) {
		return null;
	}

	@Override
	public ArrayList<Map<String, Object>> getScheduleEvents(int empNo, int deptNo, String start, String end ,
			String personal, String dept, String company) {
		return null;
	}

	@Override
	public ArrayList<Employee> selectEmployeeList() {
		return sDao.selectEmployeeList(sqlSession);
	}

}
