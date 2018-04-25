package com.dcms.dao;

import com.dcms.model.ClassroomArrange;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by single on 2018/4/14.
 */
@Repository
public interface ClassroomArrangeMapper {
    //根据组别、竞赛、考场查询考场安排信息
    List<ClassroomArrange> findClassroomArrange(@Param("competitionId") Integer competitionId, @Param("isSelectAll")Integer isSelectAll,
                                                @Param("groupName") String groupName,  @Param("array")Integer[] classroomId);

    //查询该竞赛该组别是否已经安排考场
    int findAlreadyClassroomArrangeNumByGroupName(@Param("competitionId") Integer competitionId,
                                                  @Param("groupName") String groupName);

    //查询该竞赛中该教室是否已经安排考场
    int findAlreadyClassroomArrangeNumByClassroomId(@Param("competitionId") Integer competitionId,
                                                    @Param("classroomId") Integer classroomId);

    //批量插入安排考场信息
    int insertClassroomArrange(List<ClassroomArrange> list);

    //批量删除考场安排信息
    int deleteClassroomArrange(Long[] id);

    //更新记录
    int updateClassroomArrange(ClassroomArrange classroomArrange);

    //该座位是否已经被安排
    int IsExistPeople(@Param("competitionId") Integer competitionId,
                      @Param("classroomId") Integer classroomId, @Param("seatNumber") Integer seatNumber);
    //导出考场安排信息
    List<ClassroomArrange> exportClassroomArrange(Integer competitionId);

    Integer[] getClassroomArrangeNum(Integer competitionId);

}
