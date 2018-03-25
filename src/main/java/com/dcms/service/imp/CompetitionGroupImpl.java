package com.dcms.service.imp;

import com.dcms.dao.CompetitionGroupMapper;
import com.dcms.model.CompetitionGroup;
import com.dcms.service.CompetitionGroupService;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by single on 2018/3/25.
 */
@Service
public class CompetitionGroupImpl implements CompetitionGroupService{
    @Autowired
    private CompetitionGroupMapper competitionGroupMapper;

    public List<CompetitionGroup> getAllCompetitionGroup(String sort) {
        return competitionGroupMapper.getAllCompetitionGroup(sort);
    }

    public String addCompetitionGroup(String id, String name) {
        CompetitionGroup competitionGroup=new CompetitionGroup();
        if (Tool.isNumber(id) && id.length() != 0) {
            competitionGroup.setId(Integer.parseInt(id));
        }
        if(!Tool.isNumber(id)){
            return Tool.result(0);
        }
        competitionGroup.setName(name);
        return Tool.result(competitionGroupMapper.addCompetitionGroup(competitionGroup));
    }

    public String deleteCompetitionGroup(String id) {
        int result = competitionGroupMapper.deleteCompetitionGroup(Tool.getInteger(id));
        return Tool.result(result);
    }

    public String updateCompetitionGroup(String id, String name) {
        CompetitionGroup competitionGroup=new CompetitionGroup();
        competitionGroup.setId(Integer.parseInt(id));
        competitionGroup.setName(name);
        return Tool.result(competitionGroupMapper.updateCompetitionGroup(competitionGroup));
    }
}
