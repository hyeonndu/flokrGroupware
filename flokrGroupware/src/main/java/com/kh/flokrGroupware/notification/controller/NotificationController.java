package com.kh.flokrGroupware.notification.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.flokrGroupware.employee.model.service.EmployeeService;
import com.kh.flokrGroupware.employee.model.vo.Employee;
import com.kh.flokrGroupware.notification.model.service.NotificationService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class NotificationController {
    
    private static final Logger logger = LoggerFactory.getLogger(NotificationController.class);
    
    @Autowired
    private NotificationService notificationService;
    
    @Autowired
    private NotificationHandler notificationHandler;
    
    @Autowired
    private EmployeeService employeeService;
    
    // 모든 알림 조회 페이지
    @GetMapping("/notificationAll")
    public String allNotifications(
            HttpSession session, 
            Model model,
            @RequestParam(value="page", defaultValue="1") int page) {
        
        Employee loginUser = (Employee) session.getAttribute("loginUser");
        
        if(loginUser == null) {
            return "redirect:/";
        }
        
        int limit = 10; // 페이지당 표시할 알림 수
        
        List<Map<String, Object>> notifications = notificationService.getAllNotificationsPaging(loginUser.getEmpNo(), page, limit);
        int totalCount = notificationService.getTotalNotificationsCount(null, null);
        
        int maxPage = (int)Math.ceil((double)totalCount / limit);
        if(maxPage == 0) maxPage = 1; // 데이터가 없어도 최소 1페이지는 표시

        // 한 번에 표시할 페이지 버튼 수
        int pageButtonCount = 5;

        // 시작 페이지와 끝 페이지 계산 로직
        int startPage = ((page - 1) / pageButtonCount) * pageButtonCount + 1;
        int endPage = Math.min(startPage + pageButtonCount - 1, maxPage);

        if(endPage > maxPage) {
            endPage = maxPage;
        }
        
        model.addAttribute("notifications", notifications);
        model.addAttribute("currentPage", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        
        return "notification/notificationAll";
    }
    
    // 알림 읽음 처리 (AJAX)
    @PostMapping("/notificationRead/{notificationNo}")
    @ResponseBody
    public Map<String, Object> readNotification(@PathVariable int notificationNo, HttpSession session) {
        Employee loginUser = (Employee) session.getAttribute("loginUser");
        
        if(loginUser == null) {
            return Map.of("success", false, "message", "로그인이 필요합니다.");
        }
        
        try {
            notificationService.markAsRead(notificationNo, loginUser.getEmpNo());
            return Map.of("success", true);
        } catch(Exception e) {
            return Map.of("success", false, "message", e.getMessage());
        }
    }
    
    // 관리자용 알림 관리 페이지
    @GetMapping("/notificationAdmin")
    public String adminNotifications(
            HttpSession session, 
            Model model,
            @RequestParam(value="page", defaultValue="1") int page,
            @RequestParam(value="type", required=false) String type,
            @RequestParam(value="keyword", required=false) String keyword) {
        
        Employee loginUser = (Employee) session.getAttribute("loginUser");
        
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            session.setAttribute("alertMsg", "관리자 권한이 필요합니다.");
            return "redirect:/";
        }
        
        int limit = 10; // 페이지당 표시할 알림 수
        
        List<Map<String, Object>> notifications = notificationService.getNotificationsForAdmin(page, limit, type, keyword);
        int totalCount = notificationService.getTotalNotificationsCount(type, keyword);
        
        int maxPage = (int)Math.ceil((double)totalCount / limit);
        if(maxPage == 0) maxPage = 1; // 데이터가 없어도 최소 1페이지는 표시

        // 한 번에 표시할 페이지 버튼 수
        int pageButtonCount = 5;

        // 시작 페이지와 끝 페이지 계산 로직
        int startPage = ((page - 1) / pageButtonCount) * pageButtonCount + 1;
        int endPage = Math.min(startPage + pageButtonCount - 1, maxPage);

        if(endPage > maxPage) {
            endPage = maxPage;
        }
        
        model.addAttribute("notifications", notifications);
        model.addAttribute("currentPage", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        
        // 부서 목록 조회 (알림 발송용)
        model.addAttribute("departments", employeeService.selectDepartmentList());
        
        // 현재 페이지를 문자열로 전달 (헤더 메뉴 active 표시용)
        model.addAttribute("currentMenu", "notification");
        
        return "notification/notificationAdmin";
    }
    
    // 관리자용 알림 발송 기능
    @PostMapping("/notificationAdminSend")
    @ResponseBody
    public Map<String, Object> sendNotificationAdmin(
            HttpSession session,
            @RequestParam("targetType") String targetType,
            @RequestParam(value="targetId", required=false) String targetId,
            @RequestParam("notificationType") String notificationType,
            @RequestParam("title") String title,
            @RequestParam(value="content", required=false) String content,
            @RequestParam(value="refType", required=false) String refType,
            @RequestParam(value="refNo", required=false) String refNo) {
        
        Employee loginUser = (Employee) session.getAttribute("loginUser");
        
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            return Map.of("success", false, "message", "관리자 권한이 필요합니다.");
        }
        
        // 로그 형식
        logger.info("알림 발송 요청: targetType=" + targetType + ", targetId=" + targetId + 
        	    ", type=" + notificationType + ", title=" + title);
        
        try {
            if("ALL".equals(targetType)) {
                // 전체 직원에게 알림 발송
                notificationHandler.sendNotificationToAll(notificationType, title, content, refType, refNo);
                return Map.of("success", true, "message", "전체 직원에게 알림이 발송되었습니다.");
            } else if("DEPARTMENT".equals(targetType) && targetId != null) {
                // 특정 부서에게 알림 발송
                int deptNo = Integer.parseInt(targetId);
                notificationHandler.sendNotificationToDepartment(deptNo, notificationType, title, content, refType, refNo);
                return Map.of("success", true, "message", "선택한 부서 직원에게 알림이 발송되었습니다.");
            } else if("EMPLOYEE".equals(targetType) && targetId != null) {
                // 특정 직원에게 알림 발송
                int empNo = Integer.parseInt(targetId);
                notificationHandler.sendNotification(empNo, notificationType, title, content, refType, refNo);
                return Map.of("success", true, "message", "선택한 직원에게 알림이 발송되었습니다.");
            } else {
                logger.warn("올바르지 않은 알림 대상: targetType={}, targetId={}", targetType, targetId);
                return Map.of("success", false, "message", "올바르지 않은 대상 유형입니다.");
            }
        } catch(NumberFormatException e) {
            logger.error("알림 발송 중 숫자 변환 오류: {}", e.getMessage());
            return Map.of("success", false, "message", "대상 ID가 올바르지 않습니다.");
        } catch(Exception e) {
            logger.error("알림 발송 중 오류 발생", e);
            return Map.of("success", false, "message", "알림 발송 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // 알림 통계 조회
    @GetMapping("/notificationAdminStats")
    @ResponseBody
    public Map<String, Object> getNotificationStatistics(HttpSession session) {
        Employee loginUser = (Employee) session.getAttribute("loginUser");
        
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            return Map.of("success", false, "message", "관리자 권한이 필요합니다.");
        }
        
        // 여기에 알림 통계 조회 로직을 추가 (필요시)
        
        return Map.of("success", true, "data", Map.of(
            "totalSent", 150,
            "totalRead", 120,
            "readRate", 80,
            "todaySent", 15,
            "byType", Map.of("NOTICE", 50, "APPROVAL", 40, "CHAT", 30, "TASK", 30)
        ));
    }
    
    // 오래된 알림 정리 (수동)
    @PostMapping("/notificationAdminCleanup")
    @ResponseBody
    public Map<String, Object> cleanupOldNotifications(
            HttpSession session,
            @RequestParam("days") int days) {
        
        Employee loginUser = (Employee) session.getAttribute("loginUser");
        
        if(loginUser == null || !"Y".equals(loginUser.getIsAdmin())) {
            return Map.of("success", false, "message", "관리자 권한이 필요합니다.");
        }
        
        try {
            notificationService.deleteOldNotifications(days);
            return Map.of("success", true, "message", days + "일이 지난 알림을 정리했습니다.");
        } catch(Exception e) {
            return Map.of("success", false, "message", "알림 정리 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    @GetMapping("/notificationEmployeeSearch")
    @ResponseBody
    public List<Map<String, Object>> searchEmployee(@RequestParam("keyword") String keyword) {
        logger.info("직원 검색 요청: keyword={}", keyword);
        List<Map<String, Object>> originalResults = employeeService.searchEmployee(keyword);
        
        // 디버깅 추가
        for (Map<String, Object> emp : originalResults) {
            logger.info("원본 직원 데이터: {}", emp);
        }
        
        // 새로운 표준화된 결과 리스트 생성
        List<Map<String, Object>> standardizedResults = new ArrayList<>();
        
        for (Map<String, Object> emp : originalResults) {
            Map<String, Object> standardizedEmp = new HashMap<>();
            
            // 대소문자 무시하고 키 찾기
            // EMPNO 키가 직접 있는 경우
            if (emp.containsKey("EMPNO")) {
                standardizedEmp.put("empNo", emp.get("EMPNO"));
            } 
            // empNo 키가 직접 있는 경우
            else if (emp.containsKey("empNo")) {
                standardizedEmp.put("empNo", emp.get("empNo"));
            }
            // EMP_NO 키가 직접 있는 경우
            else if (emp.containsKey("EMP_NO")) {
                standardizedEmp.put("empNo", emp.get("EMP_NO"));
            }
            else {
                // 다른 키들 검색 - 대소문자 구분 없이
                for (String key : emp.keySet()) {
                    if (key.equalsIgnoreCase("EMPNO") || 
                        key.equalsIgnoreCase("empNo") || 
                        key.equalsIgnoreCase("EMP_NO")) {
                        standardizedEmp.put("empNo", emp.get(key));
                        break;
                    }
                }
            }
            
            // 다른 필드들도 유사하게 처리
            standardizedEmp.put("empName", getValueOrDefault(emp, "", "EMP_NAME", "EMPNAME", "empName"));
            standardizedEmp.put("empId", getValueOrDefault(emp, "", "EMP_ID", "EMPID", "empId"));
            standardizedEmp.put("deptName", getValueOrDefault(emp, "", "DEPT_NAME", "DEPTNAME", "deptName"));
            standardizedEmp.put("positionName", getValueOrDefault(emp, "", "POSITION_NAME", "POSITIONNAME", "positionName"));
            
            // empNo가 추가되었는지 확인
            if (standardizedEmp.get("empNo") == null) {
                logger.warn("직원 정보에 empNo가 없어 건너뜁니다: {}", emp);
                continue;
            }
            
            logger.info("표준화된 직원 정보: {}", standardizedEmp);
            standardizedResults.add(standardizedEmp);
        }
        
        logger.info("직원 검색 결과: {}건", standardizedResults.size());
        return standardizedResults;
    }

    private Object getValueOrDefault(Map<String, Object> map, Object defaultValue, String... possibleKeys) {
        if (map == null) return defaultValue;
        
        // 직접 키 매칭
        for (String key : possibleKeys) {
            if (map.containsKey(key)) {
                return map.get(key);
            }
        }
        
        // 대소문자 구분 없는 키 매칭
        for (String key : possibleKeys) {
            for (String mapKey : map.keySet()) {
                if (mapKey.equalsIgnoreCase(key)) {
                    return map.get(mapKey);
                }
            }
        }
        
        return defaultValue;
    }
}