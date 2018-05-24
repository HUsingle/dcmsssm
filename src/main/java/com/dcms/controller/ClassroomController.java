package com.dcms.controller;

import com.alibaba.fastjson.JSONObject;
import com.dcms.model.Classroom;
import com.dcms.model.Competition;
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
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/3/1.
 */
@Controller
@RequestMapping(value = "/classroom")
public class ClassroomController {
    @Autowired
    private ClassroomService classroomService;
    @Autowired
    private CompetitionService competitionService;

    @RequestMapping(value = "/classroomManage")
    public String enterClassroomManage(Model model) {
        List<Competition> competitionList=competitionService.findSingleCompetition();
        model.addAttribute(competitionList);
        return "classroomManage";
    }

    @RequestMapping(value = "/getClassroomList", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String getAllClassroom(@RequestParam(defaultValue = "1") Integer offset,
                                @RequestParam(defaultValue = "10") Integer limit,
                                @RequestParam(defaultValue = "asc")  String sort) {
        PageHelper.startPage(offset, limit);
        List<Classroom> classroomList = classroomService.getAllClassroom(sort);
        PageInfo<Classroom> pageInfo = new PageInfo<Classroom>(classroomList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", classroomList);
        return result.toJSONString();
    }



    @RequestMapping(value = "/addClassroom", method = RequestMethod.POST)
    @ResponseBody
    public String addClassroom(@RequestParam("number") String number,
                             @RequestParam("site") String site) {
        return classroomService.addClassroom(number,site);
    }

    @RequestMapping(value = "/updateClassroom", method = RequestMethod.POST)
    @ResponseBody
    public String updateClassroom(@RequestParam("id") String id, @RequestParam("number") String number,
                                @RequestParam("site") String site) {
        return classroomService.updateClassroom(id,number,site);

    }

    @RequestMapping(value = "/deleteClassroom", method = RequestMethod.POST)
    @ResponseBody
    public String deleteClassroom(@RequestParam("id") String id) {
        return classroomService.deleteClassroom(id);

    }

    @RequestMapping(value = "/exportClassroomExcelModel")
    public void exportClassroomExcelModel(HttpServletResponse response) {
        classroomService.exportClassroomExcelModel(response);
    }



    @RequestMapping(value = "/importClassroomExcel",  produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String importClassroomExcel(@RequestParam("excelFile") MultipartFile excelFile) {
        return classroomService.importClassroomExcel(excelFile);
    }
}
