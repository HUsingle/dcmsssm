package com.dcms.service.imp;

import com.dcms.dao.ClassroomArrangeMapper;
import com.dcms.dao.CompetitionMapper;
import com.dcms.dao.StudentMapper;
import com.dcms.dao.TeacherMapper;
import com.dcms.model.Competition;
import com.dcms.model.Student;
import com.dcms.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    StudentMapper stu;
    @Autowired
    TeacherMapper tea;
    @Autowired
    CompetitionMapper competitionMapper;
    @Autowired
    ClassroomArrangeMapper classroomArrangeMapper;
    //检查学生账号

    public boolean checkStu(String account,String pwd) {
        Student student = stu.qryByAccountAndPwd(account,pwd);
        List<Competition> competitionList=competitionMapper.findCompetitionCompStatTime();
        Date compStatTime=null;
        if (null!=student){
            for(Competition competition:competitionList){
                compStatTime=new Date(competition.getCompeStartTime().getTime());
                long time=((compStatTime.getTime()-new Date().getTime())/1000)/60;
                if(time<20&&time>-20){//在竞赛开始时间20分钟前后进入系统，则不为缺考
                  classroomArrangeMapper.updateAbsent(competition.getCid(),Long.parseLong(account));
                  break;
                }
            }
            return true;
        }
        return false;
    }
    //检查老师账号
    public boolean checkTea(String account,String pwd) {
        return false;
    }
}
