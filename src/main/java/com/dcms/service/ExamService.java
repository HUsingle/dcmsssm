package com.dcms.service;

import com.dcms.model.ExamInfo;

public interface ExamService {
    ExamInfo getStuExamInfo(String stuNo,String compId);
}
