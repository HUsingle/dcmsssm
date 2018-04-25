package com.dcms.excel;

import com.dcms.model.Apply;
import com.dcms.model.Student;
import com.dcms.utils.Tool;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/4/24.
 */
public class myApplyExcelData implements ExcelData{
    public List getExcelData(List<List<String>> list) {
        List<Apply> applyList=new ArrayList<Apply>();
        List<String>  fieldList=null;
        Apply apply=null;
        Student student =null;
        for(int i=0;i<list.size();i++){
            fieldList=list.get(i);
            if(fieldList.get(0).length()!=0&& Tool.isNumber(fieldList.get(0))){
                apply = new Apply();
                student=new Student();
                student.setUsername(Long.parseLong(fieldList.get(0)));
                student.setName(fieldList.get(1));
                student.setStudentClass(fieldList.get(2));
                student.setCollege(fieldList.get(3));
                if(fieldList.get(4).length()!=0&&Tool.isNumber(fieldList.get(4))){
                    student.setPhone(Long.parseLong(fieldList.get(4)));
                    student.setPassword(fieldList.get(4));
                }
                student.setEmail(fieldList.get(5));
                apply.setUsername(Long.parseLong(fieldList.get(0)));
                apply.setCompetitionGroup(fieldList.get(6));
                apply.setStudent(student);
                applyList.add(apply);
            }
        }
        return applyList;
    }

    public void exportExcelData(List list, HSSFWorkbook workbook, String[] head, String headTitle) {

    }
}
