package com.dcms.service;

import com.dcms.model.Student;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2017/12/30.
 */
@Service
public interface StudentService {
    /*查找所有学生*/
    List<Student> findAllStudent(String sort);
    //查询所有学生学号
    List<Student> findAllUsername();
    //按班级/名字查找学生
    List<Student> searchStudent(String search,String sort);
    //按学号查询
    String qryById(String account);
    //添加学生
    String addStudent(String username,String name, String password,String college,
                      String phone, String email, String studentClass);
    //删除学生
    String deleteStudent(String username);
    //更新学生
    String updateStudent(String username,String name, String password,String college,
                         String phone, String email, String studentClass);
    //导入学生
    String importStudentExcel(MultipartFile file);
    //导出学生模板
    void exportStudentExcelModel(HttpServletResponse response);
    //导出学生信息
    void  exportStudentExcel(HttpServletResponse response);
}
