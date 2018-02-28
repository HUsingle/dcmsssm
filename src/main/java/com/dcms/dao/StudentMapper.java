package com.dcms.dao;

import com.dcms.model.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by single on 2017/12/27.
 */
@Repository
public interface StudentMapper {
     List<Student> getAllStudent(@Param("sort") String sort);
     List<Student> getSearchStudent(@Param("search") String search,@Param("sort") String sort);
     int addStudent(Student student);
     int deleteStudent(Long[] userArray);
     int updateStudent(Student student);
     //插入数据如果主键存在则更新
     int addOrUpdateStudent(List<Student> list);
}
