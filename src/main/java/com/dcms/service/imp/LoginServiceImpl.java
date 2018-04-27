package com.dcms.service.imp;

import com.dcms.dao.StudentMapper;
import com.dcms.dao.TeacherMapper;
import com.dcms.model.Student;
import com.dcms.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    StudentMapper stu;
    @Autowired
    TeacherMapper tea;
    //@Autowired
    //CompetitionMapper competitionMapper;
    //检查学生账号
    public boolean checkStu(String account,String pwd) {
        Student student = stu.qryByAccountAndPwd(account,pwd);
        //List<Competition> competitionList=competitionMapper.findCompetitionCompStatTime();
        //Timestamp compStatTime=null;
        if (null!=student){
          /*  for(Competition competition:competitionList){
                compStatTime=competition.getCompeStartTime();
            }*/
            return true;
        }
        return false;
    }
    //检查老师账号
    public boolean checkTea(String account,String pwd) {
        return false;
    }
}
