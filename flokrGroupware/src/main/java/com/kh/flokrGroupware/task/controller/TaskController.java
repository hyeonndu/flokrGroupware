package com.kh.flokrGroupware.task.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/task")
public class TaskController {
	
	@RequestMapping("/list")
	public String taskList(Model model) {
	    model.addAttribute("currentPage", "taskList");
	    return "task/taskListView";
	}
	
	@RequestMapping("/detail")
    public String taskDetail() {
        return "task/taskDetailView";
    }
	
	@RequestMapping("/insert")
    public String taskInsert() {
		return "task/taskInsertForm";
    }

}
