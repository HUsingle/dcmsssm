package com.dcms.excel;

import com.dcms.model.Prize;
import com.dcms.utils.ExcelUtil;
import com.dcms.utils.Tool;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/4/22.
 */
public class PrizeExcelData implements ExcelData {
    public List getExcelData(List<List<String>> list) {
        List<Prize> prizeList=new ArrayList<Prize>();
        List<String>  fieldList=null;
        Prize prize=null;
        for(int i=0;i<list.size();i++){
            fieldList=list.get(i);
            if(fieldList.get(0).length()!=0&& Tool.isNumber(fieldList.get(0))){
                prize=new Prize();
                prize.setUsername(Long.parseLong(fieldList.get(0)));
                prize.setPrize(fieldList.get(1));
                prizeList.add(prize);
            }
        }
        return prizeList;
     
    }

    public void exportExcelData(List list, HSSFWorkbook workbook, String[] head,String headTitle) {
        Prize prize = null;
        HSSFRow row = null;
        HSSFCell cell = null;
        int classLength;
        int maxClassLength = 0;
        HSSFCellStyle cellStyle = null;
        HSSFSheet sheet = workbook.createSheet();
        //合并单元格
        CellRangeAddress cra = new CellRangeAddress(0, 2, 0, 4); // 起始行, 终止行, 起始列, 终止列
        sheet.addMergedRegion(cra);
        row = sheet.createRow(0);
        cell=row.createCell(0);
        cellStyle= ExcelUtil.createHeadStyle(workbook,(short) 14,false);
        cell.setCellStyle(cellStyle);
        cell.setCellValue(headTitle+"获奖名单");
        row = sheet.createRow(3);
        row.setHeight((short)(20*35));
        cellStyle=ExcelUtil.createHeadStyle(workbook,(short)12,true);
        for (int j = 0; j < head.length; j++) {
            cell = row.createCell(j);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(head[j]);
        }
        for (int j = 0; j < list.size(); j++) {
            prize = (Prize) list.get(j);
            row = sheet.createRow(j + 4);
            row.setHeight((short)(20*35));
            cell = row.createCell(0);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(prize.getUsername() + "");
            sheet.setColumnWidth(0, 256 * ((prize.getUsername() + "").length() + 10));
            cell = row.createCell(1);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(prize.getStudent().getName());
            sheet.setColumnWidth(1, 256 * (5 * 2 + 10));
            cell = row.createCell(2);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(prize.getStudent().getStudentClass());
            classLength = prize.getStudent().getStudentClass().length();
            maxClassLength = classLength > maxClassLength ? classLength : maxClassLength;
            sheet.setColumnWidth(2, 256 * (maxClassLength * 2 + 10));
            cell = row.createCell(3);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(prize.getPrize());
            sheet.setColumnWidth(3, 256 * (prize.getPrize().length() * 2 + 10));
            cell = row.createCell(4);
            cell.setCellStyle(cellStyle);
            cell.setCellValue(prize.getGroupName());
            sheet.setColumnWidth(4, 256 * (prize.getGroupName().length() * 2 + 10));
        }
    }
}
