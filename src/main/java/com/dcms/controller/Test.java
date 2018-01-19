package com.dcms.controller;

import com.dcms.dao.StudentMapper;
import com.dcms.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by single on 2017/12/25.
 */
@Controller
@RequestMapping("/hello")
public class Test {
    @Autowired
    private StudentMapper studentMapper;
    @RequestMapping(value = "/test")
    public @ResponseBody Student hello(){
        Student student=new Student();
        student.setId(1l);
        student.setName("ha");
        return student;
    }
    @RequestMapping(value = "/getStudent")
    public @ResponseBody Student getStudent(){
        return studentMapper.getStudent(114583010106l);
    }

    @RequestMapping(value = "/login")
    public  String ha(){
        return "login";
    }
}
