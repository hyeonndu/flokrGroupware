package com.kh.flokrGroupware.schedule.model.vo;

public class ScheduleAttendee {
	
	private int attendeeNo;  			// 참석자 매핑 번호
	private int scheduleNo;				// 일정 번호
	private int empNo;					// 참석하는 직원 번호
	private String responseStatus; 		// 응답 상태
	private int notificationSent; 		// 알림 발송 여부 (1=발송, 0=미발송)
	private String status;				// 활성 상태
	
	// 조회용 추가 필드 (JOIN 시 사용)
    private String empName;        // 참석자 이름
    private String deptName;       // 부서명
    private String positionName;   // 직급명	
    private String profilePath;    // 프로필 이미지 경로
    
    public ScheduleAttendee () {}

	public ScheduleAttendee(int attendeeNo, int scheduleNo, int empNo, String responseStatus, int notificationSent,
			String status, String empName, String deptName, String positionName, String profilePath) {
		super();
		this.attendeeNo = attendeeNo;
		this.scheduleNo = scheduleNo;
		this.empNo = empNo;
		this.responseStatus = responseStatus;
		this.notificationSent = notificationSent;
		this.status = status;
		this.empName = empName;
		this.deptName = deptName;
		this.positionName = positionName;
		this.profilePath = profilePath;
	}

	public int getAttendeeNo() {
		return attendeeNo;
	}

	public void setAttendeeNo(int attendeeNo) {
		this.attendeeNo = attendeeNo;
	}

	public int getScheduleNo() {
		return scheduleNo;
	}

	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}

	public int getEmpNo() {
		return empNo;
	}

	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}

	public String getResponseStatus() {
		return responseStatus;
	}

	public void setResponseStatus(String responseStatus) {
		this.responseStatus = responseStatus;
	}

	public int getNotificationSent() {
		return notificationSent;
	}

	public void setNotificationSent(int notificationSent) {
		this.notificationSent = notificationSent;
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

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getPositionName() {
		return positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}

	public String getProfilePath() {
		return profilePath;
	}

	public void setProfilePath(String profilePath) {
		this.profilePath = profilePath;
	}

	@Override
	public String toString() {
		return "ScheduleAttendee [attendeeNo=" + attendeeNo + ", scheduleNo=" + scheduleNo + ", empNo=" + empNo
				+ ", responseStatus=" + responseStatus + ", notificationSent=" + notificationSent + ", status=" + status
				+ ", empName=" + empName + ", deptName=" + deptName + ", positionName=" + positionName
				+ ", profilePath=" + profilePath + "]";
	}
    

}
