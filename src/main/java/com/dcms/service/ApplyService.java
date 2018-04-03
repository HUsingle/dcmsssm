package com.dcms.service;

public interface ApplyService {
    //个人赛报名
    boolean insertOneSelfInfo(String stuNo,String compId,String groupName);
    //判断个人赛是否重复报名
    boolean isExistSelfInfo(String stuNo,String compId);
}
