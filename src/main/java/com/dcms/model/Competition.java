package com.dcms.model;

import com.alibaba.fastjson.annotation.JSONField;

import java.sql.Timestamp;

public class Competition {
    private int cid;     //id
    private String name;  //竞赛名称
    @JSONField (format="yyyy-MM-dd HH:mm")               //fastjson自带格式化时间方式
    private Timestamp publishTime;  //发布时间
    @JSONField (format="yyyy-MM-dd HH:mm")
    private Timestamp compeStartTime;   //竞赛开始时间
    @JSONField (format="yyyy-MM-dd HH:mm")
    private Timestamp compeEndTime;     //竞赛结束时间
    private String host;   //主办方
    private String file;   //竞赛文件
    private String place;   //竞赛地点
    @JSONField (format="yyyy-MM-dd HH:mm")
    private Timestamp applyStart;    //报名开始时间
    @JSONField (format="yyyy-MM-dd HH:mm")
    private Timestamp applyEnd;    //报名结束时间
    private int isTeam;   //团队赛？
    private int tid;    //教师ID
    private String group; //组别

    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Timestamp getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Timestamp publishTime) {
        this.publishTime = publishTime;
    }

    public Timestamp getCompeStartTime() {
        return compeStartTime;
    }

    public void setCompeStartTime(Timestamp compeStartTime) {
        this.compeStartTime = compeStartTime;
    }

    public Timestamp getCompeEndTime() {
        return compeEndTime;
    }

    public void setCompeEndTime(Timestamp compeEndTime) {
        this.compeEndTime = compeEndTime;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public Timestamp getApplyStart() {
        return applyStart;
    }

    public void setApplyStart(Timestamp applyStart) {
        this.applyStart = applyStart;
    }

    public Timestamp getApplyEnd() {
        return applyEnd;
    }

    public void setApplyEnd(Timestamp applyEnd) {
        this.applyEnd = applyEnd;
    }

    public int getIsTeam() {
        return isTeam;
    }

    public void setIsTeam(int isTeam) {
        this.isTeam = isTeam;
    }

    public int getTid() {
        return tid;
    }

    public void setTid(int tid) {
        this.tid = tid;
    }
}
