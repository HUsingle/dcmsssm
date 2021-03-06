package com.dcms.dao;

import com.dcms.model.Competition;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompetitionMapper {
    Competition qryLatestComp();   //查询最新发布的竞赛

    int qryIsTeam(String id);  //查询是否是团队赛

    List<Competition> findAllCompetition();//查询所有竞赛信息（字段较少）

    List<Competition> getAllCompetition();//查询所有竞赛信息通过发布时间排序

    List<Competition> findSingleCompetition();//查询个人竞赛信息

    int addCompetition(Competition competition);//添加竞赛信息

    String findCompetitionFile(Integer id); //根据id查询文件名

    Competition findCompetitionById(Integer id);//通过id查询竞赛

    int deleteCompetition(Integer[] ids); //批量删除竞赛记录

    int updateCompetition(Competition competition);//更新竞赛

    int findCompetitionFileIsExist(String file);//添加时是否存在文件名一样的

    int findNotUpdCompetitionFileIsExist(@Param("file") String file, @Param("id") int id);//修改时除了自己是否存在文件名一样的

    String qryCompGroup(String id); //查询子类别、分组

    List<Competition> qryByPage(@Param("on")String on, @Param("end")String end, @Param("noStart")String noStart); //分页和条件查询

    String findCompetitionName(Integer id);//查询竞赛名字

    List<Competition> findCompetitionCompStatTime();//查询竞赛id和竞赛开始时间
}
