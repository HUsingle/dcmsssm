package com.dcms.service.imp;

import com.alibaba.fastjson.JSON;
import com.dcms.dao.CompetitionMapper;
import com.dcms.model.Competition;
import com.dcms.service.CompetitionService;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class CompetitionServiceImpl implements CompetitionService {
    @Autowired
    CompetitionMapper compMapper;

    //获取最新的竞赛
    public String getLatestComp() {
        Competition competition = compMapper.qryLatestComp();
        List list = new ArrayList();
        list.add(competition);
        String json = JSON.toJSONString(list);
        return json;
    }

    //判断是否是团队赛
    public boolean qryIsTeam(String id) {
        System.out.print("sdasdas" + compMapper.qryIsTeam(id));
        int isTeam = compMapper.qryIsTeam(id);
        if (isTeam == 1) {
            return true;
        }
        return false;
    }

    public List<Competition> findAllCompetition() {
        return compMapper.findAllCompetition();
    }

    public String addCompetition(MultipartFile file, HttpServletRequest request) {
        String fileName = null;
        try {
            //获取Web项目下upload/com_file的全路径
            if (!file.isEmpty()) {
                String path = request.getSession().getServletContext().getRealPath("upload/comp_file");
                fileName = file.getOriginalFilename();
                File uploadFile = new File(path, fileName);
                if (!uploadFile.exists()) {
                    uploadFile.mkdirs();
                }
                file.transferTo(uploadFile);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return Tool.result(e.toString());
        }
        String[] compFieldKey = {"compeStartTime", "compeEndTime", "applyStart", "applyEnd",
                "host", "place", "name", "isTeam", "tid", "groups"};
        String[] compFieldValue = new String[compFieldKey.length];
        for (int i = 0; i < compFieldKey.length; i++) {
            compFieldValue[i] = request.getParameter(compFieldKey[i]);

        }
      /*  System.out.println("7  "+compFieldValue[7] + "45165" + "  8  "+compFieldValue[8]);
        Enumeration<String> h = request.getParameterNames();
        while (h.hasMoreElements())
            System.out.println(h.nextElement());*/
        Competition competition = new Competition();
        if (compFieldValue[0].length() > 0) {
            competition.setCompeStartTime(Timestamp.valueOf(compFieldValue[0] + ":00"));
        }
        if (compFieldValue[1].length() > 0) {
            competition.setCompeEndTime(Timestamp.valueOf(compFieldValue[1] + ":00"));
        }
        if (compFieldValue[2].length() > 0) {
            competition.setApplyStart(Timestamp.valueOf(compFieldValue[2] + ":00"));
        }
        if (compFieldValue[3].length() > 0) {
            competition.setApplyEnd(Timestamp.valueOf(compFieldValue[3] + ":00"));
        }
        competition.setHost(compFieldValue[4]);
        competition.setPlace(compFieldValue[5]);
        competition.setName(compFieldValue[6]);
        competition.setIsTeam(Integer.parseInt(compFieldValue[7]));
        competition.setTid(Integer.parseInt(compFieldValue[8]));
        competition.setGroup(compFieldValue[9]);
        competition.setPublishTime(new Timestamp(new Date().getTime()));
        if (!file.isEmpty())
            competition.setFile("upload/com_file/" + fileName);
        String result = compMapper.addCompetition(competition) + "";
        return Tool.result(result);
    }

    public String deleteCompetition(String id, HttpServletRequest request) {
        Integer[] deleteId = Tool.getInteger(id);
        String[] file = new String[deleteId.length];
        for (int i = 0; i < deleteId.length; i++) {
            file[i] = compMapper.findCompetitionFile(deleteId[i]);
            if (file[i] != null && file[i].length() > 0) {
                String path = request.getSession().getServletContext().getRealPath(file[i]);
                File compFile = new File(path);
                if (compFile.exists()) {
                    compFile.delete();
                }
            }
        }
        return Tool.result(compMapper.deleteCompetition(deleteId));
    }

    public String updateCompetition(MultipartFile file, HttpServletRequest request) {
        String fileName = "";
        String[] compFieldKey = {"compeStartTime", "compeEndTime", "applyStart", "applyEnd",
                "host", "place", "name", "isTeam", "tid", "groups","cid"};
        String[] compFieldValue = new String[compFieldKey.length];
        for (int i = 0; i < compFieldKey.length; i++) {
            compFieldValue[i] = request.getParameter(compFieldKey[i]);
        }
        try {
            if (!file.isEmpty()) {
                String path = request.getSession().getServletContext().getRealPath("upload/comp_file");
                fileName = file.getOriginalFilename();
                String newFileName="upload/com_file/" + fileName;
                String oldFileName=compMapper.findCompetitionFile(Integer.parseInt(compFieldValue[0]));
                if(!newFileName.equals(oldFileName)){//删除旧的文件
                    String oldPath = request.getSession().getServletContext().getRealPath(oldFileName);
                    File oldFile = new File(oldPath);
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }
                File uploadFile = new File(path, fileName);
                if (!uploadFile.exists()) {
                    uploadFile.mkdirs();
                }
                file.transferTo(uploadFile);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return Tool.result(e.toString());
        }
        Competition competition = new Competition();
        if (compFieldValue[0].length() > 0) {
            competition.setCompeStartTime(Timestamp.valueOf(compFieldValue[0] + ":00"));
        }
        if (compFieldValue[1].length() > 0) {
            competition.setCompeEndTime(Timestamp.valueOf(compFieldValue[1] + ":00"));
        }
        if (compFieldValue[2].length() > 0) {
            competition.setApplyStart(Timestamp.valueOf(compFieldValue[2] + ":00"));
        }
        if (compFieldValue[3].length() > 0) {
            competition.setApplyEnd(Timestamp.valueOf(compFieldValue[3] + ":00"));
        }
        competition.setHost(compFieldValue[4]);
        competition.setPlace(compFieldValue[5]);
        competition.setName(compFieldValue[6]);
        competition.setIsTeam(Integer.parseInt(compFieldValue[7]));
        competition.setTid(Integer.parseInt(compFieldValue[8]));
        competition.setGroup(compFieldValue[9]);
        competition.setCid(Integer.parseInt(compFieldValue[10]));
        if (!file.isEmpty())
            competition.setFile("upload/com_file/" + fileName);
        String result = compMapper.updateCompetition(competition) + "";
        return Tool.result(result);

    }
}
