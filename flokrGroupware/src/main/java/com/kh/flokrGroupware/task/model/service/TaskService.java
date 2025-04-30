package com.kh.flokrGroupware.task.model.service;

import java.util.ArrayList;

import com.kh.flokrGroupware.attachment.model.vo.Attachment;
import com.kh.flokrGroupware.task.model.vo.Task;

public interface TaskService {
	
	// 업무 리스트
	ArrayList<Task> taskList(int empNo);
	
	// 새 업무 추가
	int taskInsert(Task task, Attachment atmt);
	
	// 업무 상세조회
	Task taskDetail(int taskNo);

}
