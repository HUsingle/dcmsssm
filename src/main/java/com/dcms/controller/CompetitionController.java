package com.dcms.controller;

import com.alibaba.fastjson.JSON;
import com.dcms.model.Competition;
import com.dcms.model.CompetitionGroup;
import com.dcms.model.Teacher;
import com.dcms.service.CompetitionGroupService;
import com.dcms.service.TeacherService;
import com.dcms.service.imp.CompetitionServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
@RequestMapping("/comp")
public class CompetitionController {
    @Autowired
    private CompetitionServiceImpl cs;
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private CompetitionGroupService competitionGroupService;
   // @RequestMapping("/getLatestComp")
    @RequestMapping(produces="text/html;charset=UTF-8",value = "/getLatestComp")
    @ResponseBody
    public String getLatestComp(HttpServletResponse response)throws UnsupportedEncodingException{
        Competition competition = cs.getLatestComp();
        if(competition!=null){
            return JSON.toJSONString(competition);
        }
        return "ng";
    }
    @RequestMapping(value = "/competitionManage")
    public String  competitionIndex(Model model){
        List<Teacher> teacherList=teacherService.getAllTeacher("asc");
        List<CompetitionGroup> competitionGroupList=competitionGroupService.getAllCompetitionGroup("asc");
        model.addAttribute(teacherList);
        model.addAttribute(competitionGroupList);
        return "competitionManage";
    }
}
