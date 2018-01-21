package com.dcms.controller;

import com.dcms.model.Student;
import com.dcms.service.StudentServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        List<Student> studentList=studentService.findAllStudent();
        //用pageInfo包装studentList,papeInfo有详细的分页信息
        PageInfo<Student> pageInfo = new PageInfo<Student>(studentList);
        model.addAttribute(studentList);
        model.addAttribute(pageInfo);
        return "studentManage";
    }
}
