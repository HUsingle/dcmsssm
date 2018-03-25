package com.dcms.controller;

import com.alibaba.fastjson.JSONObject;
import com.dcms.model.CompetitionGroup;
import com.dcms.service.CompetitionGroupService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by single on 2018/3/25.
 */
@Controller
@RequestMapping(value = "/competitionGroup")
public class CompetitionGroupController {
    @Autowired
    private CompetitionGroupService competitionGroupService;
    @RequestMapping(value = "/getCompetitionGroupList", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String getAllCompetitionGroup(@RequestParam(defaultValue = "1") Integer offset,
                                  @RequestParam(defaultValue = "10") Integer limit,
                                  @RequestParam(defaultValue = "asc")  String sort) {
        PageHelper.startPage(offset, limit);
        List<CompetitionGroup> CompetitionGroupList = competitionGroupService.getAllCompetitionGroup(sort);
        PageInfo<CompetitionGroup> pageInfo = new PageInfo<CompetitionGroup>(CompetitionGroupList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", CompetitionGroupList);
        return result.toJSONString();
    }



    @RequestMapping(value = "/addCompetitionGroup", method = RequestMethod.POST)
    @ResponseBody
    public String addCompetitionGroup(@RequestParam("id") String id, @RequestParam("name") String name) {
        return competitionGroupService.addCompetitionGroup(id,name);
    }

    @RequestMapping(value = "/updateCompetitionGroup", method = RequestMethod.POST)
    @ResponseBody
    public String updateCompetitionGroup(@RequestParam("id") String id, @RequestParam("name") String name) {
        return competitionGroupService.updateCompetitionGroup(id,name);

    }

    @RequestMapping(value = "/deleteCompetitionGroup", method = RequestMethod.POST)
    @ResponseBody
    public String deleteCompetitionGroup(@RequestParam("id") String id) {
        return competitionGroupService.deleteCompetitionGroup(id);

    }

}
