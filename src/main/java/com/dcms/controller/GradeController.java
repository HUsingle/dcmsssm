package com.dcms.controller;

import com.alibaba.fastjson.JSONObject;
import com.dcms.model.Competition;
import com.dcms.model.Grade;
import com.dcms.service.CompetitionService;
import com.dcms.service.GradeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/4/19.
 */
@Controller
@RequestMapping(value = "/grade")
public class GradeController {
    @Autowired
    private GradeService gradeService;
    @Autowired
    private CompetitionService competitionService;

    @RequestMapping(value = "/gradeManage")
    public String GradeManage(Model model){
        List<Competition> competitionList=competitionService.findAllCompetition();
        model.addAttribute(competitionList);
        return "gradeManage";
    }

    @RequestMapping(value = "/getGradeList", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String getGrade(Integer offset, Integer limit,
                         @RequestParam(defaultValue = "asc") String sort,
                         Integer id, String groupName) {
        PageHelper.startPage(offset, limit);
        List<Grade> gradeList = gradeService.findAllGradeByCidOrGroupName(id, groupName, sort);
        PageInfo<Grade> pageInfo = new PageInfo<Grade>(gradeList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", gradeList);
        return result.toJSONString();
    }

    @RequestMapping(value = "/addGrade", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String addGrade(Float grade, Integer competitionId, String username, Integer isTeam) {
        return gradeService.addGrade(competitionId,grade,username,isTeam);
    }

    @RequestMapping(value = "/deleteGrade", produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String deleteGrade(@RequestParam("id") String id) {
        return gradeService.deleteGrade(id);
    }

    @RequestMapping(value = "/updateGrade",produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String updateGrade(String id, Float grade,Integer isTeam,Integer competitionId) {
       return gradeService.updateGrade(grade,id,isTeam,competitionId);
    }

    @RequestMapping(value = "/exportGradeExcelModel")
    public void exportGradeExcelModel(HttpServletResponse response) {
        gradeService.exportGradeExcelModel(response);
    }

    @RequestMapping(value = "/exportGradeExcel")
    public void exportGradeExcel(HttpServletResponse response,Integer competitionId) {
        gradeService.exportGradeExcel(response,competitionId);
    }

    @RequestMapping(value = "/importGradeExcel",  produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String importGradeExcel(@RequestParam("excelFile") MultipartFile excelFile,Integer competitionId) {
      
       return gradeService.importGradeExcel(excelFile,competitionId);

    }
}
