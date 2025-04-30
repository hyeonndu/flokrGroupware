package com.kh.flokrGroupware.task.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.flokrGroupware.attachment.model.vo.Attachment;
import com.kh.flokrGroupware.employee.model.vo.Employee;
import com.kh.flokrGroupware.task.model.service.TaskServiceImpl;
import com.kh.flokrGroupware.task.model.vo.Task;

@Controller
@RequestMapping("/task")
public class TaskController {
	
	@Autowired
	private TaskServiceImpl tService;
	// 나중에 impl말고 그냥 service로 바꿔주기!!!!!!!!
	
	@RequestMapping("/list")
	public ModelAndView taskList(ModelAndView mv, HttpSession session) {
	    
		Employee loginUser = (Employee) session.getAttribute("loginUser");
		int empNo = loginUser.getEmpNo();
		
		Map<String, String> statusNameMap = new HashMap<>();
	    statusNameMap.put("REQUEST", "요청");
	    statusNameMap.put("IN_PROGRESS", "진행 중");
	    statusNameMap.put("FEEDBACK", "피드백");
	    statusNameMap.put("HOLD", "보류");
	    statusNameMap.put("DONE", "완료");
	    
	    Map<String, String> statusColorMap = new HashMap<>();
	    statusColorMap.put("REQUEST", "gray");
	    statusColorMap.put("IN_PROGRESS", "blue");
	    statusColorMap.put("FEEDBACK", "orange");
	    statusColorMap.put("HOLD", "yellow");
	    statusColorMap.put("DONE", "green");

		ArrayList<Task> list = tService.taskList(empNo);
		
		mv.addObject("list", list)
		  .addObject("statusNameMap", statusNameMap)
		  .addObject("statusColorMap", statusColorMap)
		  .setViewName("task/taskListView");
		
	    return mv;
	}
	
	@RequestMapping("/detail")
    public String taskDetail() {
        return "task/taskDetailView";
    }
	
	@RequestMapping("/insertForm")
    public String taskInsertForm() {
		return "task/taskInsertForm";
    }

	@RequestMapping("/insert")
	public String taskInsert(Task task, MultipartFile upfile, Model model, HttpSession session, Attachment atmt) {
		
		if(upfile != null && !upfile.getOriginalFilename().equals("")) {
			String changeName = saveFile(upfile, session);
			atmt.setOriginalFilename(upfile.getOriginalFilename());
			atmt.setStoredFilepath("resources/uploadFiles/" + changeName);
			atmt.setFileExtension(upfile.getOriginalFilename().substring(upfile.getOriginalFilename().lastIndexOf(".")));
			atmt.setRefType("TASK");
		}
		
		int result = tService.taskInsert(task, atmt);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "업무가 성공적으로 추가되었습니다.");
			return "redirect:/task/list";
		}else {
			session.setAttribute("insertFormFail", true);
			return "redirect:/task/list";
		}
		
	}
	
	public String saveFile(MultipartFile upfile, HttpSession session) {
		
		String originName = upfile.getOriginalFilename();
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); // "20250417093922"
		int ranNum = (int)(Math.random() * 90000 + 10000); // 74158 (5자리 랜덤값)
		String ext = originName.substring(originName.lastIndexOf(".")); // ".png"
		
		String changeName = currentTime + ranNum + ext;
		
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return changeName;
	}
	
	@ResponseBody
	@RequestMapping("/checkFailFlag")
	public boolean checkFailFlag(HttpSession session) {
	    Boolean failFlag = (Boolean) session.getAttribute("insertFormFail");
	    if (failFlag != null && failFlag) {
	        session.removeAttribute("insertFormFail"); // 확인했으면 제거
	        return true;
	    }
	    return false;
	}

}
