package com.dcms.service;

import com.dcms.model.Teacher;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/2/28.
 */
@Service
public interface TeacherService {
    //查询所有老师
    List<Teacher> getAllTeacher(String sort,Long id);
    //查询所有老师id和name
    List<Teacher> getTeacherNameAndId();
    //按id查询
    String getTeacherById(String id);
    //增加老师
    String addTeacher(String name, String password,String college,
                      String phone, String email,String sex);
    //删除老师
    String deleteTeacher(String id);
    //更新老师
    String updateTeacher(String id,String name, String password,String college,
                         String phone, String email,String sex);
    //更新个人信息
    String updateSelfTeacher(String id,String name,String college,
                         String phone, String email,String sex,HttpServletRequest request,
                             String password);

    //修改密码
    int updatePassword(Long id,String password);
    //导入老师
    String importTeacherExcel(MultipartFile file);
    //导出老师模板
    void exportTeacherExcelModel(HttpServletResponse response);
    //获取老师的名字
    Teacher findTeacherByPhone(String phone);
}
