package com.dcms.dao;

import com.dcms.model.ExamInfo;

public interface ExamArrangeMapper {
    ExamInfo qryExamTicket(String stuNo,String compId);
}
