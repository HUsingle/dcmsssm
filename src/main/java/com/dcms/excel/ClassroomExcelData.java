package com.dcms.excel;

import com.dcms.model.Classroom;
import com.dcms.utils.Tool;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/3/1.
 */
public class ClassroomExcelData implements ExcelData {
    public List getExcelData(List<List<String>> list) {
        List<Classroom> classroomList=new ArrayList<Classroom>();
        List<String>  fieldList=null;
        Classroom classroom=null;
        for(int i=0;i<list.size();i++){
            fieldList=list.get(i);
            if(fieldList.get(1).length()!=0&& Tool.isNumber(fieldList.get(1))){
                classroom=new Classroom();
                classroom.setSite(fieldList.get(0));
                classroom.setNumber(Integer.parseInt(fieldList.get(1)));
                classroomList.add(classroom);
            }
        }
        return classroomList;
    }

    public void exportExcelData(List list, HSSFWorkbook workbook, HSSFSheet sheet) {

    }
}
