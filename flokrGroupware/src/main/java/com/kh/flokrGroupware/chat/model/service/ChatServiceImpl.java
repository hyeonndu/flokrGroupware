package com.kh.flokrGroupware.chat.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.flokrGroupware.chat.model.dao.ChatDao;
import com.kh.flokrGroupware.chat.model.vo.ChatMessage;
import com.kh.flokrGroupware.chat.model.vo.ChatRoom;
import com.kh.flokrGroupware.chat.model.vo.ChatRoomMember;
import com.kh.flokrGroupware.employee.model.vo.Employee;

@Service
public class ChatServiceImpl implements ChatService{
	
	@Autowired
	private ChatDao cDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private SimpMessagingTemplate messagingTemplate; // WebSocket 메시지 전송용 객체 주입

	@Override
	@Transactional
	public ChatRoom createChatRoom(String roomName, int creatorEmpNo) {
        // 1. ChatRoom 객체 생성 및 필요한 정보 설정
        ChatRoom newRoom = new ChatRoom();
        newRoom.setRoomName(roomName);
        newRoom.setRoomType("G"); // 예: 그룹 채팅방으로 설정
        newRoom.setCreateByEmpNo(creatorEmpNo);
        // createDate와 status는 DB에서 자동 설정 또는 기본값 사용

        // 2. DAO를 통해 CHAT_ROOM 테이블에 삽입
        int result = cDao.insertChatRoom(sqlSession, newRoom);

        if (result > 0) {
            // 3. (선택 사항) 채팅방 생성자(creatorEmpNo)를 CHAT_ROOM_MEMBER 테이블에 추가
            ChatRoomMember creatorMember = new ChatRoomMember();
            creatorMember.setRoomNo(newRoom.getRoomNo()); // selectKey로 받아온 roomNo 사용
            creatorMember.setEmpNo(creatorEmpNo);
            creatorMember.setIsAdmin("Y"); // 방장으로 설정
            // joinDate, lastReadMessageNo, notificationEnabled, status는 기본값 사용

            int memberResult = cDao.insertChatRoomMember(sqlSession, creatorMember);

            if (memberResult > 0) {
                // 4. 성공 시 생성된 ChatRoom 객체 반환
                return newRoom;
            } else {
                // 멤버 추가 실패 시 롤백 처리 (Transactional 어노테이션으로 자동 처리)
                throw new RuntimeException("채팅방 멤버 추가에 실패했습니다.");
            }
        } else {
            // 채팅방 생성 실패
            return null;
        }
	}

	@Override
	public ArrayList<ChatRoom> findMyChatRooms(int empNo) {
		return cDao.findMyChatRooms(sqlSession, empNo);
	}

	@Override
	public ChatRoom findChatRoomById(int roomNo) {
		
		return cDao.findRoomById(sqlSession, roomNo);
		
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
	@Transactional
	public void processAndSendMessage(ChatMessage message) {
		
		System.out.println("Service: Processing message for room " + message.getRoomNo());
		
		// 1. (선택 사항) 메시지 내용 보강 (서버 시간, 발신자 정보 등)
		//    - 클라이언트가 보낸 시간 대신 서버 시간 사용 등
		// message.setSendDate(new Date()); // ChatMessage의 sendDate 타입이 Date일 경우

		//    - 발신자 이름, 프로필 사진 경로 등 추가 (DB 조회 필요)
		// Employee sender = employeeService.selectEmployee(message.getSenderEmpNo());
		// if (sender != null) {
		//     message.setSenderName(sender.getEmpName());
		//     message.setSenderProfileImgPath(sender.getProfileImgPath());
		// }

		// 2. DB에 메시지 저장
		try {
			int result = cDao.insertChatMessage(sqlSession, message); // DAO 호출
			System.out.println("Service: Message inserted to DB, result: " + result + ", messageNo: " + message.getMessageNo()); // messageNo 확인 (selectKey 사용 시)

			if (result > 0) {
				// 3. 해당 채팅방 구독자들에게 메시지 브로드캐스팅
				String destination = "/topic/chat/room/" + message.getRoomNo();
				System.out.println("Service: Broadcasting message to: " + destination);

				// messagingTemplate을 사용하여 메시지 전송
				// Spring이 message 객체를 자동으로 JSON으로 변환하여 전송
				messagingTemplate.convertAndSend(destination, message); // 보강된 message 객체 전송

			} else {
				System.err.println("Service: Failed to insert message into DB.");
				// DB 저장 실패 시 브로드캐스팅하지 않음
			}
		} catch (Exception e) {
			System.err.println("Service: Error during processAndSendMessage");
			e.printStackTrace();
			// 예외 발생 시 @Transactional에 의해 롤백될 수 있음 (설정에 따라 다름)
			// 여기서 예외를 다시 던져서 Controller에서도 알 수 있게 할 수도 있음
			// throw new RuntimeException("Error processing chat message", e);
		}
		
		
		
	}

	@Override
	public ArrayList<ChatMessage> getChatHistory(int roomNo) {
		return cDao.findMessagesByRoomId(sqlSession, roomNo);
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
        // Mapper의 checkUserInRoom 메소드 호출하여 결과(count) 받기
        int count = cDao.checkUserInRoom(sqlSession, roomNo, empNo);
        // count가 0보다 크면 (즉, 1 이상이면) 멤버이므로 true, 아니면 false 반환
        return count > 0;
	}



}
