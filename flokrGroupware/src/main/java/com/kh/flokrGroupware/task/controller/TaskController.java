package com.kh.flokrGroupware.task.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TaskController {
	
	@RequestMapping("taskList.ta")
	public String selectTaskList() {
		return "task/taskListView";
	}

}
