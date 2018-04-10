package com.dcms.dao;
import com.dcms.model.Apply;
import  java.util.List;

import com.dcms.model.Apply;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ApplyMapper {
    //插入一条个人赛信息
    int insertOneSelfInfo(String stuNo,String compId,String groupName);
    //判断个人赛是否已经报名
    String isExistSelfInfo(String stuNo,String compId);
    //根据竞赛id查询团队名称。
    String qryGroupNameByCid(String tName);
    //批量插入报名信息
    int insertBench(List<Apply> list);
      //通过竞赛的id和组的名字查询报名情况
    List<Apply> findApplyByCidAndGroup(@Param("id") int id,@Param("groupName") String groupName,@Param("sort") String sort);
}
