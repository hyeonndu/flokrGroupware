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
	public ChatRoom createChatRoom(String roomName, int creatorEmpNo) {
		return null;
	}

	@Override
	public ArrayList<ChatRoom> findMyChatRooms(int empNo) {
		return cDao.findMyChatRooms(sqlSession, empNo);
	}

	@Override
	public ChatRoom findChatRoomById(int roomNo) {
		return null;
	}

	@Override
	public int updateChatRoomName(int roomNo, String newRoomName, int empNo) {
		return 0;
	}

	@Override
	public int deleteChatRoom(int roomNo, int empNo) {
		return 0;
	}

	@Override
	public void processAndSendMessage(ChatMessage message) {
	}

	@Override
	public ArrayList<ChatMessage> getChatHistory(int roomNo) {
		return null;
	}

	@Override
	public int inviteUserToRoom(int roomNo, int inviterEmpNo, int inviteeEmpNo) {
		return 0;
	}

	@Override
	public int leaveChatRoom(int roomNo, int empNo) {
		return 0;
	}

	@Override
	public ArrayList<Employee> findChatRoomMembers(int roomNo) {
		return null;
	}

	@Override
	public boolean isUserInRoom(int roomNo, int empNo) {
		return false;
	}



}
