package com.dcms.service.imp;

import com.dcms.dao.ApplyMapper;
import com.dcms.dao.CompetitionMapper;
import com.dcms.dao.PrizeMapper;
import com.dcms.dao.RiseMapper;
import com.dcms.excel.ExcelData;
import com.dcms.excel.RiseExcelData;
import com.dcms.model.Apply;
import com.dcms.model.Prize;
import com.dcms.model.Rise;
import com.dcms.service.RiseService;
import com.dcms.utils.ExcelUtil;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/4/23.
 */
@Service
public class RiseServiceImpl implements RiseService {
    @Autowired
    private RiseMapper riseMapper;
    @Autowired
    private ApplyMapper applyMapper;
    @Autowired
    private PrizeMapper prizeMapper;
    @Autowired
    private CompetitionMapper competitionMapper;

    public List<Rise> findAllRiseByCidOrGroupName(Integer competitionId, String groupName, String sort) {
        return riseMapper.findAllRiseByCidOrGroupName(competitionId, groupName, sort);
    }

    public String setRise(Integer competitionId) {
        List<Rise> riseList=new ArrayList<Rise>();
        int isHasRise = riseMapper.findRiseNumber(competitionId);
        if (isHasRise > 0) {
            return Tool.result("该竞赛已经设置了晋级名单，不可以重复设置");
        }
        List<Prize> prizeList=prizeMapper.getAllPrizeUsername(competitionId);
        if(prizeList.size()==0){
            return Tool.result("该竞赛还没有获奖名单");
        }
        Rise rise=null;
        for (Prize prize:prizeList){
            rise=new Rise();
            rise.setCompetitionId(competitionId);
            rise.setUsername(prize.getUsername());
            riseList.add(rise);
        }
        return Tool.result(riseMapper.addRise(riseList));
    }

    public String addRise(Integer competitionId, String user, Integer isTeam) {
        List<Rise> riseList = new ArrayList<Rise>();
        Rise rise1 = null;
        if (isTeam > 0) {
            int isExitTeamName = applyMapper.qryNumByTeamName(user);
            if (isExitTeamName == 0) {
                return Tool.result("该团队没有参加该竞赛，不能设置为晋级");
            }
            List<Apply> applyList = applyMapper.findApplyByTeamName(user);
            int isExistKey = riseMapper.isExistRise(applyList.get(0).getUsername(), competitionId);
            if (isExistKey > 0) {
                return Tool.result("该团队已经晋级，不能重复添加！");
            }
            for (Apply apply : applyList) {
                rise1 = new Rise();
                rise1.setCompetitionId(competitionId);
                rise1.setUsername(apply.getUsername());
                riseList.add(rise1);
            }
        } else {
            Long username = Long.parseLong(user);
            int isExistApplyInf = applyMapper.isExistApplyInfo(username, competitionId);
            if (isExistApplyInf == 0) {
                return Tool.result("该学生没有参加该竞赛，不可以设置为晋级");
            }
            int isExistRise = riseMapper.isExistRise(username, competitionId);
            if (isExistRise > 0) {
                return Tool.result("该学生已经晋级，不可以重复添加！");
            }
            rise1 = new Rise();
            rise1.setCompetitionId(competitionId);
            rise1.setUsername(username);
            riseList.add(rise1);
        }
        return Tool.result(riseMapper.addRise(riseList));
    }

    public String deleteRise(String id) {
        return Tool.result(riseMapper.deleteRise(Tool.getInteger(id)));
    }


    public String importRiseExcel(MultipartFile file, Integer competitionId) {
        ExcelData riseExcelData = new RiseExcelData();
        String[] head = {"学号"};
        List dataList = ExcelUtil.importExcel(file, head, riseExcelData);
        int exResult = 0;
        String result;
        long username;
        if (dataList.size() == 0) {
            return Tool.result("缺少行或者学号出错或者所填数据不是文本类型!");
        } else if (dataList.size() == 1 && (dataList.get(0) instanceof String)) {
            return dataList.get(0).toString();

        } else {
            for (int i = dataList.size() - 1; i >= 0; i--) {
                username = ((Rise) dataList.get(i)).getUsername();
                if (applyMapper.isExistApplyInfo(username, competitionId) == 0 ||
                        riseMapper.isExistRise(username, competitionId) > 0) {
                    dataList.remove(i);
                }
            }
            if (dataList.size() > 0) {
                exResult = riseMapper.importRise(competitionId, dataList);
            }
        }
        if (exResult == 0) {
            result = Tool.result("导入失败,晋级名单的数据已经存在或者没有参加该竞赛!");
        } else {
            result = Tool.result("导入成功!");
        }
        return result;

    }

    public void exportRiseExcelModel(HttpServletResponse response) {
        String[] head = {"学号"};
        ExcelUtil.exportModeExcel(head, "晋级名单模板.xls", response, 60);
    }

    public void exportRiseExcel(HttpServletResponse response, Integer competitionId) {
        ExcelData excelData=new RiseExcelData();
        String title=competitionMapper.findCompetitionName(competitionId);
        List<Rise> riseList=riseMapper.exportRiseData(competitionId);
        String[] head={"学号","姓名","班级","组别"};
        ExcelUtil.exportExcel(head,title+"晋级名单.xls",response,excelData,riseList,title);

    }
}
