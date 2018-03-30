package com.dcms.controller;

import com.alibaba.fastjson.JSONObject;
import com.dcms.model.CompetitionFile;
import com.dcms.service.CompetitionFileService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/3/29.
 */
@Controller
@RequestMapping(value = "/competitionFile")
public class CompetitionFileController {
    @Autowired
    private CompetitionFileService competitionFileService;

    @RequestMapping(value = "/getCompetitionFileList", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String getCompetitionFile(@RequestParam(defaultValue = "1") Integer offset,
                                 @RequestParam(defaultValue = "10") Integer limit,
                                 @RequestParam(defaultValue = "asc")  String sort) {
        PageHelper.startPage(offset, limit);
        List<CompetitionFile> competitionFileList = competitionFileService.getAllCompetitionFile(sort);
        PageInfo<CompetitionFile> pageInfo = new PageInfo<CompetitionFile>(competitionFileList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", competitionFileList);
        return result.toJSONString();
    }
    @RequestMapping(value = "/addCompetitionFile", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String addCompetitionFile(HttpServletRequest request, @RequestParam MultipartFile compFile) {
        return  competitionFileService.addCompetitionFile(compFile,request);
    }
    @RequestMapping(value = "/deleteCompetitionFile", method = RequestMethod.POST)
    @ResponseBody
    public String deleteCompetitionFile(@RequestParam("id") String id,HttpServletRequest request) {
        return competitionFileService.deleteCompetitionFile(id,request);
    }

    @RequestMapping(value = "/downloadCompetitionFile")
    public void downloadCompetitionFile(@RequestParam("id") String id, HttpServletRequest request, HttpServletResponse response) {
        competitionFileService.downloadCompetitionFile(id,request,response);
    }

}
