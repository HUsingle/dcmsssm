package com.dcms.controller;

import com.dcms.model.Competition;
import com.dcms.service.ApplyService;
import com.dcms.service.CompetitionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/apply")
public class ApplyController {
    @Autowired
    ApplyService applyService;
    @Autowired
    CompetitionService competitionService;

    //个人赛报名
    @RequestMapping("/OneSelfApply")
    @ResponseBody
    public String OneSelfApply(String stuNo, String compId, String groupName) {
        if (!applyService.insertOneSelfInfo(stuNo, compId, groupName)) {
            return "ng";
        }
        return "ok";
    }

    //判断个人赛是否重复报名
    @RequestMapping("/isExistSelfInfo")
    @ResponseBody
    public String isExistSelfInfo(String stuNo, String compId) {
        if (applyService.isExistSelfInfo(stuNo, compId)) {
            return "y";
        }
        return "n";
    }

    @RequestMapping("/applyManage")
    public String enterApplyIndex(Model model) {
        List<Competition> competitionList = competitionService.getAllCompetition();
        model.addAttribute(competitionList);
        return "applyManage";
    }
}
