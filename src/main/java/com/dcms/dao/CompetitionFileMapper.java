package com.dcms.dao;

import com.dcms.model.CompetitionFile;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by single on 2018/3/29.
 */
@Repository
public interface CompetitionFileMapper {
    List<CompetitionFile> getAllCompetitionFile(@Param("sort") String sort);
    int deleteCompetitionFile(Integer[] ids);
    int addCompetitionFile(CompetitionFile CompetitionFile);
    int findCompetitionFileIsExist(String file);//添加时是否存在文件名一样的
    String findCompetitionFile(int id); //根据id查询文件名
}
