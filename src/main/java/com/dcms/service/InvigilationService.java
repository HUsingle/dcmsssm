package com.dcms.service;

import com.dcms.model.Invigilation;

import java.util.List;

/**
 * Created by single on 2018/4/19.
 */
public interface InvigilationService {
    //查询监考安排信息
    List<Invigilation> findInvigilation(Integer competitionId);

    //批量插入安排监考信息
    String insertInvigilation(Integer competitionId, String teacherId, Integer classroomId);

    //自动安排监考
    //String autoArrangeInvigilation(Integer competitionId);

    //批量删除监考安排信息
    String deleteInvigilation(String id);

    //更新记录
    String updateInvigilation(Integer id,Long teacherId,Integer classroomId,Integer competitionId,Integer isSame);
}
