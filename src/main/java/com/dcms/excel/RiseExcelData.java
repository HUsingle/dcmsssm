package com.dcms.excel;

import com.dcms.model.Rise;
import com.dcms.utils.Tool;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/4/23.
 */
public class RiseExcelData implements ExcelData {
    public List getExcelData(List<List<String>> list) {
        List<Rise> riseList=new ArrayList<Rise>();
        List<String>  fieldList=null;
        Rise rise=null;
        for(int i=0;i<list.size();i++){
            fieldList=list.get(i);
            if(fieldList.get(0).length()!=0&& Tool.isNumber(fieldList.get(0))){
                rise=new Rise();
                rise.setUsername(Long.parseLong(fieldList.get(0)));
                riseList.add(rise);
            }
        }
        return riseList;
    }

    public void exportExcelData(List list, HSSFWorkbook workbook, HSSFSheet sheet) {

    }
}
