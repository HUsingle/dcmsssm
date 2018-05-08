package com.dcms.dao;

import com.dcms.model.ExamInfo;
import org.springframework.stereotype.Repository;

@Repository
public interface ExamArrangeMapper {
    ExamInfo qryExamTicket(String stuNo,String compId);
}
