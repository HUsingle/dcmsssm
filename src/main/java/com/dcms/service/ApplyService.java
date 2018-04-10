package com.dcms.service;

import com.dcms.model.Apply;

import java.util.List;

public interface ApplyService {
    //个人赛报名
    boolean insertOneSelfInfo(String stuNo,String compId,String groupName);
    //判断个人赛是否重复报名
    boolean isExistSelfInfo(String stuNo,String compId);
    //判断团队名称是否存在
    boolean isExistGroupName(String tName);
    //团队报名
    boolean teamApply(String list,String tid,String compId,String groupName,String tName);
    //通过竞赛的id和组的名字查询报名情况
    List<Apply> findApplyByCidAndGroup( int id, String groupName,String sort);
}
