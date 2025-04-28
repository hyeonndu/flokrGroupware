package com.kh.flokrGroupware.chat.model.vo;

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
public class ChatRoom {
	
	private int roomNo;
	private String roomName;
	private String roomType;
	private String createByEmpNo;
	private String createDate;
	private String status;
	
	
	
	
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public String getCreateByEmpNo() {
		return createByEmpNo;
	}
	public void setCreateByEmpNo(String createByEmpNo) {
		this.createByEmpNo = createByEmpNo;
	}
	
	

}
