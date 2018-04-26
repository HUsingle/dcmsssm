package com.dcms.service.imp;

import com.dcms.dao.ApplyMapper;
import com.dcms.dao.CompetitionMapper;
import com.dcms.dao.GradeMapper;
import com.dcms.excel.ExcelData;
import com.dcms.excel.GradeExcelData;
import com.dcms.model.Apply;
import com.dcms.model.Grade;
import com.dcms.service.GradeService;
import com.dcms.utils.ExcelUtil;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/4/19.
 */
@Service
public class GradeServiceImpl implements GradeService {
    @Autowired
    private GradeMapper gradeMapper;
    @Autowired
    private ApplyMapper applyMapper;
    @Autowired
    private CompetitionMapper competitionMapper;

    public List<Grade> findAllGradeByCidOrGroupName(Integer competitionId, String groupName, String sort) {
        return gradeMapper.findAllGradeByCidOrGroupName(competitionId, groupName, sort);
    }

    public String addGrade(Integer competitionId, Float grade, String user, Integer isTeam) {
        List<Grade> gradeList = new ArrayList<Grade>();
        Grade grade1 = null;
        if (isTeam > 0) {
            int isExitTeamName = applyMapper.qryNumByTeamName(user);
            if (isExitTeamName == 0) {
                return Tool.result("该团队没有参加该竞赛，不能添加成绩");
            }
            List<Apply> applyList = applyMapper.findApplyByTeamName(user);
            int isExistKey = gradeMapper.isExistGrade(applyList.get(0).getUsername(), competitionId);
            if (isExistKey > 0) {
                return Tool.result("该学生的成绩已经存在，不能重复添加！");
            }
            for (Apply apply : applyList) {
                grade1 = new Grade();
                grade1.setCompetitionId(competitionId);
                grade1.setGrade(grade);
                grade1.setUsername(apply.getUsername());
                gradeList.add(grade1);
            }
        } else {
            Long username = Long.parseLong(user);
            int isExistApplyInf = applyMapper.isExistApplyInfo(username, competitionId);
            if (isExistApplyInf == 0) {
                return Tool.result("该学生没有参加该竞赛，不可以添加成绩");
            }
            int isExistGrade = gradeMapper.isExistGrade(username, competitionId);
            if (isExistGrade > 0) {
                return Tool.result("该学生的成绩已经存在，不可以重复添加！");
            }
            grade1 = new Grade();
            grade1.setCompetitionId(competitionId);
            grade1.setGrade(grade);
            grade1.setUsername(username);
            gradeList.add(grade1);
        }
        return Tool.result(gradeMapper.addGrade(gradeList));
    }

    public String deleteGrade(String id) {
        return Tool.result(gradeMapper.deleteGrade(Tool.getInteger(id)));
    }

    public String updateGrade(Float grade, String id, Integer isTeam, Integer competitionId) {
        List<Grade> gradeList = new ArrayList<Grade>();
        Grade grade1 = null;
        if (isTeam > 0) {
            List<Grade> grades = gradeMapper.getGradeId(competitionId, id);
            for (Grade grade2 : grades) {
                grade1 = new Grade();
                grade1.setGrade(grade);
                grade1.setId(grade2.getId());
                gradeList.add(grade1);
            }
        } else {
            grade1 = new Grade();
            grade1.setId(Integer.parseInt(id));
            grade1.setGrade(grade);
            gradeList.add(grade1);
        }
        return Tool.result(gradeMapper.updateGrade(gradeList));
    }

    public String importGradeExcel(MultipartFile file, Integer competitionId) {
        ExcelData gradeInsertExcelData = new GradeExcelData();
        String[] head = {"学号", "成绩"};
        List dataList = ExcelUtil.importExcel(file, head, gradeInsertExcelData);
        int exResult = 0;
        String result;
        long username;
        if (dataList.size() == 0) {
            return Tool.result("缺少行或者学号出错!");
        } else if (dataList.size() == 1 && (dataList.get(0) instanceof String)) {
            return dataList.get(0).toString();

        } else {
            for (int i = dataList.size() - 1; i >= 0; i--) {
                username = ((Grade) dataList.get(i)).getUsername();
                if (applyMapper.isExistApplyInfo(username, competitionId) == 0 ||
                        gradeMapper.isExistGrade(username, competitionId) > 0) {
                    dataList.remove(i);
                }
            }
            if (dataList.size() > 0) {
                exResult = gradeMapper.importGrade(competitionId, dataList);
            }
        }
        if (exResult == 0) {
            result = Tool.result("导入失败,成绩的数据已经存在或者没有参加该竞赛!");
        } else {
            result = Tool.result("导入成功!");
        }
        return result;

    }

    public void exportGradeExcelModel(HttpServletResponse response) {
        String[] head = {"学号", "成绩",};
        ExcelUtil.exportModeExcel(head, "成绩导入模板.xls", response, 401);
    }

    public void exportGradeExcel(HttpServletResponse response, Integer competitionId) {
        ExcelData excelData=new GradeExcelData();
        String title=competitionMapper.findCompetitionName(competitionId);
        List<Grade> gradeList=gradeMapper.exportGrade(competitionId);
        String[] head={"学号","姓名","班级","成绩","组别"};
        ExcelUtil.exportExcel(head,title+"成绩表.xls",response,excelData,gradeList,title);
    }
}
