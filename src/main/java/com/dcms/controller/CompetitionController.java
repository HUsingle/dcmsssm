package com.dcms.controller;

import com.dcms.service.imp.CompetitionServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/comp")
public class CompetitionController {
    @Autowired
    CompetitionServiceImpl cs;
   // @RequestMapping("/getLatestComp")
    @RequestMapping(produces="text/html;charset=UTF-8",value = "/getLatestComp")
    @ResponseBody
    public String getLatestComp(){
        //System.out.print("controller sucess!");
        String json = cs.getLatestComp();

        return json;
    }
    @RequestMapping("/isTeamComp")
    public ModelAndView isTeamComp(String id){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("apply_index");
        mav.addObject("isTeam",cs.qryIsTeam(id));
        return mav;
    }
}
