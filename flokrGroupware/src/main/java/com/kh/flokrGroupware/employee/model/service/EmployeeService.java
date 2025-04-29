package com.kh.flokrGroupware.employee.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.kh.flokrGroupware.common.model.vo.PageInfo;
import com.kh.flokrGroupware.employee.model.vo.Department;
import com.kh.flokrGroupware.employee.model.vo.Employee;
import com.kh.flokrGroupware.employee.model.vo.Position;

public interface EmployeeService {
    
    // 로그인 처리
    Employee loginEmployee(Employee e);
    
    // 부서 목록 조회
    ArrayList<Department> selectDepartmentList();
    
    // 직급 목록 조회
    ArrayList<Position> selectPositionList();
    
    // 마지막 사번 조회
    String getLastEmployeeId(int deptNo, String yearPrefix);
    
    // 사원 등록
    int insertEmployee(Employee e);
    
    // 총 사원 수 조회
    int getEmployeeCount(Employee searchCondition);
    
    // 사원 목록 조회 (페이징 처리)
    ArrayList<Employee> selectEmployeeList(Map<String, Object> params);
    
    // 사원 상세 조회
    Employee selectEmployee(int empNo);
    
    // 사원 정보 수정
    int updateEmployee(Employee e);
    
    // 사원 삭제 (상태 변경)
    int deleteEmployee(int empNo);
    
    // 비밀번호 초기화
    int resetPassword(Map<String, Object> params);
}