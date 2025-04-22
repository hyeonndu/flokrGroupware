package com.kh.flokrGroupware.employee.model.vo;

import java.sql.Date;
import lombok.Data;

@Data
public class Employee {
    private int empNo;
    private String empName;
    private String empId;
    private String passwordHash;
    private String email;
    private String phone;
    private int deptNo;
    private int positionNo;
    private Date hireDate;
    private String workLocation;
    private String profileImgPath;
    private String signatureImgPath;
    private String isAdmin;
    private Date lastLoginDate;
    private Date createDate;
    private Date updateDate;
    private String status;
}