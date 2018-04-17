package com.dcms.service.imp;

import com.dcms.dao.ExamArrangeMapper;
import com.dcms.model.ExamInfo;
import com.dcms.service.ExamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ExamServiceImpl implements ExamService {
    @Autowired
    ExamArrangeMapper eaMapper;
    public ExamInfo getStuExamInfo(String stuNo, String compId) {
        ExamInfo examInfo = eaMapper.qryExamTicket(stuNo,compId);
        return examInfo;
    }
}
