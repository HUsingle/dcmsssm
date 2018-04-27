package com.dcms.controller;

import com.dcms.model.Teacher;
import com.dcms.service.LoginService;
import com.dcms.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LoginController {
    @Autowired
    LoginService loginService;
    @Autowired
    TeacherService teacherService;

    @RequestMapping("/stuLogin")
    @ResponseBody
    public String stuLogin(String account, String pwd) {
        if (loginService.checkStu(account, pwd)) {
            return "ok";
        }
        return "ng";
    }

    @RequestMapping("/teaLogin")
    @ResponseBody
    public String teaLogin(String account, String pwd) {
        if (loginService.checkTea(account, pwd)) {
            return "ok";
        }
        return "ng";
    }

    //存session
    @RequestMapping("/saveToSession")
    @ResponseBody
    public String saveToSession(String id, HttpServletRequest request) {
        request.getSession().setAttribute("account", id);
        return "ok";
    }

    //取session
    @RequestMapping("/getSession")
    @ResponseBody
    public String getSession(String sessionName, HttpServletRequest request) {

        if (request.getSession().getAttribute(sessionName) == null) {
            return "ng";
        }
        return request.getSession().getAttribute(sessionName).toString();
    }

    //注销
    @RequestMapping("/logout")
    @ResponseBody
    public String logout(String sessionName, HttpServletRequest request) {

        request.getSession().removeAttribute("userId");
        request.getSession().invalidate();
        return "ok";
    }

    @RequestMapping("/saveTeacherToSession")
    @ResponseBody
    public String saveTeacherToSession(String phone, HttpServletRequest request) {
        Teacher teacher=teacherService.findTeacherByPhone(phone);
        request.getSession().setAttribute("account", teacher);
        return "ok";
    }

    @RequestMapping("/teacherLogout")
    public String teacherLogout( HttpServletRequest request) {
        request.getSession().removeAttribute("account");
        request.getSession().invalidate();
        return "login";
    }


}


