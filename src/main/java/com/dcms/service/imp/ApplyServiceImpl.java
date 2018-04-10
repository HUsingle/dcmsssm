package com.dcms.service.imp;

import com.dcms.dao.ApplyMapper;
import com.dcms.model.Apply;
import com.dcms.service.ApplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

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
        if (s!=null&&!s.equals("")){
            return true;
        }
        return false;
    }
    //判断团队名称是否存在  存在返回true
    public boolean isExistGroupName(String tName) {
        String s = applyMapper.qryGroupNameByCid(tName);
        if (s!=null&&!s.equals("")){
            return true;
        }
        return false;
    }

    public boolean teamApply(String list, String tid, String compId, String groupName, String tName) {
        String [] stu = list.split(",");
        Apply  apply =null;
        List<Apply> applyList = new ArrayList<Apply>();
        for (int i=0;i<stu.length;i++){
            apply = new Apply();
            int leader = 0;
            if(i==0){
                leader =1;
            }
            apply.setCompetitionId(Integer.valueOf(compId));
            apply.setUsername(Long.valueOf(stu[i]));
            apply.setIsGroupLeader(leader);
            apply.setGroupName(tName);
            apply.setCompetitionGroup(groupName);
            if (!tid.equals("")){
                apply.setTeacherId(Long.valueOf(tid));
            }

            applyList.add(apply);
        }
        int i= applyMapper.insertBench(applyList);
        if (i>=1){
            return true;
        }
        return false;
    }

    public List<Apply> findApplyByCidAndGroup(int id, String groupName, String sort) {
        return applyMapper.findApplyByCidAndGroup(id,groupName,sort);
    }
}
