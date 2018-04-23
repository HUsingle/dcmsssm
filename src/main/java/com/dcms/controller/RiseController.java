package com.dcms.controller;

import com.alibaba.fastjson.JSONObject;
import com.dcms.model.Competition;
import com.dcms.model.Rise;
import com.dcms.service.CompetitionService;
import com.dcms.service.RiseService;
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
 * Created by single on 2018/4/23.
 */
@Controller
@RequestMapping(value = "/rise")
public class RiseController {
    @Autowired
    private RiseService riseService;
    @Autowired
    private CompetitionService competitionService;

    @RequestMapping(value = "/riseManage")
    public String riseManage(Model model){
        List<Competition> competitionList=competitionService.findAllCompetition();
        model.addAttribute("competitionList",competitionList);
        return "riseManage";
    }

    @RequestMapping(value = "/getRiseList", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String getrise(Integer offset, Integer limit,
                           @RequestParam(defaultValue = "asc") String sort,
                           Integer id, String groupName) {
        PageHelper.startPage(offset, limit);
        List<Rise> riseList = riseService.findAllRiseByCidOrGroupName(id, groupName, sort);
        PageInfo<Rise> pageInfo = new PageInfo<Rise>(riseList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", riseList);
        return result.toJSONString();
    }

    @RequestMapping(value = "/addRise", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String addRise(Integer competitionId, String username, Integer isTeam) {
        return riseService.addRise(competitionId,username,isTeam);
    }

    @RequestMapping(value = "/deleteRise", produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String deleteRise(@RequestParam("id") String id) {
        return riseService.deleteRise(id);
    }

   
    @RequestMapping(value = "/exportRiseExcelModel")
    public void exportRiseExcelModel(HttpServletResponse response) {
        riseService.exportRiseExcelModel(response);
    }

    @RequestMapping(value = "/exportRiseExcel")
    public void exportRiseExcel(HttpServletResponse response) {
        //riseService.exportRiseExcel(response);
    }

    @RequestMapping(value = "/importRiseExcel",  produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String importRiseExcel(@RequestParam("excelFile") MultipartFile excelFile, Integer competitionId) {
        return riseService.importRiseExcel(excelFile,competitionId);
    }

    @RequestMapping(value = "/setRise",  produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String setRise(Integer competitionId) {
        return riseService.setRise(competitionId);
    }
}
