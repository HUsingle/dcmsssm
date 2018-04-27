package com.dcms.controller;

import com.dcms.model.Competition;
import com.dcms.service.CompetitionService;
import com.dcms.service.CompetitionStatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by single on 2018/4/26.
 */
@Controller
@RequestMapping(value = "/competitionStat")
public class CompetitionStatController {
    @Autowired
    private CompetitionService competitionService;
    @Autowired
    private CompetitionStatService competitionStatService;

    @RequestMapping("/competitionStat")
    public String enterApplyIndex(Model model) {
        List<Competition> competitionList = competitionService.findAllCompetition();
        model.addAttribute(competitionList);
        return "competitionStat";
    }

    @RequestMapping(value = "/getCompetitionStatList", produces = "application/json;charset=UTF-8",method = RequestMethod.POST)
    @ResponseBody
    public String geCompetitionStatList(@RequestParam("id") Integer id) {
        return competitionStatService.getStatInformation(id);
    }

}
