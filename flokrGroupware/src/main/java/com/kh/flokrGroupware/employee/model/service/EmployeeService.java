package com.kh.flokrGroupware.employee.model.service;

import java.util.ArrayList;

import com.kh.flokrGroupware.employee.model.vo.Department;
import com.kh.flokrGroupware.employee.model.vo.Employee;
import com.kh.flokrGroupware.employee.model.vo.Position;

public interface EmployeeService {

    Employee loginEmployee(Employee e);
    
    ArrayList<Department> selectDepartmentList();
    ArrayList<Position> selectPositionList();
    int insertEmployee(Employee e);
}