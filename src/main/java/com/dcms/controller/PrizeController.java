package com.dcms.controller;

import com.alibaba.fastjson.JSONObject;
import com.dcms.model.Competition;
import com.dcms.model.Prize;
import com.dcms.service.CompetitionService;
import com.dcms.service.PrizeService;
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
 * Created by single on 2018/4/22.
 */
@Controller
@RequestMapping(value = "/prize")
public class PrizeController {
    @Autowired
    private PrizeService prizeService;
    @Autowired
    private CompetitionService competitionService;

    @RequestMapping(value = "/prizeManage")
    public String prizeManage(Model model){
        List<Competition> competitionList=competitionService.findAllCompetition();
        List<Competition> singleCompetition=competitionService.findSingleCompetition();
        model.addAttribute("competitionList",competitionList);
        model.addAttribute("singleCompetition",singleCompetition);
        return "prizeManage";
    }

    @RequestMapping(value = "/getPrizeList", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String getPrize(Integer offset, Integer limit,
                           @RequestParam(defaultValue = "asc") String sort,
                           Integer id, String groupName) {
        PageHelper.startPage(offset, limit);
        List<Prize> prizeList = prizeService.findAllPrizeByCidOrGroupName(id, groupName, sort);
        PageInfo<Prize> pageInfo = new PageInfo<Prize>(prizeList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", prizeList);
        return result.toJSONString();
    }

    @RequestMapping(value = "/addPrize", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String addPrize(String prize, Integer competitionId, String username, Integer isTeam) {
        return prizeService.addPrize(competitionId,prize,username,isTeam);
    }

    @RequestMapping(value = "/deletePrize", produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String deletePrize(@RequestParam("id") String id) {
        return prizeService.deletePrize(id);
    }

    @RequestMapping(value = "/updatePrize",produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String updatePrize(String id, String prize,Integer isTeam,Integer competitionId) {
        return prizeService.updatePrize(prize,id,isTeam,competitionId);
    }

    @RequestMapping(value = "/exportPrizeExcelModel")
    public void exportPrizeExcelModel(HttpServletResponse response) {
        prizeService.exportPrizeExcelModel(response);
    }

    @RequestMapping(value = "/exportPrizeExcel")
    public void exportPrizeExcel(HttpServletResponse response) {
        //PrizeService.exportPrizeExcel(response);
    }

    @RequestMapping(value = "/importPrizeExcel",  produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String importPrizeExcel(@RequestParam("excelFile") MultipartFile excelFile, Integer competitionId) {
        return prizeService.importPrizeExcel(excelFile,competitionId);
    }

    @RequestMapping(value = "/setPrize",  produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String setPrize(Integer competitionId,String groupName,String prizeNumber) {
        return prizeService.setPrize(competitionId,groupName,prizeNumber);
    }
}
