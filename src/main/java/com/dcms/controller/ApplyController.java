package com.dcms.controller;
import org.springframework.ui.Model;
import com.dcms.model.Competition;
import com.dcms.service.ApplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.dcms.service.CompetitionService;
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

    @RequestMapping("/applyManage")
    public String enterApplyIndex(Model model) {
        List<Competition> competitionList = competitionService.getAllCompetition();
        model.addAttribute(competitionList);
        return "applyManage";
    }
    //判断团队名称是否存在
    @RequestMapping("/isExistGroup")
    @ResponseBody
    public String isExistGroup(String tName){
        if(applyService.isExistGroupName(tName)){
            return "yes";
        }
        return "no";
    }
    //团队报名
    @RequestMapping("/teamApply")
    @ResponseBody
    public String teamApply(String list,String tid,String compId,String groupName,String tName){
       boolean f =  applyService.teamApply(list,tid,compId,groupName,tName);
       if (f){
           return "ok";
       }
        return  "ng";
    }
}
