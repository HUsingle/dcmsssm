package com.dcms.service.imp;

import com.dcms.dao.ClassroomMapper;
import com.dcms.dao.InvigilationMapper;
import com.dcms.dao.TeacherMapper;
import com.dcms.model.Classroom;
import com.dcms.model.Invigilation;
import com.dcms.model.Teacher;
import com.dcms.service.InvigilationService;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by single on 2018/4/19.
 */
@Service
public class InvigilationServiceImpl implements InvigilationService {
    @Autowired
    private InvigilationMapper invigilationMapper;
    @Autowired
    private TeacherMapper teacherMapper;
    @Autowired
    private ClassroomMapper classroomMapper;

    public List<Invigilation> findInvigilation(Integer competitionId) {
        return invigilationMapper.findInvigilation(competitionId);
    }


    @Transactional
    public String insertInvigilation(Integer competitionId, String teacherId, Integer classroomId) {
        Long[] teacher = Tool.getLong(teacherId);
        Invigilation invigilation = null;
        for (int j = 0; j < teacher.length; j++) {
            if (invigilationMapper.findAlreadyInvigilation(competitionId, teacher[j]) > 0) {
                return Tool.result("该老师已经被安排，不能重复安排");
            }
        }
        List<Invigilation> invigilationList = new ArrayList<Invigilation>();
        for (int i = 0; i < teacher.length; i++) {
            invigilation = new Invigilation();
            invigilation.setClassroomId(classroomId);
            invigilation.setTeacherId(teacher[i]);
            invigilation.setCompetitionId(competitionId);
            invigilationList.add(invigilation);
        }
        return Tool.result(invigilationMapper.insertInvigilation(invigilationList));
    }

    public String autoArrangeInvigilation(Integer competitionId) {
        if (invigilationMapper.isExistInvigilation(competitionId) > 0) {
            return Tool.result("该竞赛已经存在监考，无法进行自动监考");
        }
        List<Teacher> teacherList = teacherMapper.findAllTeacherIdAndSex();
        List<Classroom> classroomList = classroomMapper.getAllClassroom("asc");
        if (2 * classroomList.size() > teacherList.size()) {
            return Tool.result("考场过多,无法为每个考场都安排2个监考老师！");
        }
        if (classroomList.size() == 0) {
            return Tool.result("没有考场，不可以安排");
        }
        List<Teacher> oneKindTeacher = new ArrayList<Teacher>();
        String sex;
        for (int i = 0; i < teacherList.size(); i++) {
            sex = teacherList.get(i).getSex();
            if (sex == null || sex.length() == 0) {
                return Tool.result("老师的性别存在空值！");
            }
        }
        sex = teacherList.get(0).getSex();
        oneKindTeacher.add(teacherList.get(0));
        for (int i = teacherList.size() - 1; i > 0; i--) {
            if (sex.equals(teacherList.get(i).getSex())) {
                oneKindTeacher.add(teacherList.get(i));
                teacherList.remove(i);
            }
        }
        teacherList.remove(0);
        List<Long> teacherIdList = new ArrayList<Long>();//男老师或者女老师的idList
        List<Long> otherTeacherIdList = new ArrayList<Long>();//男老师或者女老师的idList
        for (int j = 0; j < oneKindTeacher.size(); j++) {
            teacherIdList.add(oneKindTeacher.get(j).getId());
        }
        for (int j = 0; j < teacherList.size(); j++) {
            otherTeacherIdList.add(teacherList.get(j).getId());
        }
        Collections.shuffle(teacherIdList);
        Collections.shuffle(otherTeacherIdList);//随机打乱list
        List<Invigilation> invigilationList = new ArrayList<Invigilation>();
        int insertPosition = 1;
        List<Long> longList = null;//最后的男女男女..的排列teacherId
        if (teacherIdList.size() > otherTeacherIdList.size()) {
            for (int i = 0; i < otherTeacherIdList.size(); i++) {
                teacherIdList.add(insertPosition, otherTeacherIdList.get(i));
                insertPosition += 2;
            }
            longList = teacherIdList;
        } else {
            for (int i = 0; i < teacherIdList.size(); i++) {
                otherTeacherIdList.add(insertPosition, teacherIdList.get(i));
                insertPosition += 2;
            }
            longList = otherTeacherIdList;
        }
        Invigilation invigilation = null;
        Invigilation invigilation1 = null;
        int j = 0;
        for (int k = 0; k < classroomList.size(); k++) {//为每个考场安排两个老师（尽量男女搭配）
            invigilation=new Invigilation();
            invigilation1=new Invigilation();
            invigilation.setCompetitionId(competitionId);
            invigilation1.setCompetitionId(competitionId);
            invigilation.setClassroomId(classroomList.get(k).getId());
            invigilation1.setClassroomId(classroomList.get(k).getId());
            invigilation.setTeacherId(longList.get(j));
            invigilation1.setTeacherId(longList.get(j + 1));
            j += 2;
            invigilationList.add(invigilation);
            invigilationList.add(invigilation1);
        }
        return Tool.result(invigilationMapper.insertInvigilation(invigilationList));
    }

    public String deleteInvigilation(String id) {
        return Tool.result(invigilationMapper.deleteInvigilation(Tool.getInteger(id)));
    }

    public String updateInvigilation(Integer id, Long teacherId, Integer classroomId, Integer competitionId, Integer isSame) {
        if (isSame != 1) {
            if (invigilationMapper.findAlreadyInvigilation(competitionId, teacherId) > 0) {
                return Tool.result("该老师已经被安排，不能重复安排");
            }
        }
        Invigilation invigilation = new Invigilation();
        invigilation.setId(id);
        invigilation.setTeacherId(teacherId);
        invigilation.setClassroomId(classroomId);
        return Tool.result(invigilationMapper.updateInvigilation(invigilation));
    }
}
