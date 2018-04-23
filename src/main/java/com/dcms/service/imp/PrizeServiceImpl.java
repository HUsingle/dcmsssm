package com.dcms.service.imp;

import com.dcms.dao.ApplyMapper;
import com.dcms.dao.GradeMapper;
import com.dcms.dao.PrizeMapper;
import com.dcms.excel.ExcelData;
import com.dcms.excel.PrizeExcelData;
import com.dcms.model.Apply;
import com.dcms.model.Grade;
import com.dcms.model.Prize;
import com.dcms.service.PrizeService;
import com.dcms.utils.ExcelUtil;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/4/22.
 */
@Service
public class PrizeServiceImpl implements PrizeService {
    @Autowired
    private PrizeMapper prizeMapper;
    @Autowired
    private ApplyMapper applyMapper;
    @Autowired
    private GradeMapper gradeMapper;

    public List<Prize> findAllPrizeByCidOrGroupName(Integer competitionId, String groupName, String sort) {
        return prizeMapper.findAllPrizeByCidOrGroupName(competitionId, groupName, sort);
    }

    public String setPrize(Integer competitionId, String groupName, String prizeNumber) {
        List<Prize> prizeList=new ArrayList<Prize>();
        int isHasPrize = prizeMapper.findPrizeNumber(competitionId, groupName);
        if (isHasPrize > 0) {
            return Tool.result("该竞赛该组别已经设置奖项，不可以重复设置");
        }
        Integer[] prizeArrays = Tool.getInteger(prizeNumber);
        int sum = 0;
        for (int prizeNum : prizeArrays) {
            sum += prizeNum;
        }
        if (sum > 0) {
            List<Grade> gradeList = gradeMapper.getPrizeNum(competitionId, groupName, sum);
            if(gradeList.size()!=sum){
                return Tool.result("该竞赛中成绩数与安排奖项人数不符合！");
            }
            Prize prize=null;
            for(int i=0;i<gradeList.size();i++){
                prize=new Prize();
                prize.setCompetitionId(competitionId);
                prize.setUsername(gradeList.get(i).getUsername());
                if(i<prizeArrays[0]){
                 prize.setPrize("一等奖");
                }else if(i<prizeArrays[0]+prizeArrays[1]){
                    prize.setPrize("二等奖");
                }else{
                    prize.setPrize("三等奖");
                }
                prizeList.add(prize);
            }

        }

        return Tool.result(prizeMapper.addPrize(prizeList));
    }

    public String addPrize(Integer competitionId, String prize, String user, Integer isTeam) {
        List<Prize> prizeList = new ArrayList<Prize>();
        Prize prize1 = null;
        if (isTeam > 0) {
            int isExitTeamName = applyMapper.qryNumByTeamName(user);
            if (isExitTeamName == 0) {
                return Tool.result("该团队没有参加该竞赛，不能添加奖项");
            }
            List<Apply> applyList = applyMapper.findApplyByTeamName(user);
            int isExistKey = prizeMapper.isExistPrize(applyList.get(0).getUsername(), competitionId);
            if (isExistKey > 0) {
                return Tool.result("该学生的奖项已经存在，不能重复添加！");
            }
            for (Apply apply : applyList) {
                prize1 = new Prize();
                prize1.setCompetitionId(competitionId);
                prize1.setPrize(prize);
                prize1.setUsername(apply.getUsername());
                prizeList.add(prize1);
            }
        } else {
            Long username = Long.parseLong(user);
            int isExistApplyInf = applyMapper.isExistApplyInfo(username, competitionId);
            if (isExistApplyInf == 0) {
                return Tool.result("该学生没有参加该竞赛，不可以添加奖项");
            }
            int isExistPrize = prizeMapper.isExistPrize(username, competitionId);
            if (isExistPrize > 0) {
                return Tool.result("该学生的奖项已经存在，不可以重复奖项！");
            }
            prize1 = new Prize();
            prize1.setCompetitionId(competitionId);
            prize1.setPrize(prize);
            prize1.setUsername(username);
            prizeList.add(prize1);
        }
        return Tool.result(prizeMapper.addPrize(prizeList));
    }

    public String deletePrize(String id) {
        return Tool.result(prizeMapper.deletePrize(Tool.getInteger(id)));
    }

    public String updatePrize(String prize, String id, Integer isTeam, Integer competitionId) {
        List<Prize> prizeList = new ArrayList<Prize>();
        Prize prize1 = null;
        if (isTeam > 0) {
            List<Prize> prizes = prizeMapper.getPrizeId(competitionId, id);
            for (Prize prize2 : prizes) {
                prize1 = new Prize();
                prize1.setPrize(prize);
                prize1.setId(prize2.getId());
                prizeList.add(prize1);
            }
        } else {
            prize1 = new Prize();
            prize1.setId(Integer.parseInt(id));
            prize1.setPrize(prize);
            prizeList.add(prize1);
        }
        return Tool.result(prizeMapper.updatePrize(prizeList));
    }

    public String importPrizeExcel(MultipartFile file, Integer competitionId) {
        ExcelData prizeInsertExcelData = new PrizeExcelData();
        String[] head = {"学号", "奖项"};
        List dataList = ExcelUtil.importExcel(file, head, prizeInsertExcelData);
        int exResult = 0;
        String result;
        long username;
        if (dataList.size() == 0) {
            return Tool.result("缺少行或者学号出错!");
        } else if (dataList.size() == 1 && (dataList.get(0) instanceof String)) {
            return dataList.get(0).toString();

        } else {
            for (int i = dataList.size() - 1; i >= 0; i--) {
                username = ((Prize) dataList.get(i)).getUsername();
                if (applyMapper.isExistApplyInfo(username, competitionId) == 0 ||
                        prizeMapper.isExistPrize(username, competitionId) > 0) {
                    dataList.remove(i);
                }
            }
            if (dataList.size() > 0) {
                exResult = prizeMapper.importPrize(competitionId, dataList);
            }
        }
        if (exResult == 0) {
            result = Tool.result("导入失败,奖项的数据已经存在或者没有参加该竞赛!");
        } else {
            result = Tool.result("导入成功!");
        }
        return result;

    }

    public void exportPrizeExcelModel(HttpServletResponse response) {
        String[] head = {"学号", "奖项",};
        ExcelUtil.exportModeExcel(head, "获奖导入模板.xls", response, true, null, null, 401);
    }

    public void exportPrizeExcel(HttpServletResponse response, Integer competitionId) {

    }
}
