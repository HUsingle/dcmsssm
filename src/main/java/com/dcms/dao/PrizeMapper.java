package com.dcms.dao;

import com.dcms.model.Prize;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by single on 2018/4/22.
 */
@Repository
public interface PrizeMapper {
    //根据竞赛Id和组别查询奖项
    List<Prize> findAllPrizeByCidOrGroupName(@Param("competitionId") Integer competitionId,
                                             @Param("groupName") String groupName, @Param("sort") String sort);

    //添加奖项
    int addPrize(List<Prize> prize);

    //删除奖项
    int deletePrize(Integer[] id);

    //更新奖项-
    int updatePrize(List<Prize> prizeList);

    //是否存在奖项
    int isExistPrize(Long username, Integer competitionId);

    //根据团队名称获取奖项id
    List<Prize> getPrizeId(@Param("competitionId") Integer competitionId,
                           @Param("teamName") String teamName);

    //根据竞赛id获取所有获奖的名单
    List<Prize> getAllPrizeUsername(Integer competitionId);

    //
    int importPrize(@Param("competitionId") Integer competitionId, @Param("list") List<Prize> prizeList);

    //是否已经有奖项
    int findPrizeNumber(@Param("competitionId") Integer competitionId,
                        @Param("groupName") String groupName);
}
