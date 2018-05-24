package com.dcms.dao;

import com.dcms.model.Teacher;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by single on 2018/2/28.
 */
@Repository
public interface TeacherMapper {
     List<Teacher> getAllTeacher(@Param("sort") String sort,@Param("id") Long id);
     List<Teacher> getTeacherNameAndId();
     int updateTeacher(Teacher teacher);
     int updateSelfTeacher(Teacher teacher);
     int deleteTeacher(Long[] ids);
     int addTeacher(List<Teacher> teachers);
     Teacher findTeacherById(Long id);
     List<Teacher> findAllTeacherIdAndSex();
     int checkTeacher(@Param("phone") String phone,@Param("password") String password);
     Teacher findTeacherByPhone(String phone);
     int updatePassword(@Param("id") Long id,@Param("password") String password);
     int isExistPhone(String phone);
}
