package com.dcms.dao;

import com.dcms.model.Rise;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by single on 2018/4/23.
 */
@Repository
public interface RiseMapper {
    //根据竞赛Id和组别查询晋级名单
    List<Rise> findAllRiseByCidOrGroupName(@Param("competitionId") Integer competitionId,
                                           @Param("groupName") String groupName, @Param("sort") String sort);

    //添加晋级名单
    int addRise(List<Rise> Rise);

    //删除晋级名单
    int deleteRise(Integer[] id);

    //是否存在晋级名单
    int isExistRise(Long username, Integer competitionId);

    //根据团队名称获取晋级名单id
    List<Rise> getRiseId(@Param("competitionId") Integer competitionId,
                         @Param("teamName") String teamName);

    //导入晋级名单
    int importRise(@Param("competitionId") Integer competitionId, @Param("list") List<Rise> RiseList);

    //是否已经有晋级名单
    int findRiseNumber(@Param("competitionId") Integer competitionId);

    //导出相关数据
    List<Rise> exportRiseData(@Param("competitionId") Integer competitionId);
}
