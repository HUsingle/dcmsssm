package com.dcms.model;

import com.alibaba.fastjson.annotation.JSONField;

import java.sql.Timestamp;

/**
 * Created by single on 2018/3/29.
 */
public class CompetitionFile {
    private int id;
    private String fileName;
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Timestamp uploadTime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Timestamp getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(Timestamp uploadTime) {
        this.uploadTime = uploadTime;
    }
}
