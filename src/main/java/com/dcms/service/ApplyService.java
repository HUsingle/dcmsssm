package com.dcms.service;

import com.dcms.model.Apply;
import com.dcms.model.Competition;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface ApplyService {
    //个人赛报名
    boolean insertOneSelfInfo(String stuNo, String compId, String groupName);

    //更新个人报名
    String updateOneSelfInfo(Long id, Integer competitionId, String competitionGroup, Long username);

    //判断个人赛是否重复报名
    boolean isExistSelfInfo(String stuNo, String compId);

    //判断团队名称是否存在
    boolean isExistGroupName(String tName);

    //团队报名
    boolean teamApply(String list, String tid, String compId, String groupName, String tName);

    //解析报名表excel,个人报名（没组别）
    String importOneApplyNoGroup(MultipartFile excelFile, boolean hasGroup, Competition competition);

    //通过竞赛的id和组的名字查询报名情况
    List<Apply> findApplyByCidAndGroup(Integer id, String groupName, String sort);

    //删除报名信息
    String deleteApply(String id);

    //根据团队名称查询报名信息
    String findApplyByTeamName(String groupName);

    //批量更新
    String batchUpdateApply(String id, String isGroupLeader, String list, Long tid, String groupName, String tName, Integer competitionId);

    //查询报名组别报名人数
    String findNumByGroup(Integer id);

    //导出报名模板
    void exportApplyExcelModel(HttpServletResponse response);

    //导入报名信息
    String importApplyExcel(MultipartFile file, Integer competitionId);
}
