package com.dcms.excel;

import com.dcms.model.ClassroomArrange;
import com.dcms.model.Invigilation;
import com.dcms.utils.ExcelUtil;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;

import java.util.List;

/**
 * Created by single on 2018/4/25.
 */
public class ClassroomArrangeExcelData implements ExcelData {
    public List getExcelData(List<List<String>> list) {
        return null;
    }

    public void exportExcelData(List list, HSSFWorkbook workbook, String[] head, String headTitle) {

        HSSFRow row = null;
        HSSFCell cell = null;
        int classLength;
        int maxClassLength = 0;
        HSSFCellStyle cellStyle = null;
        List<Invigilation> invigilationList=(List<Invigilation>)list.get(0);
        List<ClassroomArrange> classroomArrangeList=null;
        list.remove(0);
        HSSFSheet sheet = null;
        CellRangeAddress cra=null;
        for(int i=0;i<list.size();i++) {
            sheet = workbook.createSheet("sheet" +i);
            classroomArrangeList=(List<ClassroomArrange>)list.get(i);
            for(int j=0;j<3;j++){
            cra = new CellRangeAddress(j, j, 0, 5); // 起始行, 终止行, 起始列, 终止列
            sheet.addMergedRegion(cra);
            }
            row = sheet.createRow(0);
            cell = row.createCell(0);
            row.setHeight((short) (20 * 31));
            cellStyle = ExcelUtil.createHeadStyle(workbook, (short) 14, false);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(headTitle);
            row = sheet.createRow(1);
            cell = row.createCell(0);
            row.setHeight((short) (20 * 28));
            cellStyle = ExcelUtil.createHeadStyle(workbook, (short) 13, false);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(classroomArrangeList.get(0).getClassroom().getSite()+"考场");
            row = sheet.createRow(2);
            cell = row.createCell(0);
            row.setHeight((short) (20 * 25));
            cellStyle = ExcelUtil.createHeadStyle(workbook, (short) 12, false);
            cell.setCellStyle(cellStyle);
            String teacherName="";
            for(int k=0;k<invigilationList.size();k++){
                if(invigilationList.get(k).getClassroomId()==classroomArrangeList.get(0).getClassroomId()){
                    teacherName+=invigilationList.get(k).getTeacher().getName()+" ";
                }
            }
            cell.setCellValue("监考老师："+teacherName);
            setValue(workbook,head,classroomArrangeList,sheet);
        }

    }
    private void setValue(HSSFWorkbook workbook, String[] head,  List list, HSSFSheet sheet){
        HSSFCell cell = null;
        HSSFRow row=null;
        ClassroomArrange classroomArrange=null;
        int classLength;
        int maxClassLength = 0;
        HSSFCellStyle cellStyle= ExcelUtil.createHeadStyle(workbook,(short)12,true);
        row = sheet.createRow(3);
        row.setHeight((short)(20*25));
        for (int j = 0; j < head.length; j++) {
            cell = row.createCell(j);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(head[j]);
        }
        for (int j = 0; j < list.size(); j++) {
            classroomArrange = (ClassroomArrange) list.get(j);
            row = sheet.createRow(j + 4);
            row.setHeight((short)(20*25));
            cell = row.createCell(0);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(classroomArrange.getSeatNumber() + "");
            sheet.setColumnWidth(0, 256 * 11);
            cell = row.createCell(1);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(classroomArrange.getApply().getStudent().getUsername() + "");
            sheet.setColumnWidth(1, 256 * ((classroomArrange.getApply().getStudent().getUsername() + "").length() + 5));
            cell = row.createCell(2);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(classroomArrange.getApply().getStudent().getName());
            sheet.setColumnWidth(2, 256 * (5 * 2 + 5));
            cell = row.createCell(3);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(classroomArrange.getApply().getStudent().getStudentClass());
            classLength = classroomArrange.getApply().getStudent().getStudentClass().length();
            maxClassLength = classLength > maxClassLength ? classLength : maxClassLength;
            sheet.setColumnWidth(3, 256 * (maxClassLength * 2 + 5));
            cell = row.createCell(4);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(classroomArrange.getApply().getStudent().getPhone()+"");
            sheet.setColumnWidth(4, 256 * ((classroomArrange.getApply().getStudent().getPhone()+"").length() * 2 + 5));
            cell = row.createCell(5);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(classroomArrange.getApply().getCompetitionGroup());
            sheet.setColumnWidth(5, 256 * (classroomArrange.getApply().getCompetitionGroup().length()* 2 + 5));
        }
    }
}
