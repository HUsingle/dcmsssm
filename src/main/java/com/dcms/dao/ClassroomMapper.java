package com.dcms.dao;

import com.dcms.model.Classroom;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by single on 2018/3/1.
 */
@Repository
public interface ClassroomMapper {
    List<Classroom> getAllClassroom(@Param("sort") String sort);
    int updateClassroom(Classroom classroom);
    int deleteClassroom(Integer[] ids);
    int addClassroom(List<Classroom> classrooms);
    Classroom findClassroomById(Integer classroomId);
    int isExistSite(String site);
}
