package com.kh.flokrGroupware.chat.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.flokrGroupware.chat.model.vo.ChatRoom;

@Repository
public class ChatDao {
	
	public ArrayList<ChatRoom> findMyChatRooms(SqlSessionTemplate sqlSession, int empNo) {
		
		return (ArrayList)sqlSession.selectList("chatMapper.findMyChatRooms", empNo);

	}

}
