package com.dcms.service;

import com.dcms.model.Student;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * Created by single on 2017/12/30.
 */
@Service
public interface StudentService {
    List<Student> findAllStudent(String sort);
    List<Student> searchStudent(String search,String sort);
    String addStudent(String username,String name, String password,String college,
                      String phone, String email, String studentClass);
    String deleteStudent(String username);
    String updateStudent(String username,String name, String password,String college,
                         String phone, String email, String studentClass);
    String addOrUpdateStudent(List<Student> list);
    String importStudentExcel(MultipartFile file);
}
