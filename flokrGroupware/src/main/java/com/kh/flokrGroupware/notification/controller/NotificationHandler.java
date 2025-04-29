package com.kh.flokrGroupware.notification.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.flokrGroupware.employee.model.vo.Employee;
import com.kh.flokrGroupware.notification.model.service.NotificationService;

public class NotificationHandler extends TextWebSocketHandler {
    
    // 재연결 시도 횟수 제한 추가
    private static final int MAX_RECONNECT_ATTEMPTS = 5;
    private Map<Integer, Integer> reconnectAttempts = new HashMap<>();
    
    @Autowired
    private NotificationService notificationService;
    
    private ObjectMapper objectMapper = new ObjectMapper();
    
    // 세션 저장소: Key - 사원 번호, Value - WebSocketSession
    private Map<Integer, WebSocketSession> userSessions = new HashMap<>();
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 세션에서 사용자 정보 가져오기
        Map<String, Object> attributes = session.getAttributes();
        Employee loginUser = (Employee) attributes.get("loginUser");
        
        if(loginUser != null) {
            userSessions.put(loginUser.getEmpNo(), session);
            System.out.println("WebSocket 연결 성공: " + loginUser.getEmpName() + "(" + loginUser.getEmpId() + ")");
            
            // 사용자의 읽지 않은 알림 목록 조회 및 전송
            sendUnreadNotifications(loginUser.getEmpNo(), session);
        }
    }
    
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // 클라이언트로부터 받은 메시지 처리
        String payload = message.getPayload();
        Map<String, Object> data = objectMapper.readValue(payload, Map.class);
        
        String type = (String) data.get("type");
        
        if("read".equals(type)) {
            // 알림 읽음 처리
            int notificationNo = (Integer) data.get("notificationNo");
            Map<String, Object> attributes = session.getAttributes();
            Employee loginUser = (Employee) attributes.get("loginUser");
            
            if(loginUser != null) {
                notificationService.markAsRead(notificationNo, loginUser.getEmpNo());
            }
        }
    }
    
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        // 전송 오류 처리 추가
        Map<String, Object> attributes = session.getAttributes();
        Employee loginUser = (Employee) attributes.get("loginUser");
        
        if(loginUser != null) {
            Integer attempts = reconnectAttempts.getOrDefault(loginUser.getEmpNo(), 0);
            reconnectAttempts.put(loginUser.getEmpNo(), attempts + 1);
            
            System.out.println("WebSocket 전송 오류 발생: " + loginUser.getEmpName() + "(" + loginUser.getEmpId() + ") - 재시도: " + (attempts + 1));
            
            if(attempts >= MAX_RECONNECT_ATTEMPTS) {
                System.out.println("최대 재연결 시도 횟수 초과: " + loginUser.getEmpNo());
                userSessions.remove(loginUser.getEmpNo());
                reconnectAttempts.remove(loginUser.getEmpNo());
            }
        }
    }
    
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        // 연결 종료 처리
        Map<String, Object> attributes = session.getAttributes();
        Employee loginUser = (Employee) attributes.get("loginUser");
        
        if(loginUser != null) {
            userSessions.remove(loginUser.getEmpNo());
            reconnectAttempts.remove(loginUser.getEmpNo()); // 재연결 시도 횟수 리셋
            System.out.println("WebSocket 연결 종료: " + loginUser.getEmpName() + "(" + loginUser.getEmpId() + ")");
        }
    }
    
    // 읽지 않은 알림 목록 전송
    private void sendUnreadNotifications(int empNo, WebSocketSession session) {
        try {
            List<Map<String, Object>> notifications = notificationService.getUnreadNotifications(empNo);
            
            Map<String, Object> response = new HashMap<>();
            response.put("type", "unread");
            response.put("notifications", notifications);
            
            session.sendMessage(new TextMessage(objectMapper.writeValueAsString(response)));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 특정 사용자에게 알림 전송
    public void sendNotification(int empNo, String type, String title, String content, String refType, String refNo) {
        WebSocketSession session = userSessions.get(empNo);
        
        if(session != null && session.isOpen()) {
            try {
                Map<String, Object> notification = new HashMap<>();
                notification.put("type", "new");
                notification.put("notificationType", type);
                notification.put("title", title);
                notification.put("content", content);
                notification.put("refType", refType);
                notification.put("refNo", refNo);
                notification.put("time", new Date());
                
                session.sendMessage(new TextMessage(objectMapper.writeValueAsString(notification)));
                
                // DB에 알림 저장
                notificationService.saveNotification(empNo, type, title, content, refType, refNo);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // 사용자가 오프라인일 경우 DB에만 저장
            notificationService.saveNotification(empNo, type, title, content, refType, refNo);
        }
    }
    
    // 모든 사용자에게 알림 전송
    public void sendNotificationToAll(String type, String title, String content, String refType, String refNo) {
        // DB에 모든 사용자를 위한 알림 저장
        notificationService.saveNotificationForAll(type, title, content, refType, refNo);
        
        // 온라인 사용자에게 실시간 알림 전송
        for(WebSocketSession session : userSessions.values()) {
            if(session.isOpen()) {
                try {
                    Map<String, Object> notification = new HashMap<>();
                    notification.put("type", "new");
                    notification.put("notificationType", type);
                    notification.put("title", title);
                    notification.put("content", content);
                    notification.put("refType", refType);
                    notification.put("refNo", refNo);
                    notification.put("time", new Date());
                    
                    session.sendMessage(new TextMessage(objectMapper.writeValueAsString(notification)));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    // 특정 부서에 알림 전송
    public void sendNotificationToDepartment(int deptNo, String type, String title, String content, String refType, String refNo) {
        // DB에 부서 사용자를 위한 알림 저장
        notificationService.saveNotificationForDepartment(deptNo, type, title, content, refType, refNo);
        
        // 온라인 사용자 중 해당 부서 직원에게 실시간 알림 전송
        for(Map.Entry<Integer, WebSocketSession> entry : userSessions.entrySet()) {
            WebSocketSession session = entry.getValue();
            if(session.isOpen()) {
                try {
                    Map<String, Object> attributes = session.getAttributes();
                    Employee loginUser = (Employee) attributes.get("loginUser");
                    
                    if(loginUser != null && loginUser.getDeptNo() == deptNo) {
                        Map<String, Object> notification = new HashMap<>();
                        notification.put("type", "new");
                        notification.put("notificationType", type);
                        notification.put("title", title);
                        notification.put("content", content);
                        notification.put("refType", refType);
                        notification.put("refNo", refNo);
                        notification.put("time", new Date());
                        
                        session.sendMessage(new TextMessage(objectMapper.writeValueAsString(notification)));
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}