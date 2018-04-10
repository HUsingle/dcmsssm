package com.dcms.model;

import com.alibaba.fastjson.annotation.JSONField;

import java.sql.Timestamp;

/**
 * Created by single on 2018/3/30.
 */
public class Apply {
    private long id;
    private long username;  //报名的学号
    private int competitionId; //报名竞赛id
    private String competitionGroup;//报名竞赛组别
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Timestamp applyTime; //报名时间
    private long teacherId;   //指导老师Id
    private int isGroupLeader; //是否为小组组长
    private String groupName;  //小组名称
    private int isRise;        //是否晋级下一轮
    private Teacher teacher;
    private Student student;
    private Competition competition;
    public Apply(){}
    public Apply(long id, long username, int competitionId,
                 String competitionGroup, Timestamp applyTime,
                 long teacherId, int isGroupLeader, String groupName, int isRise) {
        this.id = id;
        this.username = username;
        this.competitionId = competitionId;
        this.competitionGroup = competitionGroup;
        this.applyTime = applyTime;
        this.teacherId = teacherId;
        this.isGroupLeader = isGroupLeader;
        this.groupName = groupName;
        this.isRise = isRise;
    }
    public void setId(long id) {
        this.id = id;
    }

    public long getId() {
        return id;
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

    public Teacher getTeacher() {
        return teacher;
    }

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Competition getCompetition() {
        return competition;
    }

    public void setCompetition(Competition competition) {
        this.competition = competition;
    }
}
