package com.dcms.excel;

import com.dcms.model.Teacher;
import com.dcms.utils.Tool;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/2/28.
 */
public class TeacherExcelData implements ExcelData {
    public List insertExcelData(List<List<String>> list) {
        List<Teacher> teacherList=new ArrayList<Teacher>();
        List<String>  fieldList=null;
        Teacher teacher=null;
        for(int i=0;i<list.size();i++){
            fieldList=list.get(i);
            if(fieldList.get(0).length()!=0&& Tool.isNumber(fieldList.get(0))){
                teacher=new Teacher();
                teacher.setId(Long.parseLong(fieldList.get(0)));
                teacher.setName(fieldList.get(1));
                teacher.setPassword(fieldList.get(2));
                teacher.setCollege(fieldList.get(3));
                if(fieldList.get(4).length()!=0&&Tool.isNumber(fieldList.get(4))){
                    teacher.setPhone(Long.parseLong(fieldList.get(4)));
                }
                teacher.setEmail(fieldList.get(5));
                teacherList.add(teacher);
            }
        }
        return teacherList;
    }


    public void exportExcelData(List list, HSSFWorkbook workbook, HSSFSheet sheet) {
    }
}
