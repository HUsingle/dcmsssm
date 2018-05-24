package com.dcms.service.imp;

import com.alibaba.fastjson.JSON;
import com.dcms.dao.TeacherMapper;
import com.dcms.excel.ExcelData;
import com.dcms.excel.TeacherExcelData;
import com.dcms.model.Teacher;
import com.dcms.service.TeacherService;
import com.dcms.utils.ExcelUtil;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/2/28.
 */
@Service
public class TeacherServiceImpl implements TeacherService {
    @Autowired
    private TeacherMapper teacherMapper;

    public List<Teacher> getAllTeacher(String sort,Long id) {
        return teacherMapper.getAllTeacher(sort,id);
    }

    public List<Teacher> getTeacherNameAndId() {
        return teacherMapper.getTeacherNameAndId();
    }

    public String updateSelfTeacher(String id, String name, String college, String phone,
                                    String email, String sex,String password,HttpServletRequest request) {
        Teacher teacher=new Teacher();
        teacher.setId(Long.parseLong(id));
        teacher.setName(name);
        teacher.setEmail(email);
        teacher.setCollege(college);
        teacher.setPassword(password);
        teacher.setSex(sex);
        teacher.setPhone(Long.parseLong(phone));
        int result=teacherMapper.updateSelfTeacher(teacher);
        if(result>0){
            request.getSession().removeAttribute("account");
            request.getSession().setAttribute("account",teacher);
        }
        return Tool.result(result);
    }

    public String updatePassword(Long id, String password,HttpServletRequest request) {
       int result= teacherMapper.updatePassword(id,password);
       if(result>0){
           Teacher teacher=(Teacher) request.getSession().getAttribute("account");
           teacher.setPassword(password);
       }
       return Tool.result(result);
    }

    //按教师ID查询教师信息
    public String getTeacherById(String id) {
        long tid = Long.valueOf(id);
        Teacher tea = teacherMapper.findTeacherById(tid);
        String json =null;
        if(tea != null) {
            List<Teacher> list = new ArrayList<Teacher>();
            list.add(tea);
            json = JSON.toJSONString(list);
        }else {
            json = JSON.toJSONString("ng");
        }
        return json;
    }

    public String addTeacher(String name, String password, String college, String phone, String email,String sex) {
        Teacher teacher = new Teacher();
        teacher.setName(name);
        teacher.setSex(sex);
        teacher.setPassword(password);
        teacher.setCollege(college);
        teacher.setEmail(email);
        if (Tool.isNumber(phone) && phone.length() != 0) {
            teacher.setPhone(Long.parseLong(phone));
        }
        if(!Tool.isNumber(phone)){
            return Tool.result(0);
        }
        List<Teacher> teacherList = new ArrayList<Teacher>();
        teacherList.add(teacher);
        int result = teacherMapper.addTeacher(teacherList);
        return Tool.result(result);
    }

    public String deleteTeacher(String id) {
        int result = teacherMapper.deleteTeacher(Tool.getLong(id));
        return Tool.result(result);
    }

    public String updateTeacher(String id, String name, String password, String college, String phone, String email,String sex) {
        Teacher teacher=new Teacher();
        teacher.setId(Long.parseLong(id));
        teacher.setName(name);
        teacher.setPassword(password);
        teacher.setEmail(email);
        teacher.setCollege(college);
        teacher.setSex(sex);
        if(Tool.isNumber(phone)&&phone.length()!=0){
            teacher.setPhone(Long.parseLong(phone));
        }
        if(!Tool.isNumber(phone)){
            return Tool.result(0);
        }
        int result=teacherMapper.updateTeacher(teacher);
        return Tool.result(result);
    }

    public String importTeacherExcel(MultipartFile file) {
        ExcelData teacherInsertExcelData = new TeacherExcelData();
        String[] head = {"姓名", "性别", "学院", "手机号码", "电子邮箱"};
        List dataList = ExcelUtil.importExcel(file, head, teacherInsertExcelData);
        int exResult = 0;
        String result;
        if (dataList.size() == 0) {
            return Tool.result("缺少行或者所填数据不是文本类型!");
        } else if (dataList.size() == 1) {
            if ((dataList.get(0) instanceof String)) {
                return dataList.get(0).toString();
            } else {
                exResult = teacherMapper.addTeacher(dataList);
            }
        } else {
            exResult = teacherMapper.addTeacher(dataList);
        }
        if (exResult == 0) {
            result = Tool.result("导入失败!");
        } else {
            result = Tool.result("导入成功!");
        }
        return result;
    }

    public void exportTeacherExcelModel(HttpServletResponse response) {
        String[] head = {"姓名", "性别", "学院", "手机号码", "电子邮箱"};
        ExcelUtil.exportModeExcel(head, "老师信息模板.xls", response,51);
    }

    public Teacher findTeacherByPhone(String phone) {
        return teacherMapper.findTeacherByPhone(phone);
    }

    public String isExistPhone(String phone) {
        return Tool.result(teacherMapper.isExistPhone(phone));
    }
}

