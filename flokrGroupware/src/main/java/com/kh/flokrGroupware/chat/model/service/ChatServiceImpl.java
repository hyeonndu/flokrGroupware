package com.kh.flokrGroupware.chat.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.flokrGroupware.chat.model.dao.ChatDao;
import com.kh.flokrGroupware.chat.model.vo.ChatMessage;
import com.kh.flokrGroupware.chat.model.vo.ChatRoom;
import com.kh.flokrGroupware.employee.model.vo.Employee;

@Service
public class ChatServiceImpl implements ChatService{
	
	@Autowired
	private ChatDao cDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ChatRoom createChatRoom(String roomName, String creatorEmpId) {
		return null;
	}

	@Override
	public ArrayList<ChatRoom> findMyChatRooms(String empId) {
		return null;
	}

	@Override
	public ChatRoom findChatRoomById(int roomId) {
		return null;
	}

	@Override
	public int updateChatRoomName(int roomId, String newRoomName, String empId) {
		return 0;
	}

	@Override
	public int deleteChatRoom(int roomId, String empId) {
		return 0;
	}

	@Override
	public void processAndSendMessage(ChatMessage message) {
	}

	@Override
	public ArrayList<ChatMessage> getChatHistory(int roomId) {
		return null;
	}

	@Override
	public int inviteUserToRoom(int roomId, String inviterEmpId, String inviteeEmpId) {
		return 0;
	}

	@Override
	public int leaveChatRoom(int roomId, String empId) {
		return 0;
	}

	@Override
	public ArrayList<Employee> findChatRoomMembers(int roomId) {
		return null;
	}

	@Override
	public boolean isUserInRoom(int roomId, String empId) {
		return false;
	}

}
