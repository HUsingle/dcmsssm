package com.dcms.service.imp;

import com.dcms.dao.ApplyMapper;
import com.dcms.dao.KeyMapper;
import com.dcms.model.Apply;
import com.dcms.model.Key;
import com.dcms.service.KeyService;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/4/20.
 */
@Service
public class KeyServiceImpl implements KeyService {
    @Autowired
    private KeyMapper keyMapper;
    @Autowired
    private ApplyMapper applyMapper;

    public List<Key> getAllKey(Integer competitionId, String groupName,String sort) {
        return keyMapper.getAllKey(competitionId, groupName, sort);
    }
     @Transactional
    public String addKey(String user, Integer competitionId, MultipartFile file,
                         HttpServletRequest request,Integer isTeam) {
        List<Key> keys=new ArrayList<Key>();
         List<Apply> applyList=null;
        if(isTeam>0){
            int isExitTeamName=applyMapper.qryNumByTeamName(user);
            if(isExitTeamName==0){
                return Tool.result("该团队没有参加该竞赛");
            }
            applyList=applyMapper.findApplyByTeamName(user);
            int isExistKey=keyMapper.isExistFile(applyList.get(0).getUsername(),competitionId);
            if(isExistKey>0){
                return Tool.result("该学生的答案已经存在");
            }
        }else{
            Long username=Long.parseLong(user);
            int isExistApplyInf=applyMapper.isExistApplyInfo(username,competitionId);
            if(isExistApplyInf==0){
                return Tool.result("该学生没有参加该竞赛");
            }
            int isExistFile=keyMapper.isExistFile(username,competitionId);
            if(isExistFile>0){
                return Tool.result("该学生的答案已经存在");
            }
        }
        String fileName = "";
        try {
            String path = request.getSession().getServletContext().getRealPath(Tool.competition_key_PATH + competitionId);
            fileName = file.getOriginalFilename();//获取上传文件名
            File uploadFile = new File(path, fileName);
            if (!uploadFile.exists()) {
                uploadFile.mkdirs();
            }
            file.transferTo(uploadFile);
        } catch (IOException e) {
            e.printStackTrace();
            return Tool.result(0);
        }
        if(isTeam>0){
            Key key=null;
            for(Apply apply:applyList){
                key=new Key();
                key.setUsername(apply.getUsername());
                key.setFileName(fileName);
                key.setCompetitionId(competitionId);
                keys.add(key);
            }

        }else{
            Key key = new Key();
            key.setCompetitionId(competitionId);
            key.setFileName(fileName);
            key.setUsername(Long.parseLong(user));
            keys.add(key);
        }
        return Tool.result(keyMapper.addKey(keys));

    }
    @Transactional
    public String deleteKey(String id, HttpServletRequest request, Integer competitionId) {
        Integer[] deleteId = Tool.getInteger(id);
        String[] file = new String[deleteId.length];
        for (int i = 0; i < deleteId.length; i++) {
            file[i] = keyMapper.findKeyFileName(deleteId[i]);
            String path = request.getSession().getServletContext().getRealPath(Tool.competition_key_PATH + competitionId);
            File compFile = new File(path,file[i]);
            if (compFile.exists()) {
                compFile.delete();
            }
        }
        return Tool.result(keyMapper.deleteKey(deleteId));

    }

    public void downloadKey(Integer id, HttpServletRequest request,Integer competitionId, HttpServletResponse response) {
        String fileName = keyMapper.findKeyFileName(id);
        Tool.downLoad(Tool.competition_key_PATH+competitionId, fileName, response, request);
    }
}
