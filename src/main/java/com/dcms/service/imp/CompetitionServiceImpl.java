package com.dcms.service.imp;

import com.dcms.dao.CompetitionMapper;
import com.dcms.model.Competition;
import com.dcms.service.CompetitionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CompetitionServiceImpl implements CompetitionService {
    @Autowired
    CompetitionMapper compMapper;
    //获取最新的竞赛
    public Competition getLatestComp() {
        Competition competition = compMapper.qryLatestComp();
       // System.out.println(competition.getName());
        return competition;
    }
}
