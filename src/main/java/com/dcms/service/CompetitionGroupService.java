package com.dcms.service;

import com.dcms.model.CompetitionGroup;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by single on 2018/3/25.
 */
@Service
public interface CompetitionGroupService {
    //查询所有竞赛组别
    List<CompetitionGroup> getAllCompetitionGroup(String sort);
    //增加竞赛组别
    String addCompetitionGroup(String id, String name);
    //删除竞赛组别
    String deleteCompetitionGroup(String id);
    //更新竞赛组别
    String updateCompetitionGroup(String id,String name);
   
}
