package com.dcms.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.dcms.model.Classroom;
import com.dcms.model.Competition;
import com.dcms.model.Invigilation;
import com.dcms.model.Teacher;
import com.dcms.service.ClassroomService;
import com.dcms.service.CompetitionService;
import com.dcms.service.InvigilationService;
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

import java.util.List;

/**
 * Created by single on 2018/4/19.
 */
@Controller
@RequestMapping(value="/invigilation")
public class InvigilationController {
    @Autowired
    private CompetitionService competitionService;
    @Autowired
    private InvigilationService invigilationService;
    @Autowired
    private ClassroomService classroomService;
    @Autowired
    private TeacherService teacherService;


    @RequestMapping(value = "/invigilationManage")
    public String InvigilationManage(Model model) {
        List<Competition> competitionList = competitionService.findSingleCompetition();
        List<Classroom> classroomList = classroomService.getAllClassroom("asc");
        List<Teacher> teacherList = teacherService.getTeacherNameAndId();
        model.addAttribute(competitionList);
        model.addAttribute(classroomList);
        model.addAttribute(teacherList);
        return "invigilationManage";
    }


    @RequestMapping(value = "/getInvigilationList", produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String getInvigilationList(
            @RequestParam Integer offset, @RequestParam Integer limit,
          @RequestParam Integer id) {
        PageHelper.startPage(offset, limit);
        List<Invigilation> invigilationList=invigilationService.findInvigilation(id);
        PageInfo<Invigilation> pageInfo = new PageInfo<Invigilation>(invigilationList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", invigilationList);
        return JSON.toJSONString(result, SerializerFeature.DisableCircularReferenceDetect);
    }

    @RequestMapping(value = "/getInvigilationListByTeacherId", produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String getInvigilationListByTeacherId(
            @RequestParam Integer offset, @RequestParam Integer limit,
            @RequestParam Long id) {
        PageHelper.startPage(offset, limit);
        List<Invigilation> invigilationList=invigilationService.findInvigilationByTeacherId(id);
        PageInfo<Invigilation> pageInfo = new PageInfo<Invigilation>(invigilationList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", invigilationList);
        return JSON.toJSONString(result, SerializerFeature.DisableCircularReferenceDetect);
    }

    @RequestMapping(value = "/addInvigilation", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String addInvigilation(@RequestParam Integer competitionId,@RequestParam String teacherId,
                                  @RequestParam Integer classroomId){
        return invigilationService.insertInvigilation(competitionId,teacherId,classroomId);
    }

    @RequestMapping(value = "/deleteInvigilation", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String deleteInvigilation(@RequestParam String id){
        return invigilationService.deleteInvigilation(id);
    }

    @RequestMapping(value = "/updateInvigilation", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String updateInvigilation(Integer id, Long teacherId, Integer competitionId,Integer classroomId,Integer isSame){
        return invigilationService.updateInvigilation(id,teacherId,classroomId,competitionId,isSame);
    }
    @RequestMapping(value = "/autoArrangeInvigilation", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
   public String autoArrangeInvigilation(Integer competitionId){
        return invigilationService.autoArrangeInvigilation(competitionId);
   }
}
