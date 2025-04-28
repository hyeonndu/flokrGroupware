package com.kh.flokrGroupware.schedule.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.flokrGroupware.employee.model.vo.Employee;
import com.kh.flokrGroupware.schedule.model.vo.Schedule;
import com.kh.flokrGroupware.schedule.model.vo.ScheduleAttendee;

@Repository
public class ScheduleDao {
	
	/**
	 * 일정 등록
	 * @param sqlSession SQL 세션
	 * @param schedule 등록할 일정 정보
	 * @return 처리 결과 (성공 1, 실패 0)
	 */
	public int insertSchedule(SqlSessionTemplate sqlSession, Schedule schedule) {
		return sqlSession.insert("scheduleMapper.insertSchedule", schedule);
	}
	
	/**
	 * 일정 참석자 등록
	 * @param sqlSession SQL 세션
	 * @param attendee 참석자 정보
	 * @return 처리 결과 (성공 1, 실패 0)
	 */
	public int insertScheduleAttendee(SqlSessionTemplate sqlSession, ScheduleAttendee attendee) {
		return sqlSession.insert("scheduleMapper.insertScheduleAttendee", attendee);
	}
	
	/**
	 * 직원 목록 조회
	 * @param sqlSession SQL 세션
	 * @return 전체 직원 목록
	 */
	public ArrayList<Employee> selectEmployeeList(SqlSessionTemplate sqlSession){
		return (ArrayList)sqlSession.selectList("scheduleMapper.selectEmployeeList");
	}

}
