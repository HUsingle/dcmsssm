package com.dcms.dao;

import com.dcms.model.CompetitionGroup;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by single on 2018/3/25.
 */
@Repository
public interface CompetitionGroupMapper {
    List<CompetitionGroup> getAllCompetitionGroup(@Param("sort") String sort);
    int updateCompetitionGroup(CompetitionGroup competitionGroup);
    int deleteCompetitionGroup(Integer[] ids);
    int addCompetitionGroup(CompetitionGroup competitionGroup);
}
