package com.dcms.service.imp;

import com.dcms.dao.ApplyMapper;
import com.dcms.service.ApplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ApplyServiceImpl implements ApplyService {
    @Autowired
    ApplyMapper applyMapper;
    //个人赛报名
    public boolean insertOneSelfInfo(String stuNo, String compId,String groupName) {
        int i = applyMapper.insertOneSelfInfo(stuNo,compId,groupName);
        System.out.print(i+"asdasdasd" +
                "");
        if (i == 1){
            return true;
        }
        return false;
    }
    //判断个人赛是否重复报名
    public boolean isExistSelfInfo(String stuNo, String compId) {
        String s=applyMapper.isExistSelfInfo(stuNo,compId);
        if (s!=null&&s!=""){
            return true;
        }
        return false;
    }
}
