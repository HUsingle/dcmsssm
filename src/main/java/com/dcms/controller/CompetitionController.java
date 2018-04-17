package com.dcms.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.dcms.model.Competition;
import com.dcms.model.CompetitionGroup;
import com.dcms.model.Teacher;
import com.dcms.service.CompetitionGroupService;
import com.dcms.service.TeacherService;
import com.dcms.service.imp.CompetitionServiceImpl;
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

import javax.servlet.http.HttpServletRequest;
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
        List<Teacher> teacherList=teacherService.getTeacherNameAndId();
        List<CompetitionGroup> competitionGroupList=competitionGroupService.getAllCompetitionGroup("asc");
        model.addAttribute(teacherList);
        model.addAttribute(competitionGroupList);
        return "competitionManage";
    }

    @RequestMapping("/isTeamComp")
    @ResponseBody
    public String isTeamComp(String id){
        if (cs.qryIsTeam(id)){
            return "1";
        }
        return "0";
    }
    @RequestMapping(value = "/getCompetitionList", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String getCompetition(@RequestParam(defaultValue = "1") Integer offset,
                                  @RequestParam(defaultValue = "10") Integer limit ) {
        PageHelper.startPage(offset, limit);
        List<Competition> competitionList = cs.getAllCompetition();
        PageInfo<Competition> pageInfo = new PageInfo<Competition>(competitionList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", competitionList);
        return JSON.toJSONString(result,SerializerFeature.DisableCircularReferenceDetect);
    }
    @RequestMapping(value = "/addCompetition", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String addCompetition(HttpServletRequest request, @RequestParam MultipartFile compFile) {
        return  cs.addCompetition(compFile,request);
    }
    @RequestMapping(value = "/deleteCompetition", method = RequestMethod.POST)
    @ResponseBody
    public String deleteStudent(@RequestParam("id") String id,HttpServletRequest request) {
        return cs.deleteCompetition(id,request);
    }

    @RequestMapping(value = "/updateCompetition", produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String updateCompetition(HttpServletRequest request, @RequestParam MultipartFile compFile) {
        return  cs.updateCompetition(compFile,request);
    }

    @RequestMapping("/getCompGroup")
    @ResponseBody
    public String getCompGroup(String id){
        String group = cs.getCompGroup(id);
        if (null!=group&&!"".equals(group)){
            return group;
        }
        return "ng";
    }

}
