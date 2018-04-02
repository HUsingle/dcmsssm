package com.dcms.service;

public interface LoginService {
    //检查学生账号
    boolean checkStu(String account,String pwd);
    boolean checkTea(String account,String pwd);
}
