package com.dcms.controller;

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
import org.springframework.web.servlet.ModelAndView;

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
        String json = cs.getLatestComp();
        return json;
    }
    @RequestMapping(value = "/competitionManage")
    public String  competitionIndex(Model model){
        List<Teacher> teacherList=teacherService.getAllTeacher("asc");
        List<CompetitionGroup> competitionGroupList=competitionGroupService.getAllCompetitionGroup("asc");
        model.addAttribute(teacherList);
        model.addAttribute(competitionGroupList);
        return "competitionManage";
    }

    @RequestMapping("/isTeamComp")
    public ModelAndView isTeamComp(String id){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("apply_index");
        mav.addObject("isTeam",cs.qryIsTeam(id));
        return mav;
    }
}
