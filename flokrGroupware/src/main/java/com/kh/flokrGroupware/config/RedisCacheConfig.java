package com.kh.flokrGroupware.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;

/**
 * Redis 캐싱 설정 클래스
 * 캐싱 기능을 사용하기 위한 기본 설정을 제공함
 */
@Configuration 	// 스프링 설정 클래스임을 나타냄
@EnableCaching 	// 캐싱 기능 활성화
public class RedisCacheConfig {
	
	// application.properties에서 Redis 서버 정보 가져오기
	@Value("${spring.redis.host:localhost}") // 기본값은 localhost
	private String redisHost;
	
	@Value("${spring.redis.port:6379}") // 기본값은 6379
	private int redisPort;
	
	/**
	 * Redis 연결 팩토리 생성
	 * Redis 서버와의 연결을 설정함
	 */
	@Bean
	public JedisConnectionFactory jedisConnectionFactory() {
		RedisStandaloneConfiguration config = new RedisStandaloneConfiguration(redisHost, redisPort);
		return new JedisConnectionFactory(config);
	}
	

}
