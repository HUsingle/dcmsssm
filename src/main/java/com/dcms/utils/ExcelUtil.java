package com.dcms.utils;

import com.dcms.excel.ExcelData;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/2/17.
 * 创建excel的工具类
 */

public class ExcelUtil {

    //表格样式
    public static HSSFCellStyle createHeadStyle(HSSFWorkbook workbook, boolean isHead) {
        HSSFCellStyle cellStyle = workbook.createCellStyle(); //创建单元格样式
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//设置居中
        DataFormat format = workbook.createDataFormat();
        cellStyle.setDataFormat(format.getFormat("@"));//设置为文本
        HSSFFont font = workbook.createFont(); //创建字体
        font.setFontName("宋体");//设置字体样式
        if (isHead) {
            font.setFontHeightInPoints((short) 12);  //设置字体大小
            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  //设置粗体
        } else {
            font.setFontHeightInPoints((short) 10);
        }
        cellStyle.setFont(font); //设置字体
        /*cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);*///设置边框
        return cellStyle;
    }

   /* private static String getCellValue(Cell cell) {
        String value = "";
        if (cell != null) {
            switch (cell.getCellType()) {
                case Cell.CELL_TYPE_BLANK://空值
                    value="";
                    break;
                case Cell.CELL_TYPE_BOOLEAN://布尔型
                    value=cell.getBooleanCellValue()+"";
                    break;
                case Cell.CELL_TYPE_ERROR://错误
                    value="";
                    break;
                case Cell.CELL_TYPE_FORMULA://公式
                    value=cell.getCellFormula();
                    break;
                case Cell.CELL_TYPE_NUMERIC://数字
                    value=cell.getNumericCellValue()+"";
                    break;
                case Cell.CELL_TYPE_STRING://字符串
                    value=cell.getStringCellValue();
                    break;
                default:
                    value="";
                    break;
            }
        }
        return value;
    }*/

    private static String getCellValue(Cell cell) {
        String value = "";
        if (cell != null) {
            switch (cell.getCellType()) {
                case Cell.CELL_TYPE_STRING://字符串
                    value = cell.getStringCellValue();
                    break;
                default:
                    value = "";
                    break;
            }
        }
        return value;
    }
    // 设置为文本格式
  /*  private static CellStyle setCellTextType(Workbook workbook){
        CellStyle style = workbook.createCellStyle();
        DataFormat format = workbook.createDataFormat();
        style.setDataFormat(format.getFormat("@"));
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        return style;
    }*/

    //导出表格
    public static void exportModeExcel(String[] head, String fileName, HttpServletResponse response, boolean isModel,ExcelData excelData,List list) {
        try {
            response.reset();//设置response信息
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            String enFileName = URLEncoder.encode(fileName, "UTF-8");
            response.setHeader("Content-Disposition", "attachment; filename=" + enFileName);
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet();
            HSSFRow row = null;
            HSSFCell cell = null;
            row = sheet.createRow(0);
            for (int i = 0; i < head.length; i++) {
                cell = row.createCell(i);
                cell.setCellStyle(createHeadStyle(workbook, true));
                cell.setCellValue(head[i]);
                // sheet.autoSizeColumn(i);
                //with的参数是单个字符的256分之一
                // cell.setCellType(HSSFCell.CELL_TYPE_STRING);
                sheet.setColumnWidth(i, 256 * (head[i].length() * 2 + 14));
            }
            if (isModel) {
                for (int j = 1; j < 401; j++) {//设置前400行为文本格式类型
                    row = sheet.createRow(j);
                    for (int k = 0; k < head.length; k++) {
                        cell = row.createCell(k);
                        cell.setCellStyle(createHeadStyle(workbook, false));
                        // cell.setCellType(HSSFCell.CELL_TYPE_STRING);
                    }
                }
            } else {
                excelData.exportExcelData(list,workbook,sheet);
            }
            OutputStream outputStream = response.getOutputStream();
            workbook.write(outputStream);
            outputStream.close();
            workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    public static List importExcel(MultipartFile file, String[] head, ExcelData excelData) {
        String fileName = file.getOriginalFilename();
        Workbook workbook = null;
        List<List<String>> lists = new ArrayList<List<String>>();
        List<String> errorList = new ArrayList<String>();
        try {
            InputStream inputStream = file.getInputStream();
            if (fileName.endsWith("xls")) {
                workbook = new HSSFWorkbook(inputStream);
            } else {
                workbook = new XSSFWorkbook(inputStream);
            }
            Sheet sheet = workbook.getSheetAt(0);
            int firstRowNum = sheet.getFirstRowNum();
            int lastRowNum = sheet.getLastRowNum();
            if (lastRowNum < 1) {
                errorList.add(Tool.result("请填入相关数据！"));
                return errorList;
            }
            for (int i = firstRowNum; i <= lastRowNum; i++) {
                Row row = sheet.getRow(i);
                if (row != null) {
                    int lastCellNum = row.getLastCellNum();
                    if (lastCellNum != head.length) {
                        errorList.add(Tool.result("缺少列！"));
                        return errorList;
                    }
                    if (firstRowNum == i) {
                        for (int k = 0; k < head.length; k++) {
                            Cell headCell = row.getCell(k);
                            if (!head[k].equals(getCellValue(headCell))) {
                                errorList.add(Tool.result("表头字段不对或者顺序不对！"));
                                return errorList;
                            }
                        }
                    } else {
                        List<String> list = new ArrayList<String>();
                        for (int j = row.getFirstCellNum(); j < lastCellNum; j++) {
                            Cell cell = row.getCell(j);
                            list.add(getCellValue(cell));
                        }
                        lists.add(list);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return excelData.getExcelData(lists);
    }


}
