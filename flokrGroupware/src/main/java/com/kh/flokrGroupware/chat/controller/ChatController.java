package com.kh.flokrGroupware.chat.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.flokrGroupware.chat.model.service.ChatServiceImpl;
import com.kh.flokrGroupware.chat.model.vo.ChatRoom;
import com.kh.flokrGroupware.employee.model.vo.Employee;

public class ChatController {
	
	@Autowired
	private ChatServiceImpl cService;
	
	/** 
	 * 내 채팅 목록 페이지 로드 및 목록 조회
	 * @param session 현재 사용자 정보를 얻기 위한 세션 객체
	 * @param mv      데이터와 뷰 정보를 담을 ModelAndView 객체
	 * @return ModelAndView 객체 
	 */
	@RequestMapping("chat.ch")
	public ModelAndView findMyChatRooms(HttpSession session, ModelAndView mv) {
		
		// 1. 세션에서 로그인한 사용자 정보 가져오기
        Employee loginUser = (Employee) session.getAttribute("loginUser");
        
        // 2. 로그인 상태 확인 (로그인 안 했으면 로그인 페이지로 리다이렉트 등 처리)
        if (loginUser == null) {
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
        
        // 5. 조회된 목록을 ModelAndView 에 담기
        mv.addObject("chatRoomList", chatRoomList); // JSTL 등에서 사용할 이름 지정

        // 6. 보여줄 View(JSP) 경로 설정
        mv.setViewName("chat/chat"); // 예시 경로: /WEB-INF/views/chat/chatListView.jsp

        // 7. ModelAndView 반환
        return mv;
		
		
	}

}
