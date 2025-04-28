package com.kh.flokrGroupware.employee.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.flokrGroupware.common.model.vo.PageInfo;
import com.kh.flokrGroupware.common.template.Pagination;
import com.kh.flokrGroupware.employee.model.service.EmployeeService;
import com.kh.flokrGroupware.employee.model.vo.Employee;

@Controller
public class EmployeeController {
    
    @Autowired
    private EmployeeService employeeService;
    
    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;
    
    // 루트 페이지 접근 시 로그인 상태 확인
    @RequestMapping("/")
    public String root(HttpSession session) {
        // 로그인이 되어 있지 않으면 로그인 페이지로
        if(session.getAttribute("loginUser") == null) {
            return "redirect:/";
        }
        
        // 로그인 되어 있으면 권한에 따라 다른 메인 페이지로
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        if("Y".equals(loginUser.getIsAdmin())) {
            return "redirect:/adminMain"; // 관리자 대시보드
        } else {
            return "redirect:/userMain"; // 일반 사용자 메인
        }
    }
    
    // 로그인 폼 페이지 매핑
    @RequestMapping("loginForm")
    public String loginForm() {
        return "loginForm";
    }
    
    /*
    // 암호화 적용 전 로그인 메소드 (암호화 적용 후 주석 처리)
    @RequestMapping("login.me")
    public String loginEmployee(Employee e, HttpSession session, Model model) {
        // 로그인 사용자가 입력한 id와 pwd
        System.out.println("로그인 시도 - ID: " + e.getEmpId() + ", PWD: " + e.getPasswordHash());
        
        // 해당 ID의 사용자 조회
        Employee loginUser = employeeService.loginEmployee(e);
        
        if(loginUser != null) {
            // 로그인 시도 시 해당 ID의 비밀번호 암호화 결과 출력
            String encryptedPassword = bcryptPasswordEncoder.encode(e.getPasswordHash());
            System.out.println("===== 암호화 테스트 =====");
            System.out.println(e.getEmpId() + ": 원본 비밀번호 = " + e.getPasswordHash());
            System.out.println(e.getEmpId() + ": 암호화된 비밀번호 = " + encryptedPassword);
            System.out.println("DB에 저장된 비밀번호 = " + loginUser.getPasswordHash());
            System.out.println("=====================");
            
            // 현재는 평문 비교로 로그인 처리 (암호화 전 단계)
            if(e.getPasswordHash().equals(loginUser.getPasswordHash())) {
                // 로그인 성공
                session.setAttribute("loginUser", loginUser);
                
                // 관리자 여부에 따라 다른 메인 페이지로 리다이렉트
                if("Y".equals(loginUser.getIsAdmin())) {
                    session.setAttribute("alertMsg", "관리자로 로그인되었습니다.");
                    return "redirect:/adminMain";
                } else {
                    session.setAttribute("alertMsg", "로그인에 성공했습니다.");
                    return "redirect:/userMain";
                }
            } else {
                // 비밀번호 불일치
                session.setAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
                return "redirect:/";
            }
        } else {
            // 아이디 존재하지 않음
            session.setAttribute("alertMsg", "존재하지 않는 아이디입니다.");
            return "redirect:/";
        }
    }
    */
    
    // 암호화 적용 후 로그인 메소드
    @RequestMapping("login.me")
    public String loginEmployeeEncrypted(Employee e, HttpSession session, Model model) {
        // 로그인 사용자가 입력한 id와 pwd
        // System.out.println("로그인 시도 - ID: " + e.getEmpId() + ", PWD: " + e.getPasswordHash());
        
        // 아이디로만 DB에서 조회
        Employee loginUser = employeeService.loginEmployee(e);
        
        if(loginUser != null) {
            // System.out.println("DB 저장 비밀번호(암호화됨): " + loginUser.getPasswordHash());
            
            // 평문 비밀번호와 암호화된 비밀번호 비교
            if(bcryptPasswordEncoder.matches(e.getPasswordHash(), loginUser.getPasswordHash())) {
                // 로그인 성공
                session.setAttribute("loginUser", loginUser);
                
                // 관리자 여부에 따라 다른 메인 페이지로 리다이렉트
                if("Y".equals(loginUser.getIsAdmin())) {
                    session.setAttribute("alertMsg", "관리자로 로그인되었습니다.");
                    return "redirect:/adminMain";
                } else {
                    session.setAttribute("alertMsg", "로그인에 성공했습니다.");
                    return "redirect:/userMain";
                }
            } else {
                // 비밀번호 불일치
                session.setAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
                return "redirect:/";
            }
        } else {
            // 아이디 존재하지 않음
            session.setAttribute("alertMsg", "존재하지 않는 아이디입니다.");
            return "redirect:/";
        }
    } 
    
    // 로그아웃
    @RequestMapping("logout.me")
    public String logoutEmployee(HttpSession session) {
        session.setAttribute("alertMsg", "로그아웃 되었습니다.");
        session.invalidate();
        return "redirect:/";
    }
    
    // 사원 등록 폼 페이지 - 관리자만 접근 가능
    @GetMapping("employeeRegister")
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
    
    // 해당 부서의 마지막 사번 순번 조회 (AJAX용)
    @ResponseBody
    @GetMapping("getLastEmpId")
    public String getLastEmployeeId(@RequestParam("deptNo") int deptNo, 
                                    @RequestParam("yearPrefix") String yearPrefix) {
        // 해당 부서와 년도로 시작하는 마지막 사번 조회
        String lastEmpId = employeeService.getLastEmployeeId(deptNo, yearPrefix);
        
        if(lastEmpId == null) {
            // 없으면 첫 순번 "0" 반환
            return "0";
        } else {
            // 마지막 3자리(순번) 반환
            return lastEmpId.substring(lastEmpId.length() - 3);
        }
    }
    
    // 사원 등록 처리 - 관리자만 가능
    @PostMapping("insertEmployee")
    public String insertEmployee(Employee e, 
                              @RequestParam(value="phone1", defaultValue="") String phone1,
                              @RequestParam(value="phone2", defaultValue="") String phone2,
                              @RequestParam(value="phone3", defaultValue="") String phone3,
                              @RequestParam("hireDate") String hireDateStr,
                              HttpSession session, 
                              Model model) {
        // 관리자 권한 체크
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            session.setAttribute("alertMsg", "관리자만 접근 가능합니다.");
            return "redirect:/";
        }
        
        try {
            // 전화번호 형식 맞추기
            if(!phone1.isEmpty() && !phone2.isEmpty() && !phone3.isEmpty()) {
                e.setPhone(phone1 + "-" + phone2 + "-" + phone3);
            }
            
            if(hireDateStr != null && !hireDateStr.isEmpty()) {
                e.setHireDate(Date.valueOf(hireDateStr));
            }
            
            // 현재 년도 가져오기 (2자리)
            String currentYear = new java.text.SimpleDateFormat("yy").format(new java.util.Date());
            
            // 부서번호와 현재 년도로 사번 자동 생성
            String lastEmpId = employeeService.getLastEmployeeId(e.getDeptNo(), currentYear);
            int newSequence = 1;
            
            if(lastEmpId != null) {
                // 마지막 3자리(순번) 추출 후 1 증가
                newSequence = Integer.parseInt(lastEmpId.substring(lastEmpId.length() - 3)) + 1;
            }
            
            // 새 사번 생성
            String sequenceStr = String.format("%03d", newSequence);
            String newEmpId = e.getDeptNo() + currentYear + sequenceStr;
            e.setEmpId(newEmpId);
            
            // 이메일은 사번@flokr.com 형식으로 설정
            e.setEmail(newEmpId + "@flokr.com");
            
            // 사번 + "init"로 초기 비밀번호 설정
            String initialPassword = e.getEmpId() + "init";
            
            // 비밀번호 암호화
            String encryptedPassword = bcryptPasswordEncoder.encode(initialPassword);
            e.setPasswordHash(encryptedPassword);
            
            // 기본값으로 일반 사용자 설정
            e.setIsAdmin("N");
            
            // 상태 활성 설정
            e.setStatus("Y");
            
            // 사원 등록 서비스 호출
            int result = employeeService.insertEmployee(e);
            
            if(result > 0) {
                session.setAttribute("alertMsg", "사원 등록이 완료되었습니다. 초기 비밀번호는 '" + initialPassword + "'입니다.");
                return "redirect:/adminMain";
            } else {
                model.addAttribute("errorMsg", "사원 등록에 실패했습니다.");
                return "common/errorPage";
            }
        } catch (Exception ex) {
            model.addAttribute("errorMsg", "사원 등록 중 오류 발생: " + ex.getMessage());
            return "common/errorPage";
        }
    }
    
    // 사원 목록 조회 - 관리자만 접근 가능
    @GetMapping("employeeList")
    public String employeeList(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
                            @RequestParam(value="keyword", required=false) String keyword,
                            @RequestParam(value="searchType", defaultValue="name") String searchType,
                            @RequestParam(value="deptNo", required=false) Integer deptNo,
                            @RequestParam(value="statusFilter", defaultValue="active") String statusFilter,
                            Model model, HttpSession session, RedirectAttributes ra) {
        
        // 로그인 여부 체크
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        if(loginUser == null) {
            ra.addFlashAttribute("alertMsg", "로그인이 필요한 서비스입니다.");
            return "redirect:/";
        }
        
        // 관리자 권한 체크
        if(!"Y".equals(loginUser.getIsAdmin())) {
            ra.addFlashAttribute("alertMsg", "관리자만 접근 가능합니다.");
            return "redirect:/";
        }
        
        try {
            // 검색 조건 설정
            Employee searchCondition = new Employee();
            if(keyword != null && !keyword.trim().isEmpty()) {
            	if("name".equals(searchType)) {
                    searchCondition.setEmpName(keyword);
                } else if("id".equals(searchType)) {
                    searchCondition.setEmpId(keyword);
                } else if("email".equals(searchType)) {
                    searchCondition.setEmail(keyword);
                }
            }
            
            // deptNo가 null이 아닌 경우에만 설정
            if(deptNo != null && deptNo > 0) {
                searchCondition.setDeptNo(deptNo);
            }
            
            // 상태 필터 설정
            if("all".equals(statusFilter)) {
                // 전체 상태 조회 (status 설정 안함)
            } else if("active".equals(statusFilter)) {
                searchCondition.setStatus("Y");
            } else if("inactive".equals(statusFilter)) {
                searchCondition.setStatus("N");
            } else {
                // 기본값은 active
                searchCondition.setStatus("Y");
            }
            
            // 페이지네이션 처리를 위한 총 사원 수 조회
            int listCount = employeeService.getEmployeeCount(searchCondition);
            
            // 페이지 정보 설정 (한 페이지에 10명씩 표시)
            PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
            
            // 파라미터 Map 생성
            Map<String, Object> params = new HashMap<>();
            params.put("employee", searchCondition);
            params.put("pi", pi);
            
            // 사원 목록 조회
            ArrayList<Employee> employeeList = employeeService.selectEmployeeList(params);
            
            // 부서 목록 조회 (검색 필터용)
            model.addAttribute("deptList", employeeService.selectDepartmentList());
            
            // 모델에 데이터 추가
            model.addAttribute("employeeList", employeeList);
            model.addAttribute("pi", pi);
            model.addAttribute("keyword", keyword);
            model.addAttribute("searchType", searchType);
            model.addAttribute("selectedDeptNo", deptNo);
            model.addAttribute("statusFilter", statusFilter);
            
            return "employee/employeeList";
            
        } catch (Exception ex) {
            ex.printStackTrace();
            model.addAttribute("errorMsg", "사원 목록 조회 중 오류 발생: " + ex.getMessage());
            return "common/errorPage";
        }
    }
    
    // 사원 상세 정보 조회 - 관리자만 접근 가능
    @GetMapping("employeeDetail/{empNo}")
    public String employeeDetail(@PathVariable("empNo") int empNo, Model model, HttpSession session) {
        // 관리자 권한 체크
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            session.setAttribute("alertMsg", "관리자만 접근 가능합니다.");
            return "redirect:/";
        }
        
        // 사원 상세 정보 조회
        Employee employee = employeeService.selectEmployee(empNo);
        
        if(employee != null) {
            model.addAttribute("employee", employee);
            return "employee/employeeDetail";
        } else {
            model.addAttribute("errorMsg", "사원 정보를 찾을 수 없습니다.");
            return "common/errorPage";
        }
    }
    
    // 사원 정보 수정 폼 - 관리자만 접근 가능
    @GetMapping("employeeUpdate/{empNo}")
    public String updateEmployeeForm(@PathVariable("empNo") int empNo, Model model, HttpSession session) {
        // 관리자 권한 체크
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            session.setAttribute("alertMsg", "관리자만 접근 가능합니다.");
            return "redirect:/";
        }
        
        // 사원 정보 조회
        Employee employee = employeeService.selectEmployee(empNo);
        
        if(employee != null) {
            // 부서 목록 조회
            model.addAttribute("deptList", employeeService.selectDepartmentList());
            // 직급 목록 조회
            model.addAttribute("positionList", employeeService.selectPositionList());
            model.addAttribute("employee", employee);
            return "employee/employeeUpdateForm";
        } else {
            model.addAttribute("errorMsg", "사원 정보를 찾을 수 없습니다.");
            return "common/errorPage";
        }
    }
    
    // 사원 정보 수정 처리 - 관리자만 가능
    @PostMapping("employeeUpdate")
    public String updateEmployee(Employee e, 
                                @RequestParam(value="phone1", defaultValue="") String phone1,
                                @RequestParam(value="phone2", defaultValue="") String phone2,
                                @RequestParam(value="phone3", defaultValue="") String phone3,
                                @RequestParam("hireDate") String hireDateStr,
                                HttpSession session, 
                                Model model) {
        // 관리자 권한 체크
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            session.setAttribute("alertMsg", "관리자만 접근 가능합니다.");
            return "redirect:/";
        }
        
        try {
            // 전화번호 형식 맞추기
            if(!phone1.isEmpty() && !phone2.isEmpty() && !phone3.isEmpty()) {
                e.setPhone(phone1 + "-" + phone2 + "-" + phone3);
            }
            
            int result = employeeService.updateEmployee(e);
            
            if(result > 0) {
                session.setAttribute("alertMsg", "사원 정보가 수정되었습니다.");
                return "redirect:/employeeDetail/" + e.getEmpNo();
            } else {
                model.addAttribute("errorMsg", "사원 정보 수정에 실패했습니다.");
                return "common/errorPage";
            }
        } catch (Exception ex) {
            model.addAttribute("errorMsg", "사원 정보 수정 중 오류 발생: " + ex.getMessage());
            return "common/errorPage";
        }
    }
    
    // 사원 정보 삭제 처리 - 관리자만 가능 (기존 메서드는 유지, AJAX용 메서드 추가)
    @PostMapping("employeeDelete")
    public String deleteEmployee(@RequestParam("empNo") int empNo, HttpSession session, Model model) {
        // 관리자 권한 체크
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            session.setAttribute("alertMsg", "관리자만 접근 가능합니다.");
            return "redirect:/";
        }
        
        try {
            int result = employeeService.deleteEmployee(empNo);
            
            if(result > 0) {
                session.setAttribute("alertMsg", "사원 정보가 퇴사 처리 되었습니다.");
                return "redirect:/employeeList";
            } else {
                model.addAttribute("errorMsg", "사원 정보 퇴사 처리에 실패했습니다.");
                return "common/errorPage";
            }
        } catch (Exception ex) {
            model.addAttribute("errorMsg", "사원 정보 삭제 중 오류 발생: " + ex.getMessage());
            return "common/errorPage";
        }
    }
    
 // AJAX 퇴사 처리를 위한 메서드
    @PostMapping("employeeDeleteAjax")
    @ResponseBody
    public Map<String, Object> deleteEmployeeAjax(@RequestParam("empNo") int empNo, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 관리자 권한 체크
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            response.put("success", false);
            response.put("message", "관리자만 접근 가능합니다.");
            return response;
        }
        
        try {
            int result = employeeService.deleteEmployee(empNo);
            
            if(result > 0) {
                response.put("success", true);
                response.put("message", "사원 정보가 삭제되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "사원 정보 삭제에 실패했습니다.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.put("success", false);
            response.put("message", "사원 정보 삭제 중 오류 발생: " + ex.getMessage());
        }
        
        return response;
    }
    
 // 비밀번호 초기화 메서드
    @PostMapping("resetPassword")
    @ResponseBody
    public Map<String, Object> resetPassword(@RequestParam("empNo") int empNo, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 관리자 권한 체크
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            response.put("success", false);
            response.put("message", "관리자만 접근 가능합니다.");
            return response;
        }
        
        try {
            // 사원 정보 조회
            Employee employee = employeeService.selectEmployee(empNo);
            
            if(employee != null) {
                // 사번 + "init"로 초기 비밀번호 설정
                String initialPassword = employee.getEmpId() + "init";
                
                // 비밀번호 암호화
                String encryptedPassword = bcryptPasswordEncoder.encode(initialPassword);
                
                // 비밀번호 업데이트
                Map<String, Object> params = new HashMap<>();
                params.put("empNo", empNo);
                params.put("passwordHash", encryptedPassword);
                
                int result = employeeService.resetPassword(params);
                
                if(result > 0) {
                    response.put("success", true);
                    response.put("message", "비밀번호가 초기화되었습니다. 초기 비밀번호는 '" + initialPassword + "'입니다.");
                } else {
                    response.put("success", false);
                    response.put("message", "비밀번호 초기화에 실패했습니다.");
                }
            } else {
                response.put("success", false);
                response.put("message", "사원 정보를 찾을 수 없습니다.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.put("success", false);
            response.put("message", "비밀번호 초기화 중 오류 발생: " + ex.getMessage());
        }
        
        return response;
    }
    
    // 관리자 메인 페이지 매핑
    @RequestMapping("adminMain")
    public String adminMain(HttpSession session, Model model) {
        // 로그인 여부 및 관리자 권한 체크
        Employee loginUser = (Employee)session.getAttribute("loginUser");
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            session.setAttribute("alertMsg", "관리자만 접근 가능합니다.");
            return "redirect:/";
        }
        
        return "adminMain";
    }

    // 사용자 메인 페이지 매핑
    @RequestMapping("userMain")
    public String userMain(HttpSession session) {
        // 로그인 여부 체크
        if(session.getAttribute("loginUser") == null) {
            return "redirect:/";
        }
        
        return "userMain";
    }
}