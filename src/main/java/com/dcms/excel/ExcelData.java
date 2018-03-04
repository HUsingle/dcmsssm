package com.dcms.excel;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.List;

/**
 * Created by single on 2018/2/19.
 */
public interface ExcelData {
    //将excel数据转换成对应的实体
    List getExcelData(List<List<String>> list);
    //设置导出表格的数据
    void exportExcelData(List list, HSSFWorkbook workbook, HSSFSheet sheet);
}
