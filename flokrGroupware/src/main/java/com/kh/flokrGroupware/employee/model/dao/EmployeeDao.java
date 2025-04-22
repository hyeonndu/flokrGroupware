package com.kh.flokrGroupware.employee.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.flokrGroupware.employee.model.vo.Employee;

@Repository
public class EmployeeDao {
    
    @Autowired
    private SqlSessionTemplate sqlSession;
    
    public Employee loginEmployee(Employee e) {
        return sqlSession.selectOne("employeeMapper.loginEmployee", e);
    }
}