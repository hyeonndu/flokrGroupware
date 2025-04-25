package com.kh.flokrGroupware.employee.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.flokrGroupware.employee.model.service.EmployeeService;
import com.kh.flokrGroupware.employee.model.vo.Employee;

@Controller
public class EmployeeController {
    
    @Autowired
    private EmployeeService employeeService;
    
    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;
    
    // 비밀번호 암호화 테스트 메소드
    @RequestMapping("employee/encryptTest")
    public String encryptTest() {
        String[] passwords = {"hash1234abcd", "hash5678efgh", "hash9012ijkl", "hash3456mnop", "hash7890qrst"};
        String[] empIds = {"admin", "lee002", "park003", "choi004", "jung005"};
        
        for(int i = 0; i < passwords.length; i++) {
            String encrypted = bcryptPasswordEncoder.encode(passwords[i]);
            System.out.println(empIds[i] + ": " + passwords[i] + " -> " + encrypted);
        }
        
        return "redirect:/";
    }
    
    // 로그인 - BCrypt 암호화 검증 방식
    @RequestMapping("login.me")
    public String loginEmployee(Employee e, HttpSession session, Model model) {
        
        Employee loginUser = employeeService.loginEmployee(e);
        
        // BCrypt 암호화 검증
        if(loginUser != null && bcryptPasswordEncoder.matches(e.getPasswordHash(), loginUser.getPasswordHash())) {
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
    
    // 사원 등록 폼 페이지 - 관리자만 접근 가능
    @GetMapping("employee/register")
    public String registerForm(Model model, HttpSession session) {
        // 로그인 여부 및 관리자 권한 체크
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            session.setAttribute("alertMsg", "관리자만 접근 가능합니다.");
            return "redirect:/";
        }
        
        // 부서 목록 조회
        model.addAttribute("deptList", employeeService.selectDepartmentList());
        // 직급 목록 조회
        model.addAttribute("positionList", employeeService.selectPositionList());
        
        return "employee/registerForm";
    }
    
    // 사원 등록 처리 - 관리자만 가능
    @PostMapping("employee/insert")
    public String insertEmployee(Employee e, HttpSession session, Model model) {
        // 관리자 권한 체크
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            session.setAttribute("alertMsg", "관리자만 접근 가능합니다.");
            return "redirect:/";
        }
        
        // 비밀번호 암호화
        String encryptedPassword = bcryptPasswordEncoder.encode(e.getPasswordHash());
        e.setPasswordHash(encryptedPassword);
        
        // 기본값으로 일반 사용자 설정 (폼에서 제거됨)
        e.setIsAdmin("N");
        
        // 사원 등록 서비스 호출
        int result = employeeService.insertEmployee(e);
        
        if(result > 0) {
            session.setAttribute("alertMsg", "사원 등록이 완료되었습니다.");
            return "redirect:/employee/register";
        } else {
            model.addAttribute("errorMsg", "사원 등록에 실패했습니다.");
            return "common/errorPage";
        }
    }
}