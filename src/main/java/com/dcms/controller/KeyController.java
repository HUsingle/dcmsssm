package com.dcms.controller;

import com.alibaba.fastjson.JSONObject;
import com.dcms.model.Competition;
import com.dcms.model.Key;
import com.dcms.service.CompetitionService;
import com.dcms.service.KeyService;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/4/20.
 */
@Controller
@RequestMapping(value = "/key")
public class KeyController {
    @Autowired
    private KeyService KeyService;
    @Autowired
    private CompetitionService competitionService;

    @RequestMapping(value = "/keyManage")
    public String keyManage(Model model){
        List<Competition> competitionList=competitionService.findSingleCompetition();
        model.addAttribute(competitionList);
        return "competitionKeyManage";
    }

    @RequestMapping(value = "/getKeyList", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String getKey(Integer offset, Integer limit,
                         @RequestParam(defaultValue = "asc") String sort,
                         Integer id, String groupName) {
        PageHelper.startPage(offset, limit);
        List<Key> keyList = KeyService.getAllKey(id, groupName, sort);
        PageInfo<Key> pageInfo = new PageInfo<Key>(keyList);
        JSONObject result = new JSONObject();
        result.put("total", pageInfo.getTotal());
        result.put("rows", keyList);
        return result.toJSONString();
    }

    @RequestMapping(value = "/addKey", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String addKey(Long username, Integer competitionId, MultipartFile keyFile,
                          HttpServletRequest request) {
        return KeyService.addKey(username, competitionId, keyFile,request);
    }

    @RequestMapping(value = "/deleteKey", method = RequestMethod.POST)
    @ResponseBody
    public String deleteKey(@RequestParam("id") String id, HttpServletRequest request, @RequestParam("competitionName") Integer competitionName) {
        return KeyService.deleteKey(id, request, competitionName);
    }

    @RequestMapping(value = "/downloadKey")
    public void downloadKey(Integer id, Integer competitionId,
                            HttpServletRequest request, HttpServletResponse response) {
        KeyService.downloadKey(id, request, competitionId, response);
    }
}
