package com.dcms.excel;

import com.dcms.model.Student;
import com.dcms.utils.Tool;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/2/19.
 */
public class StudentExcelData implements ExcelData {
    public void exportExcelData(List list, HSSFWorkbook workbook, String[] head,String headTitle) {
      /*  HSSFSheet sheet=workbook.createSheet();
        Student student=null;
        HSSFRow row=null;
        HSSFCell cell=null;
        int collegeLength;
        int maxCollegeLength=0;
        int classLength;
        int maxClassLength=0;
        HSSFCellStyle cellStyle=ExcelUtil.createHeadStyle(workbook,(short)12,true);
        for(int i=0;i<list.size();i++){
            student=(Student) list.get(i);
            row=sheet.createRow(i+1);
            cell=row.createCell(0);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(student.getUsername()+"");
            cell=row.createCell(1);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(student.getName());
            cell=row.createCell(2);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(student.getPassword());
            cell=row.createCell(3);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(student.getStudentClass());
            classLength=student.getStudentClass().length();
            maxClassLength=classLength>maxClassLength?classLength:maxClassLength;
            sheet.setColumnWidth(4, 256 * ( maxClassLength* 2 + 4));
            cell=row.createCell(4);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(student.getCollege());
            collegeLength=student.getCollege().length();
            maxCollegeLength=collegeLength>maxCollegeLength?collegeLength:maxCollegeLength;
            sheet.setColumnWidth(4, 256 * ( maxCollegeLength* 2 + 4));
            cell=row.createCell(5);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(student.getPhone()+"");
            cell=row.createCell(6);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(student.getEmail());
        }*/
    }

    public List getExcelData(List<List<String>> list) {
        List<Student> studentList=new ArrayList<Student>();
        List<String>  fieldList=null;
        Student student=null;
        for(int i=0;i<list.size();i++){
            fieldList=list.get(i);
            if(fieldList.get(0).length()!=0&&Tool.isNumber(fieldList.get(0))){
                student=new Student();
              student.setUsername(Long.parseLong(fieldList.get(0)));
              student.setName(fieldList.get(1));
              student.setPassword(fieldList.get(2));
              student.setStudentClass(fieldList.get(3));
              student.setCollege(fieldList.get(4));
              if(fieldList.get(5).length()!=0&&Tool.isNumber(fieldList.get(5))){
                  student.setPhone(Long.parseLong(fieldList.get(5)));
              }
              student.setEmail(fieldList.get(6));
              studentList.add(student);
            }
        }
        return studentList;
    }
}
