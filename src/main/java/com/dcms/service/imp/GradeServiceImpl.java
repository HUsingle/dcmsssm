package com.dcms.service.imp;

import com.dcms.dao.ApplyMapper;
import com.dcms.dao.GradeMapper;
import com.dcms.model.Apply;
import com.dcms.model.Grade;
import com.dcms.service.GradeService;
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

    public List<Grade> findAllGradeByCidOrGroupName(Integer competitionId, String groupName, String sort) {
        return gradeMapper.findAllGradeByCidOrGroupName(competitionId, groupName, sort);
    }

    public String addGrade(Integer competitionId, Integer grade, String user, Integer isTeam) {
        List<Grade> gradeList = new ArrayList<Grade>();
        Grade grade1 = null;
        if (isTeam > 0) {
            int isExitTeamName=applyMapper.qryNumByTeamName(user);
            if(isExitTeamName==0){
                return Tool.result("该团队没有参加该竞赛，不能添加成绩");
            }
            List<Apply> applyList=applyMapper.findApplyByTeamName(user);
            int isExistKey=gradeMapper.isExistGrade(applyList.get(0).getUsername(),competitionId);
            if(isExistKey>0){
                return Tool.result("该学生的成绩已经存在，不能重复添加！");
            }
            for(Apply apply:applyList){
                grade1 = new Grade();
                grade1.setCompetitionId(competitionId);
                grade1.setGrade(grade);
                grade1.setUsername(apply.getUsername());
                gradeList.add(grade1);
            }
        } else {
            Long username=Long.parseLong(user);
            int isExistApplyInf=applyMapper.isExistApplyInfo(username,competitionId);
            if(isExistApplyInf==0){
                return Tool.result("该学生没有参加该竞赛，不可以添加成绩");
            }
            int isExistGrade=gradeMapper.isExistGrade(username,competitionId);
            if(isExistGrade>0){
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

    public String updateGrade(Integer grade, String id,Integer isTeam,Integer competitionId) {
        List<Grade> gradeList=new ArrayList<Grade>();
        Grade grade1=null;
        if(isTeam>0){
            List<Grade> grades=gradeMapper.getGradeId(competitionId,id);
            for(Grade grade2:grades){
                grade1=new Grade();
                grade1.setGrade(grade);
                grade1.setId(grade2.getId());
                gradeList.add(grade1);
            }
        }else{
            grade1=new Grade();
            grade1.setId(Integer.parseInt(id));
            grade1.setGrade(grade);
            gradeList.add(grade1);
        }
        return Tool.result(gradeMapper.updateGrade(gradeList));
    }

    public String importGradeExcel(MultipartFile file, Integer competitionId) {
        return null;
    }

    public void exportGradeExcelModel(HttpServletResponse response, Integer competitionId) {

    }

    public void exportGradeExcel(HttpServletResponse response, Integer competitionId) {

    }
}
