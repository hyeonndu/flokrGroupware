package com.kh.flokrGroupware.employee.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.flokrGroupware.employee.model.dao.EmployeeDao;
import com.kh.flokrGroupware.employee.model.vo.Department;
import com.kh.flokrGroupware.employee.model.vo.Employee;
import com.kh.flokrGroupware.employee.model.vo.Position;

@Service
public class EmployeeServiceImpl implements EmployeeService {
    
    @Autowired
    private EmployeeDao employeeDao;
    
    @Override
    public Employee loginEmployee(Employee e) {
        return employeeDao.loginEmployee(e);
    }
    
    @Override
    public ArrayList<Department> selectDepartmentList() {
        return employeeDao.selectDepartmentList();
    }
    
    @Override
    public ArrayList<Position> selectPositionList() {
        return employeeDao.selectPositionList();
    }
    
    @Override
    public int insertEmployee(Employee e) {
        return employeeDao.insertEmployee(e);
    }
    
    @Override
    public String getLastEmployeeId(int deptNo, String yearPrefix) {
        return employeeDao.getLastEmployeeId(deptNo, yearPrefix);
    }
}