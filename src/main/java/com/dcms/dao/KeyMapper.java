package com.dcms.dao;

import com.dcms.model.Key;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by single on 2018/4/20.
 */
@Repository
public interface KeyMapper {
    //根据竞赛Id和组别查询竞赛答案
    List<Key> getAllKey(@Param("competitionId") Integer competitionId,
                        @Param("groupName") String groupName, @Param("sort") String sort);

    //上传竞赛答案
    int addKey(Key key);

    //删除竞赛答案
    int deleteKey(Integer[] key);

    //通过答案文件id查询答案文件名字-
    String findKeyFileName(Integer id);

    //是否存在文件
    int isExistFile(Long username, Integer competitionId);
}
