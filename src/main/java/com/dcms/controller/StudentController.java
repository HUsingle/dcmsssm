package com.dcms.controller;

import com.alibaba.fastjson.JSONObject;
import com.dcms.model.Student;
import com.dcms.service.StudentServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by single on 2018/1/20.
 */
@Controller
@RequestMapping(value = "/student")
public class StudentController {
    @Autowired
    private StudentServiceImpl studentService;

    @RequestMapping(value = "/getAllStudent")
    public String getAllStudent(Model model,
                                @RequestParam(defaultValue = "1") Integer pageNow) {
        //获取第pageNow页，pageSize条内容
        PageHelper.startPage(pageNow, 10);
        //查询所有学生信息,分页
        List<Student> studentList = studentService.findAllStudent();
        //用pageInfo包装studentList,papeInfo有详细的分页信息
        PageInfo<Student> pageInfo = new PageInfo<Student>(studentList);
        model.addAttribute(studentList);
        model.addAttribute(pageInfo);
        return "studentManage";
    }
    @RequestMapping(value = "/getStudentList",produces = "application/json;charset=UTF-8")
    public @ResponseBody String getAllStudent(@RequestParam(defaultValue = "1") Integer offset,
                                              @RequestParam(defaultValue = "10") Integer limit){
        PageHelper.startPage(offset,limit);
        List<Student> studentList=studentService.findAllStudent();
        PageInfo<Student> pageInfo=new PageInfo<Student>(studentList);
        JSONObject result=new JSONObject();
        //bootStrap-table服务器分页要包括total和rows两部分
        result.put("total",pageInfo.getTotal());
        result.put("rows",studentList);
        return result.toJSONString();
    }

    @RequestMapping(value = "/addStudent", method = RequestMethod.POST)
    public String addStudent(@RequestParam("username") Long username, @RequestParam("name") String name,
                             @RequestParam("password") String password, @RequestParam("college") String college,
                             @RequestParam("phone") Long phone, @RequestParam("email") String email,
                             @RequestParam("studentClass") String studentClass) {
        Student student=new Student();
        student.setUsername(username);
        student.setPassword(password);
        student.setCollege(college);
        student.setPhone(phone);
        student.setEmail(email);
        student.setStudentClass(studentClass);
        student.setName(name);
        studentService.addStudent(student);
        return "redirect:/student/getAllStudent";
    }
}
