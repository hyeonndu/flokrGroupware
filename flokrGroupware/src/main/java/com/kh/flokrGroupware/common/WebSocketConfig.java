package com.kh.flokrGroupware.common;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
	
    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        // SimpleBroker: /topic (1:N), /queue (1:1, @SendToUser 사용 시) 목적지 처리
        config.enableSimpleBroker("/topic", "/queue");
        // 클라이언트 -> 서버 메시지 라우팅 prefix (Controller의 @MessageMapping으로 연결됨)
        config.setApplicationDestinationPrefixes("/app");
        // 사용자 특정 메시지 prefix (optional, 필요시 사용)
        // config.setUserDestinationPrefix("/user");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // 클라이언트가 WebSocket 연결을 시작할 주소
        registry.addEndpoint("/ws-stomp") // 예: ws://localhost:8008/flokrGroupware/ws-stomp
                .setAllowedOrigins("http://localhost:8008")   // 모든 Origin 허용 (개발용(*). 실제 운영 시에는 필요한 도메인만 명시)
                //.setAllowedOriginPatterns("*") (개발 끝나면 바꾸는게 좋음)
                .withSockJS();            // WebSocket 미지원 브라우저 위한 SockJS fallback 활성화
    }
	
	
}
