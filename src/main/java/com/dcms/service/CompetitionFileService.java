package com.dcms.service;

import com.dcms.model.CompetitionFile;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/3/29.
 */
@Service
public interface CompetitionFileService {
    //查询所有竞赛文件
    List<CompetitionFile> getAllCompetitionFile(String sort);
    //增加竞赛文件
    String addCompetitionFile(MultipartFile file, HttpServletRequest request);
    //删除竞赛文件
    String deleteCompetitionFile(String id,HttpServletRequest request);
    //下载文件
    void downloadCompetitionFile(String id, HttpServletRequest request, HttpServletResponse response);
}
