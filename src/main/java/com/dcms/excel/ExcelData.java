package com.dcms.excel;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.List;

/**
 * Created by single on 2018/2/19.
 */
public interface ExcelData {
    List insertExcelData(List<List<String>> list);
    void exportExcelData(List list, HSSFWorkbook workbook, HSSFSheet sheet);
}
