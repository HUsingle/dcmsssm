package com.dcms.service;

import com.dcms.model.ClassroomArrange;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by single on 2018/4/14.
 */
public interface ClassroomArrangeService {
    //安排学生考场
    String arrangeExamRoom(Integer competitionId,String competitionGroup,String examRoom,String people);
    //通过竞赛id,组别，教室查看报名安排
    List<ClassroomArrange> findClassroomArrange(Integer competitionId, String groupName,String classroomId,Integer isSelectAll);
    //删除考场安排
    String deleteClassroomArrange(String id);
    //更新考场安排
    String updateClassroomArrange(Long id,Integer seatNumber,Integer classroomId,Integer competitionId);
    //导出考场信息
    void exportClassroomArrange(Integer competitionId, HttpServletResponse response);
}
