package com.dcms.service;

import com.dcms.model.Prize;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/4/22.
 */
public interface PrizeService {
    //根据竞赛Id和组别查询奖项
    List<Prize> findAllPrizeByCidOrGroupName(Integer competitionId, String groupName, String sort);

    //添加奖项
    String addPrize(Integer competitionId, String prize, String username, Integer isTeam);

    //删除奖项
    String deletePrize(String id);

    //更新奖项-
    String updatePrize(String prize, String id, Integer isTeam, Integer competitionId);

    //导入奖项
    String importPrizeExcel(MultipartFile file, Integer competitionId);

    //导出奖项模板
    void exportPrizeExcelModel(HttpServletResponse response);

    //导出学生奖项
    void exportPrizeExcel(HttpServletResponse response, Integer competitionId);

    //自动设置奖项
    String setPrize(Integer competitionId, String groupName, String prizeNumber);
}
