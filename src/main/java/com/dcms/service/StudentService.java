package com.dcms.service;

import com.dcms.model.Student;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by single on 2017/12/30.
 */
@Service
public interface StudentService {
    List<Student> findAllStudent();
    String addStudent(Student student);
    String deleteStudent(String username);
    String updateStudent(Student student);
}
