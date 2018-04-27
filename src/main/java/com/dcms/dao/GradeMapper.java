package com.dcms.dao;

import com.dcms.model.CompetitionStat;
import com.dcms.model.Grade;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by single on 2018/4/19.
 */
@Repository
public interface GradeMapper {
    //根据竞赛Id和组别查询成绩
    List<Grade> findAllGradeByCidOrGroupName(@Param("competitionId") Integer competitionId,
                                             @Param("groupName") String groupName, @Param("sort") String sort);

    //添加成绩
    int addGrade(List<Grade> grade);

    //删除成绩
    int deleteGrade(Integer[] id);

    //更新成绩-
    int updateGrade(List<Grade> gradeList);

    //是否存在成绩
    int isExistGrade(Long username, Integer competitionId);

    //根据团队名称获取成绩id
    List<Grade> getGradeId(@Param("competitionId") Integer competitionId,
                           @Param("groupName") String groupName);

    int importGrade(@Param("competitionId") Integer competitionId, @Param("list") List<Grade> gradeList);

    //导出成绩
    List<Grade> exportGrade(Integer competitionId);

    //根据成绩排序获取设置获奖人数的学号
    List<Grade> getPrizeNum(@Param("competitionId") Integer competitionId,
                            @Param("groupName") String groupName, @Param("num") Integer num);

    //查询竞赛的总平均分
    List<CompetitionStat> getCompetitionAvgById(@Param("id")Integer id);

    //查询各组别的平均分
    List<CompetitionStat> getCompetitionAvgByGroup(@Param("id")Integer id);

    //查询各组别的最高分和最低分
    List<CompetitionStat> getMaxAndMinGradeByGroup(@Param("id")Integer id);
    //查询竞赛的最高分和最低分
    List<CompetitionStat> getMaxAndMinGradeById(@Param("id")Integer id);


}
