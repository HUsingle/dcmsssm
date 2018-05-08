package com.dcms.utils;

import com.dcms.excel.ExcelData;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Component;
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
@Component
public class ExcelUtil {

    //表格中单元格的样式
    public static HSSFCellStyle createHeadStyle(HSSFWorkbook workbook) {
        HSSFCellStyle cellStyle = workbook.createCellStyle(); //创建单元格样式
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//设置居中
        DataFormat format = workbook.createDataFormat();
        cellStyle.setDataFormat(format.getFormat("@"));//设置为文本
        HSSFFont font = workbook.createFont(); //创建字体
        font.setFontName("宋体");//设置字体样式
        font.setFontHeightInPoints((short) 14);  //设置字体大小
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  //设置粗体
        cellStyle.setFont(font); //设置字体
        return cellStyle;
    }

    //表格中单元格的样式
    public static HSSFCellStyle createHeadStyle(HSSFWorkbook workbook, short fontSize, boolean hasBorder) {
        HSSFCellStyle cellStyle = workbook.createCellStyle(); //创建单元格样式
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);//设置居中
        cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        DataFormat format = workbook.createDataFormat();
        cellStyle.setDataFormat(format.getFormat("@"));//设置为文本
        HSSFFont font = workbook.createFont(); //创建字体
        font.setFontName("宋体");//设置字体样式
        font.setFontHeightInPoints(fontSize);
        cellStyle.setFont(font); //设置字体
        if (hasBorder) {
            cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
            cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        }
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
    //获取单元格的数据
    private static String getCellValue(Cell cell) {
        String value = "";
        if (cell != null) {
            switch (cell.getCellType()) {
                case Cell.CELL_TYPE_STRING://字符串
                    value = cell.getStringCellValue();
                    break;
                case Cell.CELL_TYPE_NUMERIC://数字
                    value=cell.getNumericCellValue()+"";
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

    //导出表格模板
    public static void exportModeExcel(String[] head, String fileName,
                                       HttpServletResponse response, int blankRow) {
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
            HSSFCellStyle cellStyle=createHeadStyle(workbook);
            for (int i = 0; i < head.length; i++) {//设置表头
                cell = row.createCell(i);
                cell.setCellStyle(cellStyle);
                cell.setCellValue(head[i]);
                sheet.setColumnWidth(i, 256 * (head[i].length() * 2 + 14));
            }
            HSSFCellStyle cellStyle1=createHeadStyle(workbook,(short)12,false);
                for (int j = 1; j < blankRow; j++) {//设置前blankRow行为文本格式类型
                    row = sheet.createRow(j);
                    for (int k = 0; k < head.length; k++) {
                        cell = row.createCell(k);
                        cell.setCellStyle(cellStyle1);
                    }
                }

            OutputStream outputStream = response.getOutputStream();
            workbook.write(outputStream);
            outputStream.close();
            workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    //导出excel数据
    public static void exportExcel(String[] head, String fileName,
                                   HttpServletResponse response, ExcelData excelData,
                                   List list, String headTitle) {
        try {
            response.reset();//设置response信息
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            String enFileName = URLEncoder.encode(fileName, "UTF-8");
            response.setHeader("Content-Disposition", "attachment; filename=" + enFileName);
            HSSFWorkbook workbook = new HSSFWorkbook();
            excelData.exportExcelData(list, workbook, head, headTitle);
            OutputStream outputStream = response.getOutputStream();
            workbook.write(outputStream);
            outputStream.close();
            workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //导入表格，解析表格，获取相关实体的列表
    public static List importExcel(MultipartFile file, String[] head, ExcelData excelData) {
        String fileName = file.getOriginalFilename();
        Workbook workbook = null;
        Cell cell=null;
        List<List<String>> lists = new ArrayList<List<String>>();
        List<String> errorList = new ArrayList<String>();
        try {
            InputStream inputStream = file.getInputStream();
            if (fileName.endsWith("xls")) {//判断excel的后缀
                workbook = new HSSFWorkbook(inputStream);
            } else {
                workbook = new XSSFWorkbook(inputStream);
            }
            Sheet sheet = workbook.getSheetAt(0);//获取表头
            int lastRowNum = sheet.getLastRowNum();//获取最后一行下标
            int lastCellNum;
            if (lastRowNum < 1) {
                errorList.add(Tool.result("请填入相关数据！"));
                return errorList;
            }
            for (int i = 0; i <= lastRowNum; i++) {//从第一行到最后一行获取数据
                Row row = sheet.getRow(i);  //获得一行
                if (row != null) {
                  lastCellNum = row.getLastCellNum(); //获得最后一个单元格下标
                    //System.out.print(lastCellNum+"/101");
                    //System.out.println(head.length+"  "+lastCellNum);
                  /*  if (lastCellNum != head.length) {//判断下标与表头的长度是否相等
                        errorList.add(Tool.result("字段数目与模板不相符！"));
                        return errorList;
                    }*/
                    if (i== 0) {//如果是表头
                        for (int k = 0; k < head.length; k++) {
                           cell = row.getCell(k);
                           // System.out.println(getCellValue(headCell)+"sfd");
                            if (!head[k].equals(getCellValue(cell))) {////判断导入表格的表头的字段是否正确
                                errorList.add(Tool.result("表头字段不对或者顺序不对！"));
                                return errorList;
                            }
                        }
                    } else {//不是，则将表格的一行数据放在list中，再添加lists中
                        List<String> list = new ArrayList<String>();
                        for (int j = 0; j < lastCellNum; j++) {
                            cell = row.getCell(j);
                            //System.out.println(getCellValue(cell)+"w");
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
