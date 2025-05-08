package com.kh.flokrGroupware.chat.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
        newRoom.setCreatedByEmpNo(creatorEmpNo);
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
        // --- DAO로 넘길 파라미터 맵 생성 ---
        Map<String, Object> params = new HashMap<>();
        params.put("empNo", empNo); // "empNo"라는 키로 empNo 값을 Map에 담습니다.

        // --- ChatDAO의 findMyChatRooms 메소드 호출 ---
        // SqlSessionTemplate와 파라미터 맵을 DAO 메소드에 전달합니다.
        ArrayList<ChatRoom> chatRoomList = cDao.findMyChatRooms(sqlSession, params); // <-- 여기 수정

        // 반환 타입에 맞게 형변환하여 반환
        return chatRoomList;
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

	@Override
	@Transactional
	public ChatRoom createPrivateChatRoom(ArrayList<Integer> participants, int creatorEmpNo) {
        // 1:1 채팅방 생성 로직
        if (participants == null || participants.size() != 2) {
            throw new IllegalArgumentException("1:1 채팅방은 정확히 2명의 참여자가 필요합니다.");
        }

        // 1:1 채팅 상대방 empNo 찾기 (자신을 제외한 나머지 한 명)
        int participantEmpNo = (participants.get(0) == creatorEmpNo) ? participants.get(1) : participants.get(0);

        // TODO: 이미 존재하는 1:1 채팅방인지 확인하는 로직 활성화
        // SqlSessionTemplate 객체를 DAO 메소드에 파라미터로 전달하는 방식 대신,
        // DAO에서 SqlSessionTemplate을 직접 사용하도록 변경했으므로 호출 방식 수정
        ChatRoom existingRoom = cDao.findExistingPrivateChatRoom(sqlSession, creatorEmpNo, participantEmpNo);
        if (existingRoom != null) {
            // 이미 존재하면 기존 방 정보 반환
            // Controller에서 이 반환 값을 확인하여 적절한 응답을 보낼 수 있습니다.
            // 예: 이미 존재하는 방이라고 알리거나, 해당 방으로 리다이렉트
             System.out.println("Service: Existing private chat room found: " + existingRoom.getRoomNo());
            return existingRoom;
        }


        // 1. ChatRoom 객체 생성 (1:1 채팅)
        ChatRoom newRoom = new ChatRoom();
        newRoom.setRoomType("P"); // Private (1:1) 채팅
        newRoom.setCreatedByEmpNo(creatorEmpNo);
        // 1:1 채팅방 이름은 참여자 이름 조합 또는 상대방 이름으로 설정 (프론트/백엔드 협의)
        // 여기서는 일단 null로 두고, 목록 조회 시 이름을 조합해서 보여주도록 함
        newRoom.setRoomName(null); // 1:1 채팅방 이름은 DB에 저장하지 않거나 null로 설정

        // 2. CHAT_ROOM 테이블에 삽입
        int roomResult = cDao.insertChatRoom(sqlSession, newRoom);

        if (roomResult <= 0 || newRoom.getRoomNo() == 0) {
             throw new RuntimeException("1:1 채팅방 생성에 실패했습니다.");
        }

        // 3. CHAT_ROOM_MEMBER 테이블에 참여자들 추가
        int memberResultSum = 0;
        for (Integer empNo : participants) {
            ChatRoomMember member = new ChatRoomMember();
            member.setRoomNo(newRoom.getRoomNo()); // selectKey로 받아온 roomNo 사용
            member.setEmpNo(empNo);
            member.setIsAdmin(empNo == creatorEmpNo ? "Y" : "N"); // 생성자만 방장
            // 다른 필드는 기본값 사용

            memberResultSum += cDao.insertChatRoomMember(sqlSession, member);
        }

        // 참여자 수만큼 멤버가 제대로 추가되었는지 확인
        if (memberResultSum != participants.size()) {
             throw new RuntimeException("1:1 채팅방 멤버 추가에 실패했습니다.");
        }

        // 4. 생성된 ChatRoom 객체 반환 (필요하다면 DB에서 다시 조회하여 완전한 정보 로드)
        // return cDao.findRoomById(newRoom.getRoomNo()); // 필요시 주석 해제하여 상세 정보 조회
         return newRoom; // 기본 정보만 반환
	}

	@Override
	@Transactional
	public ChatRoom createGroupChatRoom(String roomName, ArrayList<Integer> participants, int creatorEmpNo) {
        // 단체 채팅방 생성 로직
        if (roomName == null || roomName.trim().isEmpty()) {
            throw new IllegalArgumentException("단체 채팅방 이름은 필수입니다.");
        }
        if (participants == null || participants.size() < 2) { // 자신 포함 최소 2명
             throw new IllegalArgumentException("단체 채팅방은 두 명 이상의 참여자가 필요합니다.");
        }

        // 1. ChatRoom 객체 생성 (단체 채팅)
        ChatRoom newRoom = new ChatRoom();
        newRoom.setRoomName(roomName.trim());
        newRoom.setRoomType("G"); // Group (단체) 채팅
        newRoom.setCreatedByEmpNo(creatorEmpNo);
        // createDate, status는 DB에서 자동 설정

        // 2. CHAT_ROOM 테이블에 삽입
        int roomResult = cDao.insertChatRoom(sqlSession, newRoom);

        if (roomResult <= 0 || newRoom.getRoomNo() == 0) {
             throw new RuntimeException("단체 채팅방 생성에 실패했습니다.");
        }

        // 3. CHAT_ROOM_MEMBER 테이블에 참여자들 추가
        int memberResultSum = 0;
        for (Integer empNo : participants) {
            ChatRoomMember member = new ChatRoomMember();
            member.setRoomNo(newRoom.getRoomNo()); // selectKey로 받아온 roomNo 사용
            member.setEmpNo(empNo);
            member.setIsAdmin(empNo == creatorEmpNo ? "Y" : "N"); // 생성자만 방장
             // 다른 필드는 기본값 사용

            memberResultSum += cDao.insertChatRoomMember(sqlSession, member);
        }

        // 참여자 수만큼 멤버가 제대로 추가되었는지 확인
        if (memberResultSum != participants.size()) {
             throw new RuntimeException("단체 채팅방 멤버 추가에 실패했습니다.");
        }

        // 4. 생성된 ChatRoom 객체 반환 (필요하다면 DB에서 다시 조회하여 완전한 정보 로드)
        // return cDao.findRoomById(sqlSession, newRoom.getRoomNo()); // 필요시 주석 해제하여 상세 정보 조회
         return newRoom; // 기본 정보만 반환
	}

	@Override
	public ChatRoom findExistingPrivateChatRoom(int emp1, int emp2) {
		return cDao.findExistingPrivateChatRoom(sqlSession, emp1, emp2);
	}

	@Override
	@Transactional
	public void markMessagesAsRead(int roomNo, int userEmpNo) {
        // --- DAO로 넘길 파라미터 맵 생성 ---
        Map<String, Object> params = new HashMap<>();
        params.put("roomNo", roomNo); // "roomNo"라는 키로 roomNo 값을 Map에 담습니다.
        params.put("userEmpNo", userEmpNo); // "userEmpNo"라는 키로 userEmpNo 값을 Map에 담습니다.

        // --- ChatDAO의 updateLastReadMessageNo 메소드 호출 ---
        // SqlSessionTemplate와 파라미터 맵을 DAO 메소드에 전달합니다.
        cDao.updateLastReadMessageNo(sqlSession, params); // <-- 여기 수정
	}

	
	


}
