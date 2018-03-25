package com.dcms.service.imp;

import com.alibaba.fastjson.JSON;
import com.dcms.dao.CompetitionMapper;
import com.dcms.model.Competition;
import com.dcms.service.CompetitionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CompetitionServiceImpl implements CompetitionService {
    @Autowired
    CompetitionMapper compMapper;
    //获取最新的竞赛
    public String getLatestComp() {
        Competition competition = compMapper.qryLatestComp();
        List list = new ArrayList();
        list.add(competition);
        String json = JSON.toJSONString(list);
        return json;
    }
    //判断是否是团队赛
    public boolean qryIsTeam(String id) {
        System.out.print("sdasdas"+compMapper.qryIsTeam(id));
        int isTeam = compMapper.qryIsTeam(id);
        if (isTeam==1){
            return true;
        }
        return false;
    }
}
