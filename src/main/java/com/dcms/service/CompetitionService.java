package com.dcms.service;

import com.dcms.model.Competition;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public interface CompetitionService {
    String getLatestComp();

    boolean qryIsTeam(String id);   // 判断是否是团队赛
    //查询所有竞赛
    List<Competition> findAllCompetition();
    //添加竞赛
    String addCompetition(MultipartFile file,HttpServletRequest request);
    //修改竞赛
    String updateCompetition(MultipartFile file,HttpServletRequest request);
    //删除竞赛
    String deleteCompetition(String id,HttpServletRequest request);
    //查询子类别
    String getCompGroup(String id);
}