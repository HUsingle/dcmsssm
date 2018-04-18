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
    //通过学号排序查询所有学生
    List<Student> getAllStudent(@Param("sort") String sort);
    //通过学生的名字或者班级查询学生信息
    List<Student> getSearchStudent(@Param("search") String search, @Param("sort") String sort);

    // int addStudent(Student student);
    //批量删除
    int deleteStudent(Long[] userArray);
   //更新学生
    int updateStudent(Student student);

    //插入数据如果主键存在则更新
    int addOrUpdateStudent(List<Student> list);

    //查询指定账号密码的学生信息
    Student qryByAccountAndPwd(String account, String pwd);

    //根据学号查学生信息
    Student qryById(String account);

    //查询所有学号
    List<Student> findAllUsername();

    Student findStudentById(Long username);
}
