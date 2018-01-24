package com.dcms.dao;

import com.dcms.model.Student;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by single on 2017/12/27.
 */
@Repository
public interface StudentMapper {
     List<Student> getAllStudent();
     int addStudent(Student student);
     int deleteStudent(Long id);
}
