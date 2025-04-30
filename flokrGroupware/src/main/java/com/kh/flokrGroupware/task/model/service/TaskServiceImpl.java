package com.kh.flokrGroupware.task.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.flokrGroupware.attachment.model.vo.Attachment;
import com.kh.flokrGroupware.task.model.dao.TaskDao;
import com.kh.flokrGroupware.task.model.vo.Task;

@Service
public class TaskServiceImpl implements TaskService {
	
	@Autowired
	private TaskDao tDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<Task> taskList(int empNo) {
		return tDao.taskList(sqlSession, empNo);
	}

	@Override
	@Transactional
	public int taskInsert(Task task, Attachment atmt) {
	    int result1 = tDao.taskInsert(sqlSession, task);
	    int result2 = 1;

	    if (atmt != null) {
	        result2 = tDao.insertAttachment(sqlSession, atmt);
	    }

	    return result1 * result2;
	}


	@Override
	public Task taskDetail(int taskNo) {
		return null;
	}

}
