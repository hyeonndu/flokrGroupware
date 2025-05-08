package com.kh.flokrGroupware.chat.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.flokrGroupware.chat.model.vo.ChatMessage;
import com.kh.flokrGroupware.chat.model.vo.ChatRoom;
import com.kh.flokrGroupware.chat.model.vo.ChatRoomMember;

@Repository
public class ChatDao {
	
	public ArrayList<ChatRoom> findMyChatRooms(SqlSessionTemplate sqlSession, Map<String, Object> params) {
		
		return (ArrayList)sqlSession.selectList("chatMapper.findMyChatRooms", params);

	}
	
	public int checkUserInRoom(SqlSessionTemplate sqlSession, int roomNo, int empNo) {
		
        // 1. 파라미터를 담을 Map 생성
        Map<String, Object> params = new HashMap<>();
        // 2. Map에 파라미터 추가 (key는 XML의 #{...} 이름과 일치)
        params.put("roomNo", roomNo);
        params.put("empNo", empNo);

        // 3. selectOne 메소드에 Map 객체를 파라미터로 전달
        // COUNT(*) 결과는 보통 Integer로 반환되므로 Integer로 받거나 int로 캐스팅
        Integer count = sqlSession.selectOne("chatMapper.checkUserInRoom", params);

        // null 체크 후 int 반환 (count(*)는 보통 null을 반환하지 않지만 안전하게 처리)
        return (count != null) ? count.intValue() : 0;
	}
	
	public ChatRoom findRoomById(SqlSessionTemplate sqlSession, int roomNo) {
		return sqlSession.selectOne("chatMapper.findRoomById", roomNo);
	}
	
	public ArrayList<ChatMessage> findMessagesByRoomId(SqlSessionTemplate sqlSession, int roomNo) {
		
		return (ArrayList) sqlSession.selectList("chatMapper.findMessagesByRoomId", roomNo);
		
	}
	
	public int insertChatMessage(SqlSessionTemplate sqlSession, ChatMessage message) {
		
		return sqlSession.insert("chatMapper.insertChatMessage", message);
	}
	
    public int insertChatRoom(SqlSessionTemplate sqlSession, ChatRoom chatRoom) {
        return sqlSession.insert("chatMapper.insertChatRoom", chatRoom);
    }

     public int insertChatRoomMember(SqlSessionTemplate sqlSession, ChatRoomMember chatRoomMember) {
        return sqlSession.insert("chatMapper.insertChatRoomMember", chatRoomMember);
    }
     
     public ChatRoom findExistingPrivateChatRoom(SqlSessionTemplate sqlSession, int emp1, int emp2) {
         Map<String, Object> params = new HashMap<>();
         params.put("emp1", emp1);
         params.put("emp2", emp2);
         // chatMapper.findExistingPrivateChatRoom 쿼리 실행
         return sqlSession.selectOne("chatMapper.findExistingPrivateChatRoom", params);
     }
	

     public int updateLastReadMessageNo(SqlSessionTemplate sqlSession, Map<String, Object> params) {

         return sqlSession.update("chatMapper.updateLastReadMessageNo", params);
     }

}
