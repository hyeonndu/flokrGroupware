package com.kh.flokrGroupware.employee.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.flokrGroupware.employee.model.service.EmployeeService;
import com.kh.flokrGroupware.employee.model.vo.Employee;

@Controller
public class EmployeeController {
    
    @Autowired
    private EmployeeService employeeService;
    
    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;
    
    @RequestMapping("login.me")
    public String loginEmployee(Employee e, HttpSession session, Model model) {
        
        Employee loginUser = employeeService.loginEmployee(e);
        
        // 임시로 plain text 비교
        if(loginUser != null && e.getPasswordHash().equals(loginUser.getPasswordHash())) {
            // 로그인 성공
            session.setAttribute("loginUser", loginUser);
            session.setAttribute("alertMsg", "로그인에 성공했습니다.");
            return "redirect:/";
        } else {
            // 로그인 실패
            session.setAttribute("alertMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            return "redirect:/";
        }
    }
    
    // 로그아웃
    @RequestMapping("logout.me")
    public String logoutEmployee(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}