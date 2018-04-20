package com.dcms.service.imp;

import com.dcms.dao.CompetitionFileMapper;
import com.dcms.model.CompetitionFile;
import com.dcms.service.CompetitionFileService;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * Created by single on 2018/3/29.
 */
@Service
public class CompetitionFileServiceImpl implements CompetitionFileService {
    @Autowired
    private CompetitionFileMapper competitionFileMapper;

    public List<CompetitionFile> getAllCompetitionFile(String sort) {
        return competitionFileMapper.getAllCompetitionFile(sort);
    }

    public String addCompetitionFile(MultipartFile file, HttpServletRequest request) {
        String fileName = "";
        try {
            String path = request.getSession().getServletContext().getRealPath(Tool.saveCompFilePath);
            fileName = file.getOriginalFilename();//获取上传文件名
            if (competitionFileMapper.findCompetitionFileIsExist(fileName) > 0) {
                fileName = System.currentTimeMillis() + fileName;
            }
            File uploadFile = new File(path, fileName);
            if (!uploadFile.exists()) {
                uploadFile.mkdirs();
            }
            file.transferTo(uploadFile);
        } catch (IOException e) {
            e.printStackTrace();
            return Tool.result(0);
        }
        CompetitionFile competitionFile = new CompetitionFile();
        competitionFile.setFileName(fileName);
        competitionFile.setUploadTime(new Timestamp(new Date().getTime()));
        return Tool.result(competitionFileMapper.addCompetitionFile(competitionFile));
    }

    @Transactional
    public String deleteCompetitionFile(String id, HttpServletRequest request) {
        Integer[] deleteId = Tool.getInteger(id);
        String[] file = new String[deleteId.length];
        for (int i = 0; i < deleteId.length; i++) {
            file[i] = competitionFileMapper.findCompetitionFile(deleteId[i]);
            String path = request.getSession().getServletContext().getRealPath(Tool.saveCompFilePath + file[i]);
            File compFile = new File(path);
            if (compFile.exists()) {
                compFile.delete();
            }
        }
        return Tool.result(competitionFileMapper.deleteCompetitionFile(deleteId));
    }

    public void downloadCompetitionFile(String id, HttpServletRequest request, HttpServletResponse response) {
        String fileName = competitionFileMapper.findCompetitionFile(Integer.parseInt(id));
        Tool.downLoad(Tool.saveCompFilePath, fileName, response, request);
    }

}
