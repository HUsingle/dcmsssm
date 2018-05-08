package com.dcms.service.imp;

import com.dcms.dao.ClassroomMapper;
import com.dcms.excel.ClassroomExcelData;
import com.dcms.excel.ExcelData;
import com.dcms.model.Classroom;
import com.dcms.service.ClassroomService;
import com.dcms.utils.ExcelUtil;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/3/1.
 */
@Service
public class ClassroomServiceImpl implements ClassroomService {
    @Autowired
    private ClassroomMapper classroomMapper;

    public List<Classroom> getAllClassroom(String sort) {
        return classroomMapper.getAllClassroom(sort);
    }

    public String addClassroom(String number, String site) {
        Classroom classroom=new Classroom();
        if (Tool.isNumber(number) && number.length() != 0) {
            classroom.setNumber(Integer.parseInt(number));
        }
        if(!Tool.isNumber(number)){
            return Tool.result(0);
        }
        classroom.setSite(site);
        List<Classroom> classroomList=new ArrayList<Classroom>();
        classroomList.add(classroom);
        return Tool.result(classroomMapper.addClassroom(classroomList));
    }

    public String deleteClassroom(String id) {
        int result = classroomMapper.deleteClassroom(Tool.getInteger(id));
        return Tool.result(result);
    }

    public String updateClassroom(String id, String number, String site) {
        Classroom classroom=new Classroom();
        classroom.setId(Integer.parseInt(id));
        if (Tool.isNumber(number) && number.length() != 0) {
            classroom.setNumber(Integer.parseInt(number));
        }
        if(!Tool.isNumber(number)){
            return Tool.result(0);
        }
        classroom.setSite(site);
        return Tool.result(classroomMapper.updateClassroom(classroom));
    }

    public String importClassroomExcel(MultipartFile file) {
        ExcelData classroomExcelData = new ClassroomExcelData();
        String[] head = {"教室", "人数"};
        List dataList = ExcelUtil.importExcel(file, head, classroomExcelData);
        int exResult = 0;
        String result;
        if (dataList.size() == 0) {
            return Tool.result("缺少行或者所填数据不是文本类型!");
        } else if (dataList.size() == 1) {
            if ((dataList.get(0) instanceof String)) {
                return dataList.get(0).toString();
            } else {
                exResult = classroomMapper.addClassroom(dataList);
            }
        } else {
            exResult = classroomMapper.addClassroom(dataList);
        }
        if (exResult == 0) {
            result = Tool.result("导入失败!");
        } else {
            result = Tool.result("导入成功!");
        }
        return result;
    }

    public void exportClassroomExcelModel(HttpServletResponse response) {
        String[] head = {"教室", "人数"};
        ExcelUtil.exportModeExcel(head, "教室信息模板.xls", response,20);
    }
}
