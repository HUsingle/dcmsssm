package com.dcms.model;

import java.sql.Timestamp;

public class Competition {
    private int cid;
    private String name;  //竞赛名称
    private String content; //竞赛内容
    private Timestamp publishTime;
    private Timestamp competitionTime;
    private String host;
    private String file;
    private String place;
    private Timestamp applyStart;
    private Timestamp applyEnd;
    private int isTeam;

    public void setCid(int cid) {
        this.cid = cid;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setPublishTime(Timestamp publishTime) {
        this.publishTime = publishTime;
    }

    public void setCompetitionTime(Timestamp competitionTime) {
        this.competitionTime = competitionTime;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public void setFile(String file) {
        this.file = file;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public void setApplyStart(Timestamp applyStart) {
        this.applyStart = applyStart;
    }

    public void setApplyEnd(Timestamp applyEnd) {
        this.applyEnd = applyEnd;
    }

    public void setIsTeam(int isTeam) {
        this.isTeam = isTeam;
    }

    public int getCid() {
        return cid;
    }

    public String getName() {
        return name;
    }

    public String getContent() {
        return content;
    }

    public Timestamp getPublishTime() {
        return publishTime;
    }

    public Timestamp getCompetitionTime() {
        return competitionTime;
    }

    public String getHost() {
        return host;
    }

    public String getFile() {
        return file;
    }

    public String getPlace() {
        return place;
    }

    public Timestamp getApplyStart() {
        return applyStart;
    }

    public Timestamp getApplyEnd() {
        return applyEnd;
    }

    public int getIsTeam() {
        return isTeam;
    }
}
