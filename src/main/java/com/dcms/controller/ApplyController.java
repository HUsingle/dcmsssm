package com.dcms.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.dcms.model.Apply;
import com.dcms.model.Competition;
import com.dcms.model.Student;
import com.dcms.model.Teacher;
import com.dcms.service.ApplyService;
import com.dcms.service.CompetitionService;
import com.dcms.service.StudentService;
import com.dcms.service.TeacherService;
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

import java.util.List;

@Controller
@RequestMapping("/apply")
public class ApplyController {
    @Autowired
    ApplyService applyService;
    @Autowired
    CompetitionService competitionService;
    @Autowired
    StudentService studentService;
    @Autowired
    TeacherService teacherService;
    //个人赛报名
    @RequestMapping("/OneSelfApply")
    @ResponseBody
    public String OneSelfApply(String stuNo,String compId,String groupName){
        if (!applyService.insertOneSelfInfo(stuNo,compId,groupName)){
            return "ng";
        }
        return "ok";
    }

    //判断是否重复报名
    @RequestMapping("/isExistSelfInfo")
    @ResponseBody
    public String isExistSelfInfo(String stuNo,String compId){
        if (applyService.isExistSelfInfo(stuNo,compId)){
            return "y";
        }
        return "n";
    }

    //进入报名管理之前获取所有竞赛信息
    @RequestMapping("/applyManage")
    public String enterApplyIndex(Model model) {
        List<Competition> competitionList = competitionService.getAllCompetition();
        List<Student> studentList = studentService.findAllUsername();
        List<Teacher> teacherList = teacherService.getTeacherNameAndId();
        model.addAttribute(competitionList);
        model.addAttribute(studentList);
        model.addAttribute(teacherList);
        return "applyManage";
    }

    //判断团队名称是否存在
    @RequestMapping("/isExistGroup")
    @ResponseBody
    public String isExistGroup(String tName) {
        if (applyService.isExistGroupName(tName)) {
            return "yes";
        }
        return "no";
    }

    //团队报名
    @RequestMapping("/teamApply")
    @ResponseBody
    public String teamApply(String list, String tid, String compId, String groupName, String tName) {
        boolean f = applyService.teamApply(list, tid, compId, groupName, tName);
        if (f) {
            return "ok";
        }
        return "ng";
    }

    @RequestMapping(value = "/getApplyList", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String geApplyList(@RequestParam Integer offset, @RequestParam Integer limit,
                              @RequestParam String sort, @RequestParam Integer id,
                              @RequestParam(defaultValue = "") String groupName) {
        PageHelper.startPage(offset, limit);
        List<Apply> applyList = applyService.findApplyByCidAndGroup(id, groupName, sort);
        PageInfo<Apply> pageInfo = new PageInfo<Apply>(applyList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", applyList);
        return JSON.toJSONString(result, SerializerFeature.DisableCircularReferenceDetect);
    }
    @RequestMapping(value = "/deleteApply", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String deleteApply(@RequestParam String id){
        return applyService.deleteApply(id);
    }
    @RequestMapping(value = "/findApplyByTeamName", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String findApplyByTeamName(@RequestParam String groupName){
        return applyService.findApplyByTeamName(groupName);
    }
    @RequestMapping(value = "/updateOneSelfApply", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String findApplyByTeamName(Long id, Long stuNo, Integer compId, String groupName){
        return applyService.updateOneSelfInfo(id,compId,groupName,stuNo);
    }
    @RequestMapping(value = "/updateTeamApply", method = RequestMethod.POST)
    @ResponseBody
    public String batchUpdateApply(String id,String list, String isGroupLeader,Long tid, String groupName, String tName,Integer compId){
        return applyService.batchUpdateApply(id,isGroupLeader,list,tid,groupName,tName,compId);
    }

    @RequestMapping(value = "/importApplyTable",  produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String importApplyTable(@RequestParam("compFile") MultipartFile compFile)throws IllegalStateException {
        Competition competition =competitionService.getLatestComp();
        if (!"".equals(competition.getGroup())&&null!=competition.getGroup()){   //组别不为空
            return applyService.importOneApplyNoGroup(compFile,true,competition);
        }else {
            return applyService.importOneApplyNoGroup(compFile,false,competition);
        }
    }

}
