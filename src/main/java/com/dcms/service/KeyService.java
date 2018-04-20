package com.dcms.service;

import com.dcms.model.Key;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/4/20.
 */
public interface KeyService {
    //根据竞赛Id和组别查询竞赛答案
    List<Key> getAllKey(Integer competitionId,
                         String groupName,String sort);
    //上传竞赛答案
    String addKey(Long username, Integer competitionId, MultipartFile multipartFile ,
                 HttpServletRequest request);
    //删除竞赛答案
    String deleteKey(String id, HttpServletRequest request, Integer competitionId);
    //下载竞赛答案
    void  downloadKey(Integer id, HttpServletRequest request, Integer competitionId, HttpServletResponse response);
}
