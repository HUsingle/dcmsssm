package com.dcms.dao;

import com.dcms.model.Apply;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ApplyMapper {
    //插入一条个人赛信息
    int insertOneSelfInfo(String stuNo, String compId, String groupName);

    //更新一条个人报名记录
    int updateOneSelfInfo(@Param("id") Long id, @Param("competitionId") Integer competitionId,
                          @Param("competitionGroup") String competitionGroup, @Param("username") Long username);

    //判断个人赛是否已经报名
    String isExistSelfInfo(String stuNo, String compId);

    //查询竞赛竞赛团队名称是否存在。
    int qryNumByTeamName(String tName);

    //批量插入报名信息
    int insertBench(List<Apply> list);

    //批量更新报名信息
    int batchUpdateApply(List<Apply> list);

    //通过竞赛的id和组的名字查询报名情况
    List<Apply> findApplyByCidAndGroup(@Param("id") Integer id, @Param("groupName") String groupName, @Param("sort") String sort);

    //删除报名信息
    int deleteApply(Long[] id);

    //根据团队名称查询报名信息
    List<Apply> findApplyByTeamName(String groupName);
}
