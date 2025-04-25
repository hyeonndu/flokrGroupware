package com.kh.flokrGroupware.employee.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.flokrGroupware.employee.model.vo.Department;
import com.kh.flokrGroupware.employee.model.vo.Employee;
import com.kh.flokrGroupware.employee.model.vo.Position;

@Repository
public class EmployeeDao {
    
    @Autowired
    private SqlSessionTemplate sqlSession;
    
    public Employee loginEmployee(Employee e) {
        return sqlSession.selectOne("employeeMapper.loginEmployee", e);
    }
    
    public ArrayList<Department> selectDepartmentList() {
        return (ArrayList)sqlSession.selectList("employeeMapper.selectDepartmentList");
    }
    
    public ArrayList<Position> selectPositionList() {
        return (ArrayList)sqlSession.selectList("employeeMapper.selectPositionList");
    }
    
    public int insertEmployee(Employee e) {
        return sqlSession.insert("employeeMapper.insertEmployee", e);
    }
}