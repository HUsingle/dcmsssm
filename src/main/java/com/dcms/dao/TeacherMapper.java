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
     List<Teacher> getAllTeacher(@Param("sort") String sort);
     int updateTeacher(Teacher teacher);
     int deleteTeacher(Long[] ids);
     int addOrUpdateTeacher(List<Teacher> teachers);
}
