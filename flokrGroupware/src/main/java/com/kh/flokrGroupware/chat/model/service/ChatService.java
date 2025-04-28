package com.kh.flokrGroupware.chat.model.service;

import java.util.ArrayList;

import com.kh.flokrGroupware.chat.model.vo.ChatMessage;
import com.kh.flokrGroupware.chat.model.vo.ChatRoom;
import com.kh.flokrGroupware.employee.model.vo.Employee;

public interface ChatService {
	
	
	// --- 채팅방 관리 ---
	
	/**
     * 새로운 채팅방 생성
     * @param roomName 생성할 채팅방 이름
     * @param creatorEmpId 생성자 직원 ID (Employee의 empId)
     * @return 생성된 채팅방 정보 (ChatRoom 객체) 또는 생성된 roomNo (int/long)
	 */
	ChatRoom createChatRoom(String roomName, String creatorEmpId);
	
    /**
     * 사용자가 참여하고 있는 채팅방 목록 조회
     * @param empId 직원 ID
     * @return 해당 직원이 참여중인 채팅방 목록
     */
    ArrayList<ChatRoom> findMyChatRooms(String empId);

    /**
     * 특정 채팅방 정보 조회
     * @param roomId 채팅방 번호
     * @return 채팅방 상세 정보
     */
    ChatRoom findChatRoomById(int roomId); // 또는 long roomId

    /**
     * 채팅방 이름 변경 (선택 사항)
     * @param roomId 변경할 채팅방 번호
     * @param newRoomName 새로운 채팅방 이름
     * @param empId 요청한 직원 ID (권한 확인용)
     * @return 성공 여부 (int)
     */
    int updateChatRoomName(int roomId, String newRoomName, String empId);

    /**
     * 채팅방 삭제 (선택 사항 - 실제 삭제 또는 상태 변경)
     * @param roomId 삭제할 채팅방 번호
     * @param empId 요청한 직원 ID (권한 확인용)
     * @return 성공 여부 (int)
     */
    int deleteChatRoom(int roomId, String empId);
    

    // --- 메시지 처리 ---

    /**
     * 채팅 메시지 처리 (DB 저장 및 WebSocket 전송)
     * ChatController 에서 호출되어 메시지를 받아 처리합니다.
     * 내부적으로 DB 저장 후, SimpMessagingTemplate 를 이용해 구독자에게 메시지를 보냅니다.
     * @param message 수신된 채팅 메시지 객체
     */
    void processAndSendMessage(ChatMessage message);

    /**
     * 특정 채팅방의 이전 대화 내역 조회
     * @param roomId 대화 내역을 조회할 채팅방 번호
     * @return 해당 채팅방의 메시지 목록
     */
    ArrayList<ChatMessage> getChatHistory(int roomId);
    
    // --- 채팅방 참여자 관리 ---

    /**
     * 특정 채팅방에 사용자 초대 (또는 추가)
     * @param roomId 대상 채팅방 번호
     * @param inviterEmpId 초대한 직원 ID
     * @param inviteeEmpId 초대받은 직원 ID (또는 ID 목록 List<String>)
     * @return 성공 여부 (int)
     */
    int inviteUserToRoom(int roomId, String inviterEmpId, String inviteeEmpId);
    // 또는 int inviteUsersToRoom(int roomId, String inviterEmpId, List<String> inviteeEmpIds);

    /**
     * 사용자가 채팅방 나가기
     * @param roomId 나갈 채팅방 번호
     * @param empId 나가는 직원 ID
     * @return 성공 여부 (int)
     */
    int leaveChatRoom(int roomId, String empId);

    /**
     * 특정 채팅방의 참여자 목록 조회
     * @param roomId 조회할 채팅방 번호
     * @return 해당 채팅방에 참여중인 직원 목록 (Employee 객체 리스트 또는 empId 리스트)
     */
    ArrayList<Employee> findChatRoomMembers(int roomId); // 또는 List<String> findChatRoomMemberIds(int roomId);

    /**
     * 사용자가 특정 채팅방의 멤버인지 확인
     * @param roomId 확인할 채팅방 번호
     * @param empId 확인할 직원 ID
     * @return 멤버 여부 (boolean 또는 int count)
     */
    boolean isUserInRoom(int roomId, String empId); // 또는 int checkUserInRoom(...)



    

}
