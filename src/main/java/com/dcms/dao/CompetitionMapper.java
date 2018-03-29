package com.dcms.dao;

import com.dcms.model.Competition;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompetitionMapper {
     Competition qryLatestComp();   //查询最新发布的竞赛
     int qryIsTeam(String id);  //查询是否是团队赛
     List<Competition> findAllCompetition();//查询所有竞赛信息
     int addCompetition(Competition competition);//添加竞赛信息
     String findCompetitionFile(int id);
     int deleteCompetition(Integer[] ids);
     int updateCompetition(Competition competition);
}
