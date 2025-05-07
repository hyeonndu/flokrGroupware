package com.kh.flokrGroupware.chat.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class ChatRoom {
	
	private int roomNo;
	private String roomName;
	private String roomType;
	private int createByEmpNo;
	private String createDate;
	private String status;
	
	// 마지막 메시지 정보
	private String lastMessageContent;
	private Date lastMessageTime;
	
	// 1:1 채팅 상대방 프로필
	private String chatUserImgPath;
	
    // 참여 인원 수
    private int memberCount;
	
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
	public int getCreateByEmpNo() {
		return createByEmpNo;
	}
	public void setCreateByEmpNo(int createByEmpNo) {
		this.createByEmpNo = createByEmpNo;
	}
	public String getLastMessageContent() {
		return lastMessageContent;
	}
	public void setLastMessageContent(String lastMessageContent) {
		this.lastMessageContent = lastMessageContent;
	}
	public String getChatUserImgPath() {
		return chatUserImgPath;
	}
	public void setChatUserImgPath(String chatUserImgPath) {
		this.chatUserImgPath = chatUserImgPath;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getLastMessageTime() {
		return lastMessageTime;
	}
	public void setLastMessageTime(Date lastMessageTime) {
		this.lastMessageTime = lastMessageTime;
	}
	public int getMemberCount() {
		return memberCount;
	}
	public void setMemberCount(int memberCount) {
		this.memberCount = memberCount;
	}

	

}
