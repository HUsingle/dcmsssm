package com.dcms.service;

import com.dcms.dao.StudentMapper;
import com.dcms.model.Student;
import com.dcms.utils.Tool;
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

    public String addStudent(Student student) {
        int result=studentMapper.addStudent(student);
        return Tool.result(result);
    }

    public String deleteStudent(String username) {
        String[] userString=username.split(",");
        Long[] userArray=new Long[userString.length];
        for (int i=0;i<userString.length;i++)
            userArray[i]=Long.parseLong(userString[i]);
        int result=studentMapper.deleteStudent(userArray);
        return Tool.result(result);
    }

    public String updateStudent(Student student) {
        int result=studentMapper.updateStudent(student);
        return Tool.result(result);
    }
}
