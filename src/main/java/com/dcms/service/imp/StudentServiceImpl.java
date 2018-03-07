package com.dcms.service.imp;

import com.dcms.dao.StudentMapper;
import com.dcms.excel.ExcelData;
import com.dcms.excel.StudentExcelData;
import com.dcms.model.Student;
import com.dcms.service.StudentService;
import com.dcms.utils.ExcelUtil;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/1/20.
 */
@Service
public class StudentServiceImpl implements StudentService {
    @Autowired
    private StudentMapper studentMapper;

    public List<Student> findAllStudent(String sort) {
        List<Student> studentList = studentMapper.getAllStudent(sort);
        return studentList;
    }

    public List<Student> searchStudent(String search, String sort) {
           List<Student> studentList = studentMapper.getSearchStudent(search, sort);
        return studentList;
    }
     public String addStudent(String username, String name, String password,
                              String college, String phone,
                              String email, String studentClass) {
         Student student = new Student();
         if (Tool.isNumber(username)) {
             student.setUsername(Long.parseLong(username));
         } else {
             return Tool.result(0);
         }
         student.setPassword(password);
         student.setCollege(college);
         if(Tool.isNumber(phone)&&phone.length()!=0){
             student.setPhone(Long.parseLong(phone));
         }
         if(!Tool.isNumber(phone)){
             return Tool.result(0);
         }
         student.setEmail(email);
         student.setStudentClass(studentClass);
         student.setName(name);
         List<Student> list=new ArrayList<Student>();
         list.add(student);
         int result = studentMapper.addOrUpdateStudent(list);
        return Tool.result(result);
    }

    public String deleteStudent(String username) {
        String[] userString = username.split(",");
        Long[] userArray = new Long[userString.length];
        for (int i = 0; i < userString.length; i++)
            userArray[i] = Long.parseLong(userString[i]);
        int result = studentMapper.deleteStudent(userArray);
        return Tool.result(result);
    }

    public String updateStudent(String username, String name, String password, String college, String phone, String email, String studentClass) {
        Student student = new Student();
        student.setUsername(Long.parseLong(username));
        student.setPassword(password);
        student.setCollege(college);
        if(Tool.isNumber(phone)&&phone.length()!=0){
            student.setPhone(Long.parseLong(phone));
        }
        if(!Tool.isNumber(phone)){
            return Tool.result(0);
        }
        student.setEmail(email);
        student.setStudentClass(studentClass);
        student.setName(name);
        int result = studentMapper.updateStudent(student);
        return Tool.result(result);
    }

    public void exportStudentExcelModel(HttpServletResponse response) {
        String[] head = {"学号", "姓名", "密码", "班级", "学院", "手机号码", "电子邮箱"};
        ExcelUtil.exportModeExcel(head, "学生信息模板.xls", response,true,null,null,401);
    }

    public void exportStudentExcel(HttpServletResponse response) {
        String[] head = {"学号", "姓名", "密码", "班级", "学院", "手机号码", "电子邮箱"};
        List list=studentMapper.getAllStudent("asc");
        ExcelData excelData=new StudentExcelData();
        ExcelUtil.exportModeExcel(head, "学生信息.xls", response,false,excelData,list,0);
    }

    public String importStudentExcel(MultipartFile excelFile) {
        ExcelData studentInsertExcelData = new StudentExcelData();
        String[] head = {"学号", "姓名", "密码", "班级", "学院", "手机号码", "电子邮箱"};
        List dataList = ExcelUtil.importExcel(excelFile, head, studentInsertExcelData);
        int exResult = 0;
        String result;
        if (dataList.size() == 0) {
            return Tool.result("缺少行或者学号出错!");
        } else if (dataList.size() == 1) {
            if ((dataList.get(0) instanceof String)) {
                return dataList.get(0).toString();
            } else {
                exResult = studentMapper.addOrUpdateStudent(dataList);
            }
        } else {
            exResult = studentMapper.addOrUpdateStudent(dataList);
        }
        if (exResult == 0) {
            result = Tool.result("导入失败!");
        } else {
            result = Tool.result("导入成功!");
        }
        return result;
    }
}
