package com.kh.flokrGroupware.schedule.model.vo;

import java.sql.Date;

public class Schedule {
	
	private int scheduleNo;				// 일정 번호
	private int createEmpNo; 			// 작성자 사번
	private String scheduleTitle;		// 일정 제목
	private String discription;      	// 일정 설명
	private Date startDate;				// 시작일
	private Date endDate;				// 종료일
	private String location;			// 장소
	private String important;			// 중요도
	private Date createDate;			// 생성일
	private Date updateDate;			// 수정일
	private String status;				// 활성상태
	
	// FullCalendar 표시용 추가 필드
    private String empName;       		// 작성자 이름
    
    public Schedule() {}

	public Schedule(int scheduleNo, int createEmpNo, String scheduleTitle, String discription, Date startDate,
			Date endDate, String location, String important, Date createDate, Date updateDate, String status,
			String empName) {
		super();
		this.scheduleNo = scheduleNo;
		this.createEmpNo = createEmpNo;
		this.scheduleTitle = scheduleTitle;
		this.discription = discription;
		this.startDate = startDate;
		this.endDate = endDate;
		this.location = location;
		this.important = important;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.status = status;
		this.empName = empName;
	}

	public int getScheduleNo() {
		return scheduleNo;
	}

	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}

	public int getCreateEmpNo() {
		return createEmpNo;
	}

	public void setCreateEmpNo(int createEmpNo) {
		this.createEmpNo = createEmpNo;
	}

	public String getScheduleTitle() {
		return scheduleTitle;
	}

	public void setScheduleTitle(String scheduleTitle) {
		this.scheduleTitle = scheduleTitle;
	}

	public String getDiscription() {
		return discription;
	}

	public void setDiscription(String discription) {
		this.discription = discription;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getImportant() {
		return important;
	}

	public void setImportant(String important) {
		this.important = important;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	@Override
	public String toString() {
		return "Schedule [scheduleNo=" + scheduleNo + ", createEmpNo=" + createEmpNo + ", scheduleTitle="
				+ scheduleTitle + ", discription=" + discription + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", location=" + location + ", important=" + important + ", createDate=" + createDate + ", updateDate="
				+ updateDate + ", status=" + status + ", empName=" + empName + "]";
	}
    
    

}
