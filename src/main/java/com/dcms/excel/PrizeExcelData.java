package com.dcms.excel;

import com.dcms.model.Prize;
import com.dcms.utils.Tool;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

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

    public void exportExcelData(List list, HSSFWorkbook workbook, HSSFSheet sheet) {

    }
}
