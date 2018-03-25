package com.dcms.dao;

import com.dcms.model.Competition;
import org.springframework.stereotype.Repository;

@Repository
public interface CompetitionMapper {
    Competition qryLatestComp();   //查询最新发布的竞赛
     int qryIsTeam(String id);  //查询是否是团队赛
}
