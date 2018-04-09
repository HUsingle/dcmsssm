package com.dcms.dao;
import com.dcms.model.Apply;
import  java.util.List;
public interface ApplyMapper {
    //插入一条个人赛信息
    int insertOneSelfInfo(String stuNo,String compId,String groupName);
    //判断个人赛是否已经报名
    String isExistSelfInfo(String stuNo,String compId);
    //根据竞赛id查询团队名称。
    String qryGroupNameByCid(String tName);
    //批量插入报名信息
    int insertBench(List<Apply> list);
}
