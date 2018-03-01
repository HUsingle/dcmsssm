package com.dcms.controller;

import com.alibaba.fastjson.JSON;
import com.dcms.model.Competition;
import com.dcms.service.imp.CompetitionServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;

@Controller
@RequestMapping("/comp")
public class CompetitionController {
    @Autowired
    CompetitionServiceImpl cs;
   // @RequestMapping("/getLatestComp")
    @RequestMapping(produces="text/html;charset=UTF-8",value = "/getLatestComp")
    @ResponseBody
    public String getLatestComp(HttpServletResponse response)throws UnsupportedEncodingException{
        Competition competition = cs.getLatestComp();
        if(competition!=null){
            return JSON.toJSONString(competition);
        }
        return "ng";
    }
}
