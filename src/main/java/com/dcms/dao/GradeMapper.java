package com.dcms.dao;

import com.dcms.model.Grade;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by single on 2018/4/19.
 */
@Repository
public interface GradeMapper {
    List<Grade> findAllGradeByCidOrGroupName();
}
