package com.dcms.dao;

import com.dcms.model.Student;
import org.springframework.stereotype.Repository;

/**
 * Created by single on 2017/12/27.
 */
@Repository
public interface StudentMapper {
    public Student getStudent(Integer id);
}
