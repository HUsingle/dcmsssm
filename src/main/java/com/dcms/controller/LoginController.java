package com.dcms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login")
public class LoginController {
    /*@Autowired
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
    }*/
}


