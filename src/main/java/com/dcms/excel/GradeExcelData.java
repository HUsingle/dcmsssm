package com.dcms.excel;

import com.dcms.model.Grade;
import com.dcms.utils.Tool;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/4/21.
 */
public class GradeExcelData implements ExcelData{
    public List getExcelData(List<List<String>> list) {
        List<Grade> gradeList=new ArrayList<Grade>();
        List<String>  fieldList=null;
        Grade grade=null;
        for(int i=0;i<list.size();i++){
            fieldList=list.get(i);
            if(fieldList.get(0).length()!=0&& Tool.isNumber(fieldList.get(0))
                    &&fieldList.get(1).length()!=0&& Tool.isNumber(fieldList.get(1))){
                grade=new Grade();
                grade.setUsername(Long.parseLong(fieldList.get(0)));
                grade.setGrade(Integer.parseInt(fieldList.get(1)));
                gradeList.add(grade);
            }
        }
        return gradeList;
        //return null;
    }

    public void exportExcelData(List list, HSSFWorkbook workbook, HSSFSheet sheet) {

    }
}
