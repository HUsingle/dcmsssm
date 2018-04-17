package com.dcms.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.dcms.model.Classroom;
import com.dcms.model.ClassroomArrange;
import com.dcms.model.Competition;
import com.dcms.service.ClassroomArrangeService;
import com.dcms.service.ClassroomService;
import com.dcms.service.CompetitionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by single on 2018/4/14.
 */
@Controller
@RequestMapping(value = "/classroomArrange")
public class ClassroomArrangeController {
    @Autowired
    private CompetitionService competitionService;
    @Autowired
    private ClassroomArrangeService classroomArrangeService;
    @Autowired
    private ClassroomService classroomService;


    @RequestMapping(value = "/classroomArrangeManage")
    public String competitionIndex(Model model) {
        List<Competition> competitionList = competitionService.findSingleCompetition();
        List<Classroom> classroomList = classroomService.getAllClassroom("asc");
        model.addAttribute(competitionList);
        model.addAttribute(classroomList);
        return "classroomArrangeManage";
    }

    @RequestMapping(value = "/getClassroomArrangeList", produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String getClassroomArrangeList(
            @RequestParam Integer offset, @RequestParam Integer limit,
            @RequestParam Integer classroomId, @RequestParam Integer id,
            @RequestParam String groupName) {
        PageHelper.startPage(offset, limit);
        List<ClassroomArrange> classroomArrangeList=classroomArrangeService.findClassroomArrange(id,groupName,classroomId);
        PageInfo<ClassroomArrange> pageInfo = new PageInfo<ClassroomArrange>(classroomArrangeList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", classroomArrangeList);
        return JSON.toJSONString(result, SerializerFeature.DisableCircularReferenceDetect);
    }
    @RequestMapping(value = "/arrangeExamRoom", produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String arrangeExamRoom(Integer competitionId, String competitionGroup, String examRoom, String peopleNum){
        return  classroomArrangeService.arrangeExamRoom(competitionId,competitionGroup,examRoom,peopleNum);
    }

    @RequestMapping(value = "/deleteClassroomArrange", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String ClassroomArrange(@RequestParam String id){
        return classroomArrangeService.deleteClassroomArrange(id);
    }
    @RequestMapping(value = "/updateClassroomArrange", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String updateClassroomArrange(Long id, Integer seatNumber, Integer classroomId, Integer competitionId){
       return classroomArrangeService.updateClassroomArrange(id,seatNumber,classroomId,competitionId);
    }

}
