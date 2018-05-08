package com.dcms.controller;

import com.alibaba.fastjson.JSONObject;
import com.dcms.model.Teacher;
import com.dcms.service.TeacherService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/2/28.
 */
@Controller
@RequestMapping(value = "/teacher")
public class TeacherController {
    @Autowired
   private TeacherService teacherService;

    @RequestMapping(value = "/getTeacherList", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String getAllTeacher(@RequestParam(defaultValue = "1") Integer offset,
                                @RequestParam(defaultValue = "10") Integer limit,
                                @RequestParam(defaultValue = "asc")  String sort,
                                Long id) {
        PageHelper.startPage(offset, limit);
        List<Teacher> teacherList = teacherService.getAllTeacher(sort,id);
        PageInfo<Teacher> pageInfo = new PageInfo<Teacher>(teacherList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", teacherList);
        return result.toJSONString();
    }

    @RequestMapping(value = "/addTeacher", method = RequestMethod.POST)
    @ResponseBody
    public String addTeacher(@RequestParam("sex") String sex, @RequestParam("name") String name,
                             @RequestParam("password") String password, @RequestParam("college") String college,
                             @RequestParam("phone") String phone, @RequestParam("email") String email) {
        return teacherService.addTeacher(name,password,college,phone,email,sex);
    }

    @RequestMapping(value = "/updateTeacher", method = RequestMethod.POST)
    @ResponseBody
    public String updateTeacher(@RequestParam("id") String id, @RequestParam("name") String name,
                                @RequestParam("password") String password, @RequestParam("college") String college,
                                @RequestParam("phone") String phone, @RequestParam("email") String email,
                                @RequestParam("sex") String sex) {
        return teacherService.updateTeacher(id,name,password,college,phone,email,sex);

    }

    @RequestMapping(value = "/updateSelfTeacher", method = RequestMethod.POST)
    @ResponseBody
    public String updateSelfTeacher(@RequestParam("id") String id, @RequestParam("name") String name,
                                    @RequestParam("college") String college,
                                    @RequestParam("phone") String phone, @RequestParam("email") String email,
                                    @RequestParam("sex") String sex, HttpServletRequest request) {
        return teacherService.updateSelfTeacher(id,name,college,phone,email,sex,request);

    }

    @RequestMapping(value = "/updateTeacherPassword", method = RequestMethod.POST)
    @ResponseBody
    public String updateTeacherPassword(@RequestParam("id") Long id,
                                @RequestParam("password") String password,HttpServletRequest request){
        return teacherService.updatePassword(id,password,request);

    }

    @RequestMapping(value = "/deleteTeacher", method = RequestMethod.POST)
    @ResponseBody
    public String deleteTeacher(@RequestParam("id") String id) {
        return teacherService.deleteTeacher(id);

    }

    @RequestMapping(value = "/exportTeacherExcelModel")
    public void exportTeacherExcelModel(HttpServletResponse response) {
        teacherService.exportTeacherExcelModel(response);
    }

   

    @RequestMapping(value = "/importTeacherExcel",  produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String importTeacherExcel(@RequestParam("excelFile") MultipartFile excelFile) {
        return teacherService.importTeacherExcel(excelFile);
    }

    @RequestMapping("/getTeacherById")
    @ResponseBody
    public String getTeacherById(String id){
        return teacherService.getTeacherById(id);
    }



}
