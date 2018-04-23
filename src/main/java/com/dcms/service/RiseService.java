package com.dcms.service;

import com.dcms.model.Rise;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/4/23.
 */
public interface RiseService {
   
        //根据竞赛Id和组别查询晋级名单
        List<Rise> findAllRiseByCidOrGroupName(Integer competitionId, String groupName, String sort);

        //添加晋级名单
        String addRise(Integer competitionId, String username, Integer isTeam);

        //删除晋级名单
        String deleteRise(String id);


        //导入晋级名单
        String importRiseExcel(MultipartFile file, Integer competitionId);

        //导出晋级名单模板
        void exportRiseExcelModel(HttpServletResponse response);

        //导出学生晋级名单
        void exportRiseExcel(HttpServletResponse response, Integer competitionId);

        //自动设置晋级名单
        String setRise(Integer competitionId);
}
