package com.dcms.service.imp;

import com.dcms.dao.CompetitionFileMapper;
import com.dcms.model.CompetitionFile;
import com.dcms.service.CompetitionFileService;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
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
        CompetitionFile competitionFile=new CompetitionFile();
        competitionFile.setFileName(fileName);
        competitionFile.setUploadTime(new Timestamp(new Date().getTime()));
        return Tool.result(competitionFileMapper.addCompetitionFile(competitionFile));
    }

    public String deleteCompetitionFile(String id,HttpServletRequest request) {
        Integer[] deleteId = Tool.getInteger(id);
        String[] file = new String[deleteId.length];
        for (int i = 0; i < deleteId.length; i++) {
            file[i] = competitionFileMapper.findCompetitionFile(deleteId[i]);
            if (file[i] != null && file[i].length() > 0) {
                String path = request.getSession().getServletContext().getRealPath(Tool.saveCompFilePath+file[i]);
                File compFile = new File(path);
                if (compFile.exists()) {
                    compFile.delete();
                }
            }
        }
        return Tool.result(competitionFileMapper.deleteCompetitionFile(deleteId));
    }

    public void downloadCompetitionFile(String id, HttpServletRequest request, HttpServletResponse response) {
        try {
            String fileName = competitionFileMapper.findCompetitionFile(Integer.parseInt(id));
            String path = request.getSession().getServletContext().getRealPath(Tool.saveCompFilePath);
            //获取输入流
            InputStream  inputStream= new BufferedInputStream(new FileInputStream(new File(path,fileName)));
            String enFileName = URLEncoder.encode(fileName,"UTF-8");
            //设置文件下载头
            response.setHeader("Content-Disposition", "attachment;filename=" + enFileName);
            //设置文件ContentType类型，这样设置，会自动判断下载文件类型
            response.setContentType("multipart/form-data");
            BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
            int len = 0;
            while((len = inputStream.read()) != -1){
                out.write(len);
                out.flush();
            }
            inputStream.close();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
