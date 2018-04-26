package com.dcms.service.imp;

import com.dcms.dao.CompetitionMapper;
import com.dcms.model.Competition;
import com.dcms.service.CompetitionService;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Service
public class CompetitionServiceImpl implements CompetitionService {
    @Autowired
    CompetitionMapper compMapper;

    //获取最新的竞赛
    public Competition getLatestComp() {
        Competition competition = compMapper.qryLatestComp();

        return competition;
    }

    //判断是否是团队赛
    public boolean qryIsTeam(String id) {
        int isTeam = compMapper.qryIsTeam(id);
        if (isTeam == 1) {
            return true;
        }
        return false;
    }

    public List<Competition> findAllCompetition() {
        return compMapper.findAllCompetition();
    }

    public List<Competition> findSingleCompetition() {
        return compMapper.findSingleCompetition();
    }

    public List<Competition> getAllCompetition() {
        return compMapper.getAllCompetition();
    }

    public String addCompetition(MultipartFile file, HttpServletRequest request) {
        String fileName = "";
        try {
            if (!file.isEmpty()) {
                //获取Web项目下upload/com_file的全路径
                String path = request.getSession().getServletContext().getRealPath(Tool.saveCompAffixPath);
                fileName = file.getOriginalFilename();
                //判断上传过的竞赛文件是否重名，重名则将上传文件名进行修改
                if (compMapper.findCompetitionFileIsExist(fileName) > 0) {
                    fileName = System.currentTimeMillis() + fileName;
                }
                File uploadFile = new File(path, fileName);
                //判断该文件路径是否存在，没有则创建
                if (!uploadFile.exists()) {
                    if (uploadFile.mkdirs()) {
                        file.transferTo(uploadFile);
                    }
                } else {
                    file.transferTo(uploadFile);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return Tool.result(0);
        }
        String[] compFieldKey = {"compeStartTime", "compeEndTime", "applyStart", "applyEnd",
                "host", "place", "name", "isTeam", "tid", "groups"};
        String[] compFieldValue = new String[compFieldKey.length];
        for (int i = 0; i < compFieldKey.length; i++) {
            compFieldValue[i] = request.getParameter(compFieldKey[i]);

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
        competition.setPublishTime(new Timestamp(new Date().getTime()));
        competition.setFile(fileName);
        int result = compMapper.addCompetition(competition);
        return Tool.result(result);
    }

    public String deleteCompetition(String id, HttpServletRequest request) {
        Integer[] deleteId = Tool.getInteger(id);
        String[] file = new String[deleteId.length];
        for (int i = 0; i < deleteId.length; i++) {
            //获取删除文件的文件名
            file[i] = compMapper.findCompetitionFile(deleteId[i]);
            //如果存在文件则进行删除
            if (file[i] != null && file[i].length() > 0) {
                String path = request.getSession().getServletContext().getRealPath(Tool.saveCompAffixPath + file[i]);
                File compFile = new File(path);
                if (compFile.exists()) {
                    compFile.delete();
                }
            }
        }
        return Tool.result(compMapper.deleteCompetition(deleteId));
    }

    public String getCompGroup(String id) {
        String group = compMapper.qryCompGroup(id);
        return group;
    }

    public List<Competition> qryByPage(String on, String end,String noStart) {
        return compMapper.qryByPage(on,end,noStart);
    }

    public String updateCompetition(MultipartFile file, HttpServletRequest request) {
        String fileName = "";
        String[] compFieldKey = {"compeStartTime", "compeEndTime", "applyStart", "applyEnd",
                "host", "place", "name", "isTeam", "tid", "groups", "cid"};
        String[] compFieldValue = new String[compFieldKey.length];
        for (int i = 0; i < compFieldKey.length; i++) {
            compFieldValue[i] = request.getParameter(compFieldKey[i]);
        }
        try {
            //获取竞赛文件所在路径
            String path = request.getSession().getServletContext().getRealPath(Tool.saveCompAffixPath);
            //查找以前所存文件名称
            int id = Integer.parseInt(compFieldValue[10]);
            String oldFileName = compMapper.findCompetitionFile(id);
            if (!file.isEmpty()) {//如果上传文件不为空
                fileName = file.getOriginalFilename();//获取上传文件名
                //如果原来文件和修改的文件名字不一样，删除旧的文件
                if (oldFileName != null && oldFileName.length() > 0 && !fileName.equals(oldFileName)) {
                    File oldFile = new File(path, oldFileName);
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }
                //判断上传过的竞赛文件(除了自己)是否重名，重名则将上传文件名进行修改
                if (compMapper.findNotUpdCompetitionFileIsExist(fileName, id) > 0) {
                    fileName = System.currentTimeMillis() + fileName;
                }
                File uploadFile = new File(path, fileName);//创建修改文件
                if (!uploadFile.exists()) {
                    uploadFile.mkdirs();
                }
                file.transferTo(uploadFile);//写入文件
            } else {//如果上传文件为空,删除已经存在的文件
              /*  if(oldFileName!=null&&oldFileName.length()>0){
                    File oldFile = new File(path,oldFileName);
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }*/
                fileName = oldFileName;
            }
        } catch (IOException e) {
            e.printStackTrace();
            return Tool.result(0);
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
        competition.setFile(fileName);
        int result = compMapper.updateCompetition(competition);
        return Tool.result(result);
    }

    public void downloadCompetitionFile(Integer id, HttpServletRequest request, HttpServletResponse response) {
        String fileName = compMapper.findCompetitionFile(id);
        Tool.downLoad(Tool.saveCompAffixPath, fileName, response, request);
    }
}
