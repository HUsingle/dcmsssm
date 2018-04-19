package com.dcms.service.imp;

import com.dcms.dao.InvigilationMapper;
import com.dcms.model.Invigilation;
import com.dcms.service.InvigilationService;
import com.dcms.utils.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by single on 2018/4/19.
 */
@Service
public class InvigilationServiceImpl implements InvigilationService {
    @Autowired
    private InvigilationMapper invigilationMapper;

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

   /* public String autoArrangeInvigilation(Integer competitionId) {
        return null;
    }*/

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
