package com.kh.flokrGroupware.attendance.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Attendance {
	
	private int attendanceNo;
	private int empNo;
	private Date attendanceDate;
	private Timestamp clockInTime;
	private Timestamp clockOutTime;
	private String attStatus;

}
