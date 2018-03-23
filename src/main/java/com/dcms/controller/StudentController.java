package com.dcms.controller;

import com.alibaba.fastjson.JSONObject;
import com.dcms.model.Student;
import com.dcms.service.StudentService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/1/20.
 */
@Controller
@RequestMapping(value = "/student")
public class StudentController {
    @Autowired
    private StudentService studentService;

    /* @RequestMapping(value = "/getAllStudent")
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
     }*/

    @RequestMapping(value = "/getStudentList", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String getAllStudent(@RequestParam(defaultValue = "1") Integer offset,
                         @RequestParam(defaultValue = "10") Integer limit,
                         @RequestParam(defaultValue = "asc")  String sort) {
        PageHelper.startPage(offset, limit);
        List<Student> studentList = studentService.findAllStudent(sort);
        PageInfo<Student> pageInfo = new PageInfo<Student>(studentList);
        JSONObject result = new JSONObject();
        //bootStrap-table服务器分页要包括total和rows两部分
        result.put("total", pageInfo.getTotal());
        result.put("rows", studentList);
        return result.toJSONString();
    }

    @RequestMapping(value = "/getSearchStudentList", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String getSearchStudent(@RequestParam(defaultValue = "1") Integer offset,
                                @RequestParam(defaultValue = "10") Integer limit,
                                @RequestParam(defaultValue = "asc")  String sort,
                                @RequestParam(defaultValue = "")  String search) {
        PageHelper.startPage(offset, limit);
        List<Student> studentList = studentService.searchStudent(search,sort);
        PageInfo<Student> pageInfo = new PageInfo<Student>(studentList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", studentList);
        return result.toJSONString();
    }

    @RequestMapping(value = "/addStudent", method = RequestMethod.POST)
    @ResponseBody
    public String addStudent(@RequestParam("username") String username, @RequestParam("name") String name,
                             @RequestParam("password") String password, @RequestParam("college") String college,
                             @RequestParam("phone") String phone, @RequestParam("email") String email,
                             @RequestParam("studentClass") String studentClass) {
        return studentService.addStudent(username,name,password,college,phone,email,studentClass);
    }

    @RequestMapping(value = "/updateStudent", method = RequestMethod.POST)
    @ResponseBody
    public String updateStudent(@RequestParam("username") String username, @RequestParam("name") String name,
                                @RequestParam("password") String password, @RequestParam("college") String college,
                                @RequestParam("phone") String phone, @RequestParam("email") String email,
                                @RequestParam("studentClass") String studentClass) {
        return studentService.updateStudent(username,name,password,college,phone,email,studentClass);

    }

    @RequestMapping(value = "/deleteStudent", method = RequestMethod.POST)
    @ResponseBody
    public String deleteStudent(@RequestParam("id") String id) {
        return studentService.deleteStudent(id);

    }

    @RequestMapping(value = "/exportStudentExcelModel")
    public void exportStudentExcelModel(HttpServletResponse response) {
        studentService.exportStudentExcelModel(response);
    }

    @RequestMapping(value = "/exportStudentExcel")
    public void exportStudentExcel(HttpServletResponse response) {
       studentService.exportStudentExcel(response);
    }

    @RequestMapping(value = "/importStudentExcel",  produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String importStudentExcel(@RequestParam("excelFile") MultipartFile excelFile) {
        /*MultipartFile excelFile = null;
        if (request instanceof MultipartHttpServletRequest) {
            MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
            excelFile = multipart.getFile("excelFile");
        }*/
        return studentService.importStudentExcel(excelFile);
    }


}
