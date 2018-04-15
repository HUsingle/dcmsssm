package com.dcms.excel;

import com.dcms.model.Apply;
import com.dcms.model.Student;
import com.dcms.utils.Tool;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.ArrayList;
import java.util.List;

public class ApplyExcelData implements ExcelData {
    public List getExcelData(List<List<String>> list) {

        List<Apply> applyList=new ArrayList<Apply>();
        List<String>  fieldList=null;
        Apply apply=null;
        Student student =null;
        for(int i=0;i<list.size();i++){
            fieldList=list.get(i);
            if(fieldList.get(0).trim().length()!=0&& Tool.isNumber(fieldList.get(0).trim())){
                apply = new Apply();
                student=new Student();
                if (fieldList.size()==5){
                    apply.setCompetitionGroup(fieldList.get(0).trim());
                }
                student.setUsername(Long.parseLong(fieldList.get(0).trim()));
                apply.setUsername(Long.parseLong(fieldList.get(0).trim()));
                student.setName(fieldList.get(1).trim());
                student.setStudentClass(fieldList.get(2).trim());
                student.setPhone(Long.parseLong(fieldList.get(3).trim()));
                apply.setStudent(student);
                applyList.add(apply);
            }
        }
        //System.out.print(applyList.get(1).getUsername());
        return applyList;
    }

    public void exportExcelData(List list, HSSFWorkbook workbook, HSSFSheet sheet) {

    }
}
