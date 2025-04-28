package com.kh.flokrGroupware.employee.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
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
    
    
    public String getPasswordHash() {
        return this.passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }
    
    public String getEmpId() {
        return this.empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }
    
    public String getProfileImgPath() {
        return this.profileImgPath;
    }

    public void setProfileImgPath(String profileImgPath) {
        this.profileImgPath = profileImgPath;
    }

    public String getSignatureImgPath() {
        return this.signatureImgPath;
    }

    public void setSignatureImgPath(String signatureImgPath) {
        this.signatureImgPath = signatureImgPath;
    }

    public String getEmpName() {
        return this.empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getIsAdmin() {
        return this.isAdmin;
    }

    public void setIsAdmin(String isAdmin) {
        this.isAdmin = isAdmin;
    }
    
}