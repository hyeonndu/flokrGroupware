package com.kh.flokrGroupware.task.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.flokrGroupware.attachment.model.vo.Attachment;
import com.kh.flokrGroupware.task.model.vo.Task;

@Repository
public class TaskDao {
	
	public ArrayList<Task> taskList(SqlSessionTemplate sqlSession, int empNo) {
		return (ArrayList)sqlSession.selectList("taskMapper.taskList", empNo);
	}
	
	public int taskInsert(SqlSessionTemplate sqlSession, Task task) {
		return sqlSession.insert("taskMapper.taskInsert", task);
	}
	
	public int insertAttachment(SqlSessionTemplate sqlSession, Attachment atmt) {
		return sqlSession.insert("taskMapper.insertAttachment", atmt);
	}
	
	public Task taskDetail(SqlSessionTemplate sqlSession, int taskNo) {
		return sqlSession.selectOne("taskMapper.taskDetail", taskNo);
	}
	
	public Attachment getAttachment(SqlSessionTemplate sqlSession, int taskNo) {
		return sqlSession.selectOne("taskMapper.getAttachment", taskNo);
	}
	
	public int attachmentDelete(SqlSessionTemplate sqlSession, Attachment atmt) {
		return sqlSession.update("taskMapper.attachmentDelete", atmt);
	}
	
	public int taskUpdate(SqlSessionTemplate sqlSession, Task task) {
		return sqlSession.update("taskMapper.taskUpdate", task);
	}
	
	public int newAttachment(SqlSessionTemplate sqlSession, Attachment atmt) {
		return sqlSession.insert("taskMapper.newAttachment", atmt);
	}
	
	public Task selectRecentTask(SqlSessionTemplate sqlSession, Task task) {
	    return sqlSession.selectOne("taskMapper.selectRecentTask", task);
	}

}
