package com.dcms.excel;

import com.dcms.model.Grade;
import com.dcms.utils.ExcelUtil;
import com.dcms.utils.Tool;
import org.apache.poi.hssf.usermodel.*;

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

    public void exportExcelData(List list, HSSFWorkbook workbook,String[] head,String headTitle) {
        Grade grade = null;
        HSSFRow row = null;
        HSSFCell cell = null;
        int classLength;
        int maxClassLength = 0;
        HSSFCellStyle cellStyle = null;
        HSSFSheet sheet = workbook.createSheet();
        row = sheet.createRow(0);
        row.setHeight((short)(20*25));
        cellStyle=ExcelUtil.createHeadStyle(workbook,(short)12,true);
        for (int j = 0; j < head.length; j++) {
            cell = row.createCell(j);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(head[j]);
        }
        for (int j = 0; j < list.size(); j++) {
            grade = (Grade) list.get(j);
            row = sheet.createRow(j + 1);
            row.setHeight((short)(20*25));
            cell = row.createCell(0);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(grade.getUsername() + "");
            sheet.setColumnWidth(0, 256 * ((grade.getUsername() + "").length() + 10));
            cell = row.createCell(1);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(grade.getStudent().getName());
            sheet.setColumnWidth(1, 256 * (5 * 2 + 10));
            cell = row.createCell(2);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(grade.getStudent().getStudentClass());
            classLength = grade.getStudent().getStudentClass().length();
            maxClassLength = classLength > maxClassLength ? classLength : maxClassLength;
            sheet.setColumnWidth(2, 256 * (maxClassLength * 2 + 10));
            cell = row.createCell(3);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(grade.getGrade());
            sheet.setColumnWidth(3, 256 * ((grade.getGrade()+"").length() * 2 + 10));
            cell = row.createCell(4);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(grade.getGroupName());
            sheet.setColumnWidth(4, 256 * (grade.getGroupName().length() * 2 + 10));
        }

    }
}
