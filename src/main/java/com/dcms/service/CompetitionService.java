package com.dcms.service;

import org.springframework.stereotype.Service;

@Service
public interface CompetitionService {
    String getLatestComp();
    boolean qryIsTeam(String id);   // 判断是否是团队赛
}
