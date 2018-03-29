package com.dcms.controller;

import com.dcms.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/login")
public class LoginController {
    @Autowired
    LoginService loginService;
    @RequestMapping("/stuLogin")
    @ResponseBody
    public String stuLogin(String account,String pwd){
        if (loginService.checkStu(account,pwd)){
            return "ok";
        }
        return "ng";
    }

    //存session
    @RequestMapping("/saveToSession")
    public void saveToSession(String id, HttpServletRequest request){
        request.getSession().setAttribute("account",id);
    }
    //取session
    @RequestMapping("/getSession")
    public String getSession(String sessionName,HttpServletRequest request){
       String str= request.getSession().getAttribute(sessionName).toString();
       return str;
    }
}


