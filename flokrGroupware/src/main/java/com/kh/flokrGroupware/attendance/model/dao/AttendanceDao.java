package com.kh.flokrGroupware.attendance.model.dao;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.flokrGroupware.attendance.model.vo.Attendance;

@Repository
public class AttendanceDao {
	
	public Attendance getTodayAttendance(SqlSessionTemplate sqlSession, int empNo) {
        return sqlSession.selectOne("attendanceMapper.getTodayAttendance", empNo);
    }
	
	public int insertTodayAttendance(SqlSessionTemplate sqlSession, int empNo, Date today) {
        Map<String, Object> map = new HashMap<>();
        map.put("empNo", empNo);
        map.put("today", today);
        return sqlSession.insert("attendanceMapper.insertTodayAttendance", map);
    }
	
	public int updateClockIn(SqlSessionTemplate sqlSession, int empNo, Timestamp now, String status) {
        Map<String, Object> map = new HashMap<>();
        map.put("empNo", empNo);
        map.put("now", now);
        map.put("status", status);
        return sqlSession.update("attendanceMapper.updateClockIn", map);
    }
	
	public int updateClockOut(SqlSessionTemplate sqlSession, int empNo, Timestamp now) {
        Map<String, Object> map = new HashMap<>();
        map.put("empNo", empNo);
        map.put("now", now);
        return sqlSession.update("attendanceMapper.updateClockOut", map);
    }
	
	public List<Attendance> getAttendancesBetween(SqlSessionTemplate sqlSession, int empNo, LocalDate startOfWeek, LocalDate endOfWeek) {
        Map<String, Object> map = new HashMap<>();
        map.put("empNo", empNo);
        map.put("startOfWeek", Date.valueOf(startOfWeek));
        map.put("endOfWeek", Date.valueOf(endOfWeek));
        return sqlSession.selectList("attendanceMapper.getAttendancesBetween", map);
    }

}
