package com.dcms.model;

import com.alibaba.fastjson.annotation.JSONField;

import java.sql.Timestamp;

/**
 * Created by single on 2018/3/30.
 */
public class Apply {
    private int id;
    private long username;  //报名的学号
    private int competitionId; //报名竞赛id
    private String competitionGroup;//报名竞赛组别
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Timestamp applyTime; //报名时间
    private long teacherId;   //指导老师Id
    private int isGroupLeader; //是否为小组组长
    private String groupName;  //小组名称
    private int isRise;        //是否晋0级下一轮

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public long getUsername() {
        return username;
    }

    public void setUsername(long username) {
        this.username = username;
    }

    public int getCompetitionId() {
        return competitionId;
    }

    public void setCompetitionId(int competitionId) {
        this.competitionId = competitionId;
    }

    public String getCompetitionGroup() {
        return competitionGroup;
    }

    public void setCompetitionGroup(String competitionGroup) {
        this.competitionGroup = competitionGroup;
    }

    public Timestamp getApplyTime() {
        return applyTime;
    }

    public void setApplyTime(Timestamp applyTime) {
        this.applyTime = applyTime;
    }

    public long getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(long teacherId) {
        this.teacherId = teacherId;
    }

    public int getIsGroupLeader() {
        return isGroupLeader;
    }

    public void setIsGroupLeader(int isGroupLeader) {
        this.isGroupLeader = isGroupLeader;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public int getIsRise() {
        return isRise;
    }

    public void setIsRise(int isRise) {
        this.isRise = isRise;
    }
}
