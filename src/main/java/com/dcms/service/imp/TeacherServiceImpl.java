package com.dcms.service.imp;

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

    public List<Teacher> getAllTeacher(String sort) {
        return teacherMapper.getAllTeacher(sort);
    }

    public String addTeacher(String id, String name, String password, String college, String phone, String email) {
        Teacher teacher = new Teacher();
        if (Tool.isNumber(id)) {
            teacher.setId(Long.parseLong(id));
        } else {
            return Tool.result(0);
        }
        teacher.setName(name);
        teacher.setPassword(password);
        teacher.setCollege(college);
        teacher.setEmail(email);
        if (Tool.isNumber(phone) && phone.length() != 0) {
            teacher.setPhone(Long.parseLong(phone));
        }
        List<Teacher> teacherList = new ArrayList<Teacher>();
        teacherList.add(teacher);
        int result = teacherMapper.addOrUpdateTeacher(teacherList);
        return Tool.result(result);
    }

    public String deleteTeacher(String id) {
        String[] idString = id.split(",");
        Long[] idArray = new Long[idString.length];
        for (int i = 0; i < idString.length; i++)
            idArray[i] = Long.parseLong(idString[i]);
        int result = teacherMapper.deleteTeacher(idArray);
        return Tool.result(result);
    }

    public String updateTeacher(String id, String name, String password, String college, String phone, String email) {
        Teacher teacher=new Teacher();
        teacher.setId(Long.parseLong(id));
        teacher.setName(name);
        teacher.setPassword(password);
        teacher.setEmail(email);
        teacher.setCollege(college);
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
        String[] head = {"老师编号", "姓名", "密码", "学院", "手机号码", "电子邮箱"};
        List dataList = ExcelUtil.importExcel(file, head, teacherInsertExcelData);
        int exResult = 0;
        String result;
        if (dataList.size() == 0) {
            return Tool.result("缺少行或者老师编号出错!");
        } else if (dataList.size() == 1) {
            if ((dataList.get(0) instanceof String)) {
                return dataList.get(0).toString();
            } else {
                exResult = teacherMapper.addOrUpdateTeacher(dataList);
            }
        } else {
            exResult = teacherMapper.addOrUpdateTeacher(dataList);
        }
        if (exResult == 0) {
            result = Tool.result("导入失败!");
        } else {
            result = Tool.result("导入成功!");
        }
        return result;
    }

    public void exportTeacherExcelModel(HttpServletResponse response) {
        String[] head = {"老师编号", "姓名", "密码", "学院", "手机号码", "电子邮箱"};
        ExcelUtil.exportModeExcel(head, "老师信息模板.xls", response,true,null,null);
    }
}

