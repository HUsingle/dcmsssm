package com.dcms.dao;

public interface ApplyMapper {
    //插入一条个人赛信息
    int insertOneSelfInfo(String stuNo,String compId,String groupName);
    //判断个人赛是否已经报名
    String isExistSelfInfo(String stuNo,String compId);
}
