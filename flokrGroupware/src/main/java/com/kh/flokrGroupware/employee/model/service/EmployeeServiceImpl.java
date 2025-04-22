package com.kh.flokrGroupware.employee.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.flokrGroupware.employee.model.dao.EmployeeDao;
import com.kh.flokrGroupware.employee.model.vo.Employee;

@Service
public class EmployeeServiceImpl implements EmployeeService {
    
    @Autowired
    private EmployeeDao employeeDao;
    
    @Override
    public Employee loginEmployee(Employee e) {
        return employeeDao.loginEmployee(e);
    }
}