package com.dcms.service.imp;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dcms.dao.ApplyMapper;
import com.dcms.dao.StudentMapper;
import com.dcms.excel.ApplyExcelData;
import com.dcms.excel.ExcelData;
import com.dcms.model.Apply;
import com.dcms.model.Competition;
import com.dcms.model.Student;
import com.dcms.service.ApplyService;
import com.dcms.utils.ExcelUtil;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
@Transactional
public class ApplyServiceImpl implements ApplyService {
    @Autowired
    ApplyMapper applyMapper;
    @Autowired
    StudentMapper studentMapper;


    //个人赛报名
    public boolean insertOneSelfInfo(String stuNo, String compId, String groupName) {
        int i = applyMapper.insertOneSelfInfo(stuNo, compId, groupName);
        // System.out.print(i+"asdasdasd" + "");
        if (i == 1) {
            return true;
        }
        return false;
    }

    //判断个人赛是否重复报名
    public boolean isExistSelfInfo(String stuNo, String compId) {
        String s = applyMapper.isExistSelfInfo(stuNo, compId);
        if (s != null && !s.equals("")) {
            return true;
        }
        return false;
    }

    //判断团队名称是否存在  存在返回true
    public boolean isExistGroupName(String tName) {
        String s = applyMapper.qryGroupNameByCid(tName);
        if (null != s) {
            return true;
        }
        return false;
    }
   //团队报名
    public boolean teamApply(String list, String tid, String compId, String groupName, String tName) {
        String[] stu = list.split(",");
        Apply apply = null;
        List<Apply> applyList = new ArrayList<Apply>();
        for (int i = 0; i < stu.length; i++) {
            apply = new Apply();
            int leader = 0;
            if (i == 0) {
                leader = 1;
            }
            apply.setCompetitionId(Integer.valueOf(compId));
            apply.setUsername(Long.valueOf(stu[i]));
            apply.setIsGroupLeader(leader);
            apply.setGroupName(tName);
            apply.setCompetitionGroup(groupName);
            if (!tid.equals("")) {
                apply.setTeacherId(Long.valueOf(tid));
            }

            applyList.add(apply);
        }
        int i = applyMapper.insertBench(applyList);
        if (i >= 1) {
            return true;
        }
        return false;
    }



    public String findNumByGroup(Integer id) {
        List map = applyMapper.findNumByGroup(id);
        JSONObject result = new JSONObject();
        result.put("total", map.size());
        result.put("rows", map);
        return result.toJSONString();

    }

    public List<Apply> findApplyByCidAndGroup(Integer id, String groupName, String sort) {
        return applyMapper.findApplyByCidAndGroup(id, groupName, sort);
    }

    public String deleteApply(String id) {
        return Tool.result(applyMapper.deleteApply(Tool.getLong(id)));
    }

    public String findApplyByTeamName(String groupName) {
        return JSONArray.toJSONString(applyMapper.findApplyByTeamName(groupName));
    }

    public String updateOneSelfInfo(Long id, Integer competitionId, String competitionGroup, Long username) {
        return Tool.result(applyMapper.updateOneSelfInfo(id, competitionId, competitionGroup, username));
    }

    //批量更新报名
    public String batchUpdateApply(String id, String isGroupLeader, String list, Long tid,
                                   String groupName, String tName, Integer competitionId) {
        Long[] ids = Tool.getLong(id);
        Long[] username = Tool.getLong(list);
        Integer[] isLeader = Tool.getInteger(isGroupLeader);
        Apply apply = null;
        List<Apply> applyList = new ArrayList<Apply>();
        List<Apply> applyList1 = new ArrayList<Apply>();
        for (int i = 0; i < ids.length; i++) {//老成员修改信息
            apply = new Apply();
            apply.setIsGroupLeader(isLeader[i]);
            apply.setUsername(username[i]);
            apply.setId(ids[i]);
            apply.setCompetitionGroup(groupName);
            apply.setGroupName(tName);
            apply.setTeacherId(tid);
            applyList.add(apply);
        }
        for (int i = ids.length; i < username.length; i++) {//修改可以添加新的成员
            apply = new Apply();
            apply.setIsGroupLeader(isLeader[i]);
            apply.setUsername(username[i]);
            apply.setCompetitionGroup(groupName);
            apply.setCompetitionId(competitionId);
            apply.setGroupName(tName);
            apply.setTeacherId(tid);
            applyList1.add(apply);
        }
        if (applyList1.size() > 0) {
            applyMapper.insertBench(applyList1);
        }
        int result = applyMapper.batchUpdateApply(applyList);
        return Tool.result(result);
    }

    public String importOneApplyNoGroup(MultipartFile excelFile, boolean hasGroup, Competition competition) {

        //学号，竞赛编号，组名。
        ExcelData applyInsertExcelData = new ApplyExcelData();
        List dataList;
        if (hasGroup) {
            String[] head = {"学号", "姓名", "班级", "手机号码", "竞赛组别"};
            dataList = ExcelUtil.importExcel(excelFile, head, applyInsertExcelData);

        } else {
            String[] head = {"学号", "姓名", "班级", "手机号码"};
            dataList = ExcelUtil.importExcel(excelFile, head, applyInsertExcelData);
        }


        int exResult = 0;
        String result;
        HashMap map = new HashMap();
        List success = new ArrayList();
        List error = new ArrayList();

        if (dataList.size() == 0) {
            return Tool.result("缺少行或者学号出错!");
        } else {
            if ((dataList.get(0) instanceof String)) {
                return dataList.get(0).toString();
            } else {
                List<Apply> data = dataList;
                for (int i = 0; i < data.size(); i++) {
                    long sno = data.get(i).getUsername();
                    Student student = studentMapper.qryById(String.valueOf(sno));
                    if (null != student) {   //学号存在，可以插入
                        success.add(data.get(i));
                    } else {
                        error.add(data.get(i));
                    }
                }

                if (hasGroup) {
                    exResult = applyMapper.addApplyInfoHasGroup(success, String.valueOf(competition.getCid()), competition.getGroup());
                } else {
                    exResult = applyMapper.addApplyInfo(success, String.valueOf(competition.getCid()));
                }

            }
        }

        if (exResult == 0) {
            result = Tool.result("导入失败!");
        } else {
            map.put("result", "导入成功!");
            map.put("success", success);
            map.put("errors", error);
            result = JSONObject.toJSONString(map);
        }
        return result;
    }


}
