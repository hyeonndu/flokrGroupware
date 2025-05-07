package com.kh.flokrGroupware.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.flokrGroupware.chat.model.service.ChatServiceImpl;
import com.kh.flokrGroupware.chat.model.vo.ChatMessage;
import com.kh.flokrGroupware.chat.model.vo.ChatRoom;
import com.kh.flokrGroupware.employee.model.vo.Employee;

import lombok.RequiredArgsConstructor;

@Controller
public class ChatController {
	
	@Autowired
	private ChatServiceImpl cService;
	
	/** 
	 * 내 채팅 목록 페이지 로드 및 목록 조회
	 * @param session 현재 사용자 정보를 얻기 위한 세션 객체
	 * @param mv      데이터와 뷰 정보를 담을 ModelAndView 객체
	 * @return ModelAndView 객체 
	 */
	@RequestMapping("chatList.ch")
	public ModelAndView findMyChatRooms(HttpSession session, ModelAndView mv) {
		System.out.println("findMyChatRooms 메소드 실행됨");
		// 1. 세션에서 로그인한 사용자 정보 가져오기
        Employee loginUser = (Employee) session.getAttribute("loginUser");
        
        // 2. 로그인 상태 확인 (로그인 안 했으면 로그인 페이지로 리다이렉트 등 처리)
        if (loginUser == null) {
        	
        	System.out.println("로그인 사용자 정보 없음!");
        	
        	// 예시: 로그인 페이지로 리다이렉트 (세션에 alertMsg 추가 가능)
            session.setAttribute("alertMsg", "로그인이 필요한 서비스입니다.");
            mv.setViewName("redirect:/"); // 또는 로그인 페이지 경로
            return mv;
        }
        
        // 3. 로그인한 사용자의 empNo 가져오기
        int empNo = loginUser.getEmpNo();

        // 4. ChatService 호출하여 해당 사용자의 채팅방 목록 조회
        //    (반환 타입은 List<ChatRoom> 또는 필요시 ArrayList<ChatRoom>)
        ArrayList<ChatRoom> chatRoomList = cService.findMyChatRooms(empNo);
        System.out.println(chatRoomList);
        

        // 5. 조회된 목록을 ModelAndView 에 담기
        mv.addObject("chatRoomList", chatRoomList); // JSTL 등에서 사용할 이름 지정

        // 6. 보여줄 View(JSP) 경로 설정
        mv.setViewName("chat/chatList"); // 예시 경로: /WEB-INF/views/chat/chatListView.jsp

        // 7. ModelAndView 반환
        return mv;
		
	}
	
	/**
	 * 특정 채팅방의 대화 내역 및 정보를 조회하여 JSON으로 반환
	 * @param roomNo 요청 파라미터로 전달된 채팅방 번호
	 * @param session 
	 * @return 채팅방 정보와 메시지 목록을 담은 Map (JSON으로 변환됨)
	 */
	@ResponseBody
	@RequestMapping(value="chatMessage.ch/{roomNo}", produces="application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> getChatHistory(@PathVariable("roomNo") int roomNo, HttpSession session) {
		
		Map<String, Object> response = new HashMap<>();
		
		// (보안 강화) 현재 사용자가 해당 roomNo에 접근 권한이 있는지 확인하는 로직 추가 권장
		
		Employee loginUser = (Employee) session.getAttribute("loginUser");
		
		if(loginUser == null || !cService.isUserInRoom(roomNo, loginUser.getEmpNo())) {
			System.out.println("[ERROR] ChatController: 로그인 사용자 없음");
			response.put("error", "접근 권한이 없습니다.");
			return new ResponseEntity<>(response, HttpStatus.FORBIDDEN);
		}
		
		int empNo = loginUser.getEmpNo();
	    System.out.println("ChatController: 현재 사용자 empNo = " + empNo); // 추가
	    
	    // (보안 확인 로직)
	    if (!cService.isUserInRoom(roomNo, empNo)) {
	         System.out.println("[ERROR] ChatController: 사용자가 방 멤버 아님 (roomNo: " + roomNo + ", empNo: " + empNo + ")"); // 추가
	         // ...
	         return new ResponseEntity<>(response, HttpStatus.FORBIDDEN);
	    }

		
		
		try {
            // 1. 채팅방 정보 조회 (헤더 업데이트용)
            //    findChatRoomById는 방 정보 외에 상대방 정보 등 필요한 값을 같이 반환하도록 수정될 수 있음
			System.out.println("ChatController: chatService.findChatRoomById 호출 전");
			ChatRoom roomInfo = cService.findChatRoomById(roomNo);
			System.out.println("ChatController: chatService.findChatRoomById 호출 후, roomInfo: " + roomInfo); // 추가 (roomInfo가 null인지 확인)
			
            // 2. 메시지 목록 조회
			System.out.println("ChatController: chatService.getChatHistory 호출 전");
            ArrayList<ChatMessage> messages = cService.getChatHistory(roomNo);
            System.out.println("ChatController: chatService.getChatHistory 호출 후, messages size: " + (messages == null ? "null" : messages.size())); // 추가 (null 또는 size 확인)

            response.put("room", roomInfo);   // 채팅방 정보 추가
            response.put("messages", messages); // 메시지 목록 추가
            System.out.println("ChatController: 응답 생성 완료, response: " + response); // 추가
            return ResponseEntity.ok(response); // 200 OK 와 함께 데이터 반환

        } catch (Exception e) {
            // 예외 처리
        	System.err.println("[ERROR] ChatController: getChatHistory 처리 중 예외 발생!"); 
        	e.printStackTrace();
        	response.put("error", "데이터 조회 중 오류 발생");
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR); // 500 Internal Server Error
        }
		
	}
	
	// ================================================================
	//          WebSocket 메시지 처리 메소드 추가
	// ================================================================
	
	@MessageMapping("/chat/message")
	public void handleChatMessage(@Payload ChatMessage chatMessage) {
		System.out.println("WebSocket Message received: " + chatMessage);
		
		// TODO: 여기에 필요한 로직 추가 가능
		// 예: 메시지 수신 시간 설정 (서버 시간 기준)
		// chatMessage.setSendDate(new java.util.Date()); // Date 타입으로 변경 필요 시
		// 예: 보낸 사람의 정보가 누락되었다면 세션 등에서 가져와 설정 (보안 강화)
		// if (chatMessage.getSenderEmpNo() == 0) { /* 세션에서 가져오기 등 */ }

		// Service 계층으로 메시지 전달하여 DB 저장 및 브로드캐스팅 처리 요청
		try {
			cService.processAndSendMessage(chatMessage); //
		} catch (Exception e) {
			System.err.println("[ERROR] ChatController: handleChatMessage 처리 중 예외 발생!");
			e.printStackTrace();
			// 클라이언트에게 직접 오류를 알리기는 어려움 (별도 에러 채널 구독 필요)
			// 로깅을 철저히 하는 것이 중요
		}
		
	}
	
	/**
     * 새로운 채팅방 생성 요청 처리
     * (예: AJAX 요청으로 처리)
     * @param roomName 생성할 채팅방 이름 (요청 파라미터)
     * @param session 현재 사용자 정보를 얻기 위한 세션 객체
     * @return 생성 결과 (JSON 응답)
	 */
	@RequestMapping(value="createChatRoom.ch", method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> createChatRoom(@RequestParam("roomName") String roomName, HttpSession session) {
		
        Map<String, Object> response = new HashMap<>();

        Employee loginUser = (Employee) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요한 서비스입니다.");
            return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED); // 401 Unauthorized
        }

        int creatorEmpNo = loginUser.getEmpNo();

        try {
            ChatRoom createdRoom = cService.createChatRoom(roomName, creatorEmpNo);

            if (createdRoom != null) {
                response.put("success", true);
                response.put("message", "채팅방이 성공적으로 생성되었습니다.");
                response.put("room", createdRoom); // 생성된 방 정보 반환
                return ResponseEntity.ok(response); // 200 OK
            } else {
                response.put("success", false);
                response.put("message", "채팅방 생성에 실패했습니다.");
                return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR); // 500 Internal Server Error
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "채팅방 생성 중 오류가 발생했습니다.");
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR); // 500 Internal Server Error
        }
		
		
	}
	
	
	


}
