package com.dcms.service.imp;

import com.alibaba.fastjson.JSONObject;
import com.dcms.dao.ApplyMapper;
import com.dcms.dao.GradeMapper;
import com.dcms.model.CompetitionStat;
import com.dcms.service.CompetitionStatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by single on 2018/4/26.
 */
@Service
public class CompetitionStatServiceImpl implements CompetitionStatService {
    @Autowired
    private GradeMapper gradeMapper;
    @Autowired
    private ApplyMapper applyMapper;
    @Transactional
    public String getStatInformation(Integer id) {
       // List<CompetitionStat> resultList=new ArrayList<CompetitionStat>();
        List<CompetitionStat> ApplyNumber=applyMapper.getApplyNumbByGroup(id);
        List<CompetitionStat> sumApplyNumber=applyMapper.getApplyNumbById(id);
        List<CompetitionStat> compAVG=gradeMapper.getCompetitionAvgById(id);
        List<CompetitionStat> compGroupAvg=gradeMapper.getCompetitionAvgByGroup(id);
        List<CompetitionStat> maxAndMinGradeById=gradeMapper.getMaxAndMinGradeById(id);
        List<CompetitionStat> maxAndMinGradeByGroup=gradeMapper.getMaxAndMinGradeByGroup(id);
        CompetitionStat competitionStat=null;
        JSONObject result = new JSONObject();
        if(ApplyNumber.size()==0){
            result.put("total", 0);
            result.put("rows", ApplyNumber);
            return result.toString();
        }
        for(int j=0;j<sumApplyNumber.size();j++){//将总的属性合在一个实体里
          competitionStat=sumApplyNumber.get(j);
          competitionStat.setGroupName("sum");
          competitionStat.setAverage(compAVG.get(j).getAverage());
          competitionStat.setMaxGrape(maxAndMinGradeById.get(j).getMaxGrape());
          competitionStat.setMinGrape(maxAndMinGradeById.get(j).getMinGrape());
        }
        CompetitionStat competitionStat1=null;
        for(int i=0;i<ApplyNumber.size();i++){
           competitionStat=ApplyNumber.get(i);
            for(int j=0;j<compGroupAvg.size();j++){
                competitionStat1=compGroupAvg.get(j);
                if(competitionStat.getCompetitionId()==competitionStat1.getCompetitionId()&&
                        competitionStat.getGroupName().equals(competitionStat1.getGroupName())){
                    competitionStat.setAverage(competitionStat1.getAverage());
                    break;
                }
            }

            for(int j=0;j<maxAndMinGradeByGroup.size();j++){
                competitionStat1=maxAndMinGradeByGroup.get(j);
                if(competitionStat.getCompetitionId()==competitionStat1.getCompetitionId()&&
                        competitionStat.getGroupName().equals(competitionStat1.getGroupName())){
                    competitionStat.setMaxGrape(competitionStat1.getMaxGrape());
                    competitionStat.setMinGrape(competitionStat1.getMinGrape());
                    break;
                }
            }
        }
        int id1=ApplyNumber.get(0).getCompetitionId();
        int insertNum=0;
        int k;
        for(k=1;k<ApplyNumber.size();k++){
            if(ApplyNumber.get(k).getCompetitionId()!=id1){
                ApplyNumber.add(k,sumApplyNumber.get(insertNum));
                id1=ApplyNumber.get(k+1).getCompetitionId();
                insertNum++;
            }
        }
        ApplyNumber.add(k,sumApplyNumber.get(insertNum));
        result.put("total", ApplyNumber.size());
        result.put("rows", ApplyNumber);
        return result.toString();
    }
}
