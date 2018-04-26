package com.dcms.service;

import com.dcms.model.Grade;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/4/19.
 */
public interface GradeService {
    //根据竞赛Id和组别查询成绩
    List<Grade> findAllGradeByCidOrGroupName(Integer competitionId, String groupName, String sort);

    //添加成绩
    String addGrade(Integer competitionId, Float grade, String username, Integer isTeam);

    //删除成绩
    String deleteGrade(String id);

    //更新成绩-
    String updateGrade(Float grade, String id, Integer isTeam, Integer competitionId);

    //导入成绩
    String importGradeExcel(MultipartFile file, Integer competitionId);

    //导出学生成绩模板
    void exportGradeExcelModel(HttpServletResponse response);

    //导出学生成绩
    void exportGradeExcel(HttpServletResponse response, Integer competitionId);
}
