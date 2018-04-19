package com.dcms.dao;

import com.dcms.model.Invigilation;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by single on 2018/4/18.
 */
@Repository
public interface InvigilationMapper {
    //查询监考安排信息
    List<Invigilation> findInvigilation(Integer competitionId);

    //查询该老师是否已经安排监考
    int findAlreadyInvigilation(@Param("competitionId") Integer competitionId,
                                                    @Param("teacherId") Long teacherId);

    //批量插入安排监考信息
    int insertInvigilation(List<Invigilation> list);

    //批量删除监考安排信息
    int deleteInvigilation(Integer[] id);

    //更新记录
    int updateInvigilation(Invigilation Invigilation);


}
