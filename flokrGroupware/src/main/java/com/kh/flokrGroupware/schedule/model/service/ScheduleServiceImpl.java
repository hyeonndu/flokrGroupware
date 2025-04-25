package com.kh.flokrGroupware.schedule.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.flokrGroupware.schedule.model.vo.Schedule;
import com.kh.flokrGroupware.schedule.model.vo.ScheduleAttendee;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Override
	public ArrayList<Schedule> selectScheduleList(int empNo, String start, String end) {
		return null;
	}

	@Override
	public Schedule selectSchedule(int scheduleNo) {
		return null;
	}

	@Override
	public int insertSchedule(Schedule schedule, int[] attendees) {
		return 0;
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
	public ArrayList<Map<String, Object>> getScheduleEvents(int empNo, int deptNo, String start, String end,
			String personal, String dept, String company) {
		return null;
	}

}
