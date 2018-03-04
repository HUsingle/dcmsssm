package com.dcms.service;

import com.dcms.model.Classroom;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/3/1.
 */
@Service
public interface ClassroomService {
    //查询所有教室
    List<Classroom> getAllClassroom(String sort);
    //增加教室
    String addClassroom(String number, String site);
    //删除教室
    String deleteClassroom(String id);
    //更新教室
    String updateClassroom(String id,String number, String site);
    //导入教室
    String importClassroomExcel(MultipartFile file);
    //导出教室模板
    void exportClassroomExcelModel(HttpServletResponse response);
}
