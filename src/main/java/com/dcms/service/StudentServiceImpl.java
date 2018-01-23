package com.dcms.service;

import com.dcms.dao.StudentMapper;
import com.dcms.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by single on 2018/1/20.
 */
@Service
public class StudentServiceImpl implements StudentService {
    @Autowired
    private StudentMapper studentMapper;

    public List<Student> findAllStudent() {
        List<Student> studentList = studentMapper.getAllStudent();
        return studentList;
    }

    public void addStudent(Student student) {
        studentMapper.addStudent(student);
    }
}
